/**
 * 
 * @author PolSource
 */
public with sharing class AccountTriggerHandler {

    private static final String COUNTER = 'counter';

    private AccountTriggerHandler() {}

    /**
     * @param records updated account records
     */
    public static void setAccountDateFieldsOnUpdate(List<Account> records) {
        Id directAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Direct').getRecordTypeId();
        for(Account acc: records) {
            Account accOld = (Account) Trigger.oldMap.get(acc.Id);
            // if Cleanse_Complete__c value was changed from FALSE to TRUE
            // Set cleanse complete date
            if (acc.Cleanse_Complete__c && !accOld.Cleanse_Complete__c) {
                acc.Cleanse_Complete_Date__c = System.today();
             }
             // if Data_Cleanse__c value was changed from FALSE to TRUE
             // Set data cleanse date
             if (acc.Data_Cleanse__c && !accOld.Data_Cleanse__c) {
                acc.Data_Cleanse_Date__c = System.today();
             }
             // if Deactivate_Account__c value was changed from FALSE to TRUE
             // Set date deactivated
             if (acc.Deactivate_Account__c && !accOld.Deactivate_Account__c) {
                acc.Deactivate_Account_Date__c = System.today();
             }
             // if Heritage_Customer__c value was changed from FALSE to TRUE and Heritage_New_Customer_Pack_Sent__c is FALSE and Record Type is DIRECT
             if (acc.RecordTypeId == directAccountRecordTypeId && acc.Heritage_Customer__c && !accOld.Heritage_Customer__c) {
                // Set heritage customer from date
                acc.Heritage_Customer_From__c = System.today();
                
                if (!acc.Heritage_New_Customer_Pack_Sent__c) {
                    acc.Heritage_New_Customer_Pack_Sent__c = true;
                }
             }
             // Copy custom address fields to billing address (for FindNearby app)
             if (!acc.IsPersonAccount) {
                acc.BillingStreet = acc.Address_Line_1__c  + ', ' + acc.Address_Line_2__c ;
                acc.BillingCity = acc.Town__c;
                acc.BillingState = acc.County__c;
                acc.BillingPostalCode = acc.Postcode__c;
                acc.BillingCountry = acc.Countrynew__c;
             }
            //  update Person Account fields
            updatePersonAccountFields(acc, accOld);

        }
    }

    /**
     * @param acc 
     */
    private static void updatePersonAccountFields(Account acc, Account accOld) {
        if (acc.IsPersonAccount) {
            // if GDPR_Confirmed__pc value has changed
            if (acc.GDPR_Confirmed__pc != accOld.GDPR_Confirmed__pc ) {
                acc.GDPR_Confirmed_Date__pc = System.today();
            }
            // if PersonMobilePhone has any value
            if (String.isNotBlank(acc.PersonMobilePhone)) {
                acc.Mobile_Phone_Email__pc = acc.PersonMobilePhone.replace(' ','') + '@textmarketer.biz';
            } else {
                acc.Mobile_Phone_Email__pc = '';
            }
        }        
    }

    /**
     * @param records newly created account records
     */
    public static void setAccountDateFieldsOnSave(List<Account> records) {
        Id directAccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Direct').getRecordTypeId();
        for (Account acc: records) {
            if (acc.Cleanse_Complete__c) {
                // Set cleanse complete date
                acc.Cleanse_Complete_Date__c = System.today();
            }
            if (acc.Data_Cleanse__c) {
                // Set data cleanse date
                acc.Data_Cleanse_Date__c = System.today();
            }
            if (acc.Deactivate_Account__c) {
                // Set date deactivated
                acc.Deactivate_Account_Date__c = System.today();
            }
            if (acc.RecordTypeId == directAccountRecordTypeId && acc.Heritage_Customer__c) {
                // Set customer pack sent field
                if (!acc.Heritage_New_Customer_Pack_Sent__c) {
                    acc.Heritage_New_Customer_Pack_Sent__c = true;
                }
                // Set heritage customer from date
                acc.Heritage_Customer_From__c = System.today();
            }
            if (!acc.IsPersonAccount) {
                // Copy custom address fields to billing address (for FindNearby app)
                acc.BillingStreet = acc.Address_Line_1__c  + ', ' + acc.Address_Line_2__c ;
                acc.BillingCity = acc.Town__c;
                acc.BillingState = acc.County__c;
                acc.BillingPostalCode = acc.Postcode__c;
                acc.BillingCountry = acc.Countrynew__c;
            }
            // Set Person Account fields
            if (acc.IsPersonAccount) {
                // if GDPR_Confirmed__pc has any value
                if (String.isNotEmpty(acc.GDPR_Confirmed__pc)) {
                    acc.GDPR_Confirmed_Date__pc = System.today();
                }
                // checks if PersonMobilePhone has any value
                if (String.isNotBlank(acc.PersonMobilePhone)) {
                  acc.Mobile_Phone_Email__pc = acc.PersonMobilePhone.replace(' ','') + '@textmarketer.biz';
                } else {
                  acc.Mobile_Phone_Email__pc = '';
                }
            }
        }
    }

    /**
     * @param records 
     */
    public static void setAssignedToValues(List<Account> records) {
        List<String> ownerIds = getOwnerIds(records);
        // create a map of user records by Id
        Map<String, User> usersById = new Map<String, User>([SELECT Id, Name, ManagerName__c FROM User WHERE Id IN :ownerIds]);
        for (Account account : records) {
            // check if user was returned by the SOQL query
            if (usersById.containsKey(account.OwnerId)) {
                // get User record and set account's properties
                User ownerUser  = usersById.get(account.OwnerId);
                account.Assigned_To__c  = ownerUser.Name;
                account.ManagerName__c  = ownerUser.ManagerName__c;
            }
        }
    }

    /**
     * @param records account records
     * @return  `List<String>` List of all Owner Ids
     */
    private static List<String> getOwnerIds(List<Account> records) {
        List<String> ownerIds = new List<String>();
        for (Account account : records) {
            ownerIds.add(account.OwnerId);
        }
        return ownerIds;
    }

    /**
     * @param accounts list of Account records before an INSERT or UPDATE operation
     */
    public static void calculateRollUps(List<Account> accounts) {
        Set<String> accountIds = new Set<String>();
        Set<String> contactIds = new Set<String>();
        // get Account and Contact ids to be include in calculations
        for (Account account : accounts) {
          if (account.IsPersonAccount) {
              accountIds.add(account.Id);
              contactIds.add(account.PersonContactId);
          }
        }
        // Maps to hold total Order records by account Id
        Map<String, Integer> numberOfOrdersByAccount = getTotalOrdersByAccount(accountIds);
        // Maps to hold total Warranty records for each Contact Id
        Map<String, Integer> numberOfWarrantiesByContact = getTotalWarrantiesByContact(contactIds);
        // Maps to hold total Case records for each Contact Id
        Map<String, Integer> numberOfCasesByContact = getTotalCasesByContact(contactIds);
        // Maps to hold total Call records for each Contact Id
        Map<String, Integer> numberOfCallsByContact = getTotalCallsByContact(contactIds);
        // Maps to hold total Live Chat records for each Contact Id
        Map<String, Integer> numberOfLiveChatsByContact = getTotalLiveChatsByContact(contactIds);

        // Update Account's properties
        for (Account account : accounts) {
            String accId = account.Id;
            String conId = account.PersonContactId;
            if (numberOfOrdersByAccount.containsKey(accId)) {
                account.Number_of_Orders__c = numberOfOrdersByAccount.get(accId);
            }
            if (numberOfWarrantiesByContact.containsKey(conId)) {
                account.Number_of_Warranties__pc = numberOfWarrantiesByContact.get(conId);
            }
            if (numberOfCasesByContact.containsKey(conId)) {
                account.Number_of_Cases__pc = numberOfCasesByContact.get(conId);
            }
            if (numberOfCallsByContact.containsKey(conId)) {
                account.Number_of_Calls__pc = numberOfCallsByContact.get(conId);
            }
            if (numberOfLiveChatsByContact.containsKey(conId)) {
                account.Number_of_Live_Chats__pc = numberOfLiveChatsByContact.get(conId);
            }
        }
    }

    /**
     * @param accountIds list of person accounts to be included in SOQL Query
     * @return  `Map<String, Integer>` number of Orders By Account
     */
    private static Map<String, Integer> getTotalOrdersByAccount(Set<String> accountIds) {
        Map<String, Integer> numberOfOrdersByAccount = new Map<String, Integer>();
        for (AggregateResult numberOfOrdersResult : [SELECT Case_Account__c, COUNT(Id) counter FROM Order__c  WHERE Case_Account__c IN :accountIds GROUP BY Case_Account__c]) {
            numberOfOrdersByAccount.put((String) numberOfOrdersResult.get('Case_Account__c'), (Integer) numberOfOrdersResult.get(COUNTER));
        }
        return numberOfOrdersByAccount;
    }

    /**
     * @param contactIds list of Contact Ids to count number of warranties from
     * @return  `Map<String, Integer>` Number of Warranty records owned by contacts
     */
    private static Map<String, Integer> getTotalWarrantiesByContact(Set<String> contactIds) {
        Map<String, Integer> numberOfWarrantiesByContact = new Map<String, Integer>();
        for (AggregateResult numberOfWarrantiesResult : [SELECT Contact__c, COUNT(Id) counter FROM Warranty__c WHERE Contact__c IN :contactIds GROUP BY Contact__c]) {
            numberOfWarrantiesByContact.put((String) numberOfWarrantiesResult.get('Contact__c'), (Integer) numberOfWarrantiesResult.get(COUNTER));
        }        
        return numberOfWarrantiesByContact;
    }

    /**
     * @param contactIds list of Contact Ids to count number of cases from
     * @return  `Map<String, Integer>` Number of Case records owned by contacts
     */
    private static Map<String, Integer> getTotalCasesByContact(Set<String> contactIds) {
        Map<String, Integer> numberOfCasesByContact = new Map<String, Integer>();
        // Populate number of Cases by Contact
        for (AggregateResult numberOfCasesResult : [SELECT ContactId, COUNT(Id) counter FROM Case WHERE ContactId IN :contactIds GROUP BY ContactId]) {
            numberOfCasesByContact.put((String) numberOfCasesResult.get('ContactId'), (Integer) numberOfCasesResult.get(COUNTER));
        }
        return numberOfCasesByContact;
    }

    /**
     * @param contactIds list of Contact Ids to count number of cases from
     * @return  `Map<String, Integer>` Number of Call records owned by contacts
     */
    private static Map<String, Integer> getTotalCallsByContact(Set<String> contactIds) {
        Map<String, Integer> numberOfCallsByContact = new Map<String, Integer>();
        // Populate number of Calls by Contact
        for (AggregateResult numberOfCallsResult : [SELECT Contact__c, COUNT(Id) counter FROM Calls__c WHERE Contact__c IN :contactIds GROUP BY Contact__c]) {
            numberOfCallsByContact.put((String) numberOfCallsResult.get('Contact__c'), (Integer) numberOfCallsResult.get(COUNTER));
        }
        return numberOfCallsByContact;
    }

    /**
     * @param contactIds list of Contact Ids to count number of cases from
     * @return  `Map<String, Integer>` Number of Live Chat records owned by contacts
     */
    private static Map<String, Integer> getTotalLiveChatsByContact(Set<String> contactIds) {
        Map<String, Integer> numberOfLiveChatsByContact = new Map<String, Integer>();
        // Populate number of Live Chats by Contact
        for (AggregateResult numberOfLiveChatsResult : [SELECT ContactId, COUNT(Id) counter FROM LiveChatTranscript WHERE ContactId IN :contactIds GROUP BY ContactId]) {
            numberOfLiveChatsByContact.put((String) numberOfLiveChatsResult.get('ContactId'), (Integer) numberOfLiveChatsResult.get(COUNTER));
        }
        return numberOfLiveChatsByContact;
    }
}
