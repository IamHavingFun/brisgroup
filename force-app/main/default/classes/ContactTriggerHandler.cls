public with sharing class ContactTriggerHandler {

    public static void updateContactFields(List<Contact> records) {
        try {
            List<String> accountIds = new List<String>();
            for(Contact con: records) {
                if (String.isNotBlank(con.AccountId)) {
                    accountIds.add(con.AccountId);
                }
            }
            Map<String, Account> accountMap = new Map<String, Account>([SELECT Id, RecordType.Name, AccountNumber FROM Account WHERE Id IN :accountIds]);
            for(Contact con: records) {
                Account acc = accountMap.get(con.AccountId);
                con.Account_RecType__c = acc.RecordType.Name;  // Set record type field
                if(acc.RecordType.Name == 'Direct') {
                    con.Account_Number__c = acc.AccountNumber; // Set account number field
                }
                if (con.MobilePhone != '' && con.MobilePhone != null) {
                  con.Mobile_Phone_Email__c = con.MobilePhone.replace(' ','') + '@textmarketer.biz';
                } else {
                  con.Mobile_Phone_Email__c = '';
                }
                if (Trigger.isInsert) {
                    if(con.GDPR_Confirmed__c != '' && con.GDPR_Confirmed__c != null) {
                        con.GDPR_Confirmed_Date__c = System.today();
                    }
                }
                if (Trigger.isUpdate) {
                    Contact conOld = (Contact) Trigger.oldMap.get(con.id);
                    if(con.GDPR_Confirmed__c != conOld.GDPR_Confirmed__c ) {
                        con.GDPR_Confirmed_Date__c = System.today();
                    }
                }      
            }
        } catch(Exception e) {
            System.debug('************************** Exception in trigger on Contacts:'+e);
        }        
    }
}
