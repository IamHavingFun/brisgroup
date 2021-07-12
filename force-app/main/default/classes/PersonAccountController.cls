public with sharing class PersonAccountController {

    RecordType recType;
    RecordType recType2;    
    RecordType recType3;
    RecordType recType4;    
    ApexPages.StandardController c;
    PageReference page; 
    PageReference newPage;
    string id; 
    Account acct; 
    public String salutation {get; set;}
    public String fname{get; set;}
    public String lname{get; set;}
    public String mphone{get; set;}    
    public String mphone2{get; set;}    
    public String hphone{get; set;}        

    public PersonAccountController (ApexPages.StandardController stdController) { 
        acct = (Account)stdController.getRecord(); 
        c = stdController;
        page = ApexPages.currentPage();
        id = page.getParameters().get('id');        
    }

    public PageReference save() {
        try {
            recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' and name='Person Account' limit 1];
            recType2 = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' and name='Lead Person Account' limit 1];            
            recType3 = [select id,name,sobjectType,ispersontype from recordType where ispersontype=false and sobjectType='account' and name='Indirect' limit 1];
            recType4 = [select id,name,sobjectType,ispersontype from recordType where ispersontype=false and sobjectType='account' and name='Lead Indirect' limit 1];                        
            if(acct.recordtypeid == recType.id || acct.recordtypeid == recType2.id) {
                acct.Salutation=salutation;
                acct.FirstName=fname;
                acct.LastName=lname;
                if(mphone=='' || mphone==null) {
                  acct.PersonMobilePhone=page.getParameters().get('PersonMobilePhone');
                }
                else
                {
                  acct.PersonMobilePhone=mphone;
                }
                if(mphone2=='' || mphone2==null) {
                  acct.Mobile_2__c=page.getParameters().get('Mobile_2__c');
                }
                else
                {
                  acct.Mobile_2__c=mphone2;
                }
                if(hphone=='' || hphone==null) {
                  acct.PersonHomePhone=page.getParameters().get('PersonHomePhone');
                }
                else
                {
                  acct.PersonHomePhone=hphone;
                }             
                // Code for Duplicate Check
                dupcheck.dc3Api api = new dupcheck.dc3Api();
                ApexPages.Message prevention = api.doDuplicatePrevention(acct);
                if (prevention != null && !acct.dupcheck__dc3DisableDuplicateCheck__c) {
                   ApexPages.addMessage(prevention);
                   return null;
                }   
                // End Duplicate Check
                acct.dupcheck__dc3DisableDuplicateCheck__c = false;
                insert(acct);     
                newPage = New PageReference('/'+acct.id);
                newPage.setRedirect(true);
                return newPage;
            }
            else {
                try {
                    if(acct.recordtypeid == recType3.id || acct.recordtypeid == recType4.id) {
                        // Code for Duplicate Check
                        dupcheck.dc3Api api = new dupcheck.dc3Api();
                        ApexPages.Message prevention = api.doDuplicatePrevention(acct);
                        if (prevention != null && !acct.dupcheck__dc3DisableDuplicateCheck__c) {
                           ApexPages.addMessage(prevention);
                           return null;
                        }   
                        // End Duplicate Check
                        acct.dupcheck__dc3DisableDuplicateCheck__c = false;
                        insert(acct);
                    }
                    else {
                        insert(acct);
                    }
                }
                catch(System.DMLException e) {
                    ApexPages.addMessages(e);
                     return null;
                }  
                newPage = New PageReference('/'+acct.id);
                newPage.setRedirect(true);
                return newPage;
            }
        }
        catch(System.DMLException e) {
                ApexPages.addMessages(e);
                return null;
        }  
        newPage = New PageReference('/'+acct.id);
        newPage.setRedirect(true);
        return newPage;
    }

}