/**
 * 
 * @author PolSource
 */
public with sharing class Account_RollupsHandler {

    private static final String COUNTER = 'counter';

    private Account_RollupsHandler() {}

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
