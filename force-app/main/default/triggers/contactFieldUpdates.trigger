/*
 * This trigger updates:
 *   The account number field on the Contact if the Account is a Direct account
 *   The account record type field on the Contact
 *   Mobile Phone Email field on Contact (for SMS messaging)
 *   GDPR Confirmed Date field on Contact
 * Author : Steve Mason
 * since  : March 2019
 * E-Mail : smason@bristan.com
 */
trigger contactFieldUpdates on Contact (before insert, before update) {
    try {
        for(Contact con: trigger.new) {
            Account acc = [select Id, RecordType.Name, AccountNumber from Account where Id =: con.AccountId];
            con.Account_RecType__c = acc.RecordType.Name;  // Set record type field
            if(acc.RecordType.Name == 'Direct') {
                con.Account_Number__c = acc.AccountNumber; // Set account number field
            }
            if(con.MobilePhone != '' && con.MobilePhone != null) {
              con.Mobile_Phone_Email__c = con.MobilePhone.replace(' ','') + '@textmarketer.biz';
            } else {
              con.Mobile_Phone_Email__c = '';
            }
            if(Trigger.isInsert) {
                if(con.GDPR_Confirmed__c != '' && con.GDPR_Confirmed__c != null) {
                    con.GDPR_Confirmed_Date__c = System.today();
                }
            }
            if(Trigger.isUpdate) {
                Contact conOld = System.Trigger.oldMap.get(con.id);
                if(con.GDPR_Confirmed__c != conOld.GDPR_Confirmed__c ) {
                    con.GDPR_Confirmed_Date__c = System.today();
                }
            }      
        }
    }
    Catch(Exception e) {
        System.debug('************************** Exception in trigger on Contacts:'+e);
    }
}