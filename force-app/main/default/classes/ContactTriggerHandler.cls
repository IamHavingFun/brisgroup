/**
 * @author PolSource
 */
public with sharing class ContactTriggerHandler {

    private ContactTriggerHandler() {}

    /**
     * @param records update contact's properties
     */
    public static void updateContactFields(List<Contact> records) {
        try {
            // list of all account ids from the contact records
            List<String> accountIds = new List<String>();
            for (Contact con: records) {
                // Returns true if the specified String is not whitespace, not empty (''), and not null; otherwise, returns false.
                if (String.isNotBlank(con.AccountId)) {
                    // add Account Id to list
                    accountIds.add(con.AccountId);
                }
            }
            // Map that returns an Account record given its ID
            Map<String, Account> accountMap = new Map<String, Account>([SELECT Id, RecordType.Name, AccountNumber FROM Account WHERE Id IN :accountIds]);
            for (Contact con: records) {
                // get account record
                Account acc = accountMap.get(con.AccountId);
                // Set record type field
                con.Account_RecType__c = acc.RecordType.Name;
                if (acc.RecordType.Name == 'Direct') {
                    // Set account number field
                    con.Account_Number__c = acc.AccountNumber; 
                }
                // if contact record has value on MobilePhone property
                if (String.isNotBlank(con.MobilePhone)) {
                    // remove all whitespaces from MobilePhone field value and append a domain
                  con.Mobile_Phone_Email__c = con.MobilePhone.replace(' ','') + '@textmarketer.biz';
                } else {
                    // set field value to empty
                    con.Mobile_Phone_Email__c = '';
                }
                // If Insert operation and GDPR_Confirmed__c field has a value set
                if (Trigger.isInsert && con.GDPR_Confirmed__c != '' && con.GDPR_Confirmed__c != null) {
                    // set today's date to GDPR_Confirmed_Date__c
                    con.GDPR_Confirmed_Date__c = System.today();
                }
                if (Trigger.isUpdate) {
                    Contact conOld = (Contact) Trigger.oldMap.get(con.id);
                    // if GDPR_Confirmed__c field value has changed
                    if(con.GDPR_Confirmed__c != conOld.GDPR_Confirmed__c ) {
                        // set today's date to GDPR_Confirmed_Date__c
                        con.GDPR_Confirmed_Date__c = System.today();
                    }
                }      
            }
        } catch (Exception e) {
            System.debug('************************** Exception in trigger on Contacts:'+e);
        }        
    }
}
