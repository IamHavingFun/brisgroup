public with sharing class StaffSaleTriggerHandler {

    public static void setManagersIds(List<Staff_Sale__c> records) {
        String userId = UserInfo.getUserId();
        User user = [SELECT Id, ManagerId, Manager.ManagerId FROM User WHERE Id =: userId LIMIT 1];
      
        for (Staff_Sale__c ss : records) {    
          ss.Manager__c = user.ManagerId;
          ss.Manager_Manager__c = user.Manager.ManagerId;
        }        
    }
}
