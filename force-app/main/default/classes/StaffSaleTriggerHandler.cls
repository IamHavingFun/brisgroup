/**
 * @author PolSource
 */
public with sharing class StaffSaleTriggerHandler {

    private StaffSaleTriggerHandler() {}

    /**
     * @param records `List<Staff_Sale__c>` staff sale records to set Manager and Manager's Manager field value
     */
    public static void setManagersIds(List<Staff_Sale__c> records) {
        // get context user Id
        String userId = UserInfo.getUserId();
        // get context user's Manager and user's manager's Manager
        User user = [SELECT Id, ManagerId, Manager.ManagerId FROM User WHERE Id =: userId LIMIT 1];
      
        // Iterate the list of records to be updated
        for (Staff_Sale__c ss : records) {
          ss.Manager__c = user.ManagerId;
          ss.Manager_Manager__c = user.Manager.ManagerId;
        }        
    }
}