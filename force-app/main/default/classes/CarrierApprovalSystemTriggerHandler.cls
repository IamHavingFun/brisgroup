public with sharing class CarrierApprovalSystemTriggerHandler {

    public static void setManager(List<Carrier_Approval_System__c> records) {
        String userId = UserInfo.getUserId();
        // get both user's manager and manager's manager
        User user = [SELECT Id, ManagerId, Manager.ManagerId FROM User WHERE Id =: userId LIMIT 1];
        for (Carrier_Approval_System__c carrierApproval : records) {
            carrierApproval.Manager__c = user.ManagerId;
            carrierApproval.Managers_Manager__c = user.Manager.ManagerId;
        }
    }

}
