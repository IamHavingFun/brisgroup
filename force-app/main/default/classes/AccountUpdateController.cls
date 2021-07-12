public with sharing class AccountUpdateController {

    PageReference newPage;
    Account acct; 
    RecordType recType;
    RecordType recType2;    

    public AccountUpdateController (ApexPages.StandardController stdController) { 
        acct = (Account)stdController.getRecord(); 
    }

    public PageReference save() {
        try {
            recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=false and sobjectType='account' and name='Indirect' limit 1];
            recType2 = [select id,name,sobjectType,ispersontype from recordType where ispersontype=false and sobjectType='account' and name='Lead Indirect' limit 1];  
            if(acct.IsPersonAccount) {
                // Code for Duplicate Check
                dupcheck.dc3Api api = new dupcheck.dc3Api();
                ApexPages.Message prevention = api.doDuplicatePrevention(acct);
                if (prevention != null && !acct.dupcheck__dc3DisableDuplicateCheck__c) {
                   ApexPages.addMessage(prevention);
                   return null;
                }   
                // End Duplicate Check
                acct.dupcheck__dc3DisableDuplicateCheck__c = false;
                upsert(acct);     
                newPage = New PageReference('/'+acct.id);
                newPage.setRedirect(true);
                return newPage;
            }
            else {
                if(acct.recordtypeid == recType.id || acct.recordtypeid == recType2.id) {
                    // Code for Duplicate Check
                    dupcheck.dc3Api api = new dupcheck.dc3Api();
                    ApexPages.Message prevention = api.doDuplicatePrevention(acct);
                    if (prevention != null && !acct.dupcheck__dc3DisableDuplicateCheck__c) {
                       ApexPages.addMessage(prevention);
                       return null;
                    }   
                    // End Duplicate Check
                    acct.dupcheck__dc3DisableDuplicateCheck__c = false;
                    upsert(acct);     
                    newPage = New PageReference('/'+acct.id);
                    newPage.setRedirect(true);
                    return newPage;
                }
                else {
                    upsert(acct);     
                    newPage = New PageReference('/'+acct.id);
                    newPage.setRedirect(true);
                    return newPage;
                }
            }
        }
        catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }  
    }
}