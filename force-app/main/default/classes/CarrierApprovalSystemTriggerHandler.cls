/**
 * @author PolSource
 */
public with sharing class CarrierApprovalSystemTriggerHandler {

    private CarrierApprovalSystemTriggerHandler() {}

    /**
     * @param records 
     */
    public static void setManager(List<Carrier_Approval_System__c> records) {
        // Returns the context user's ID
        String userId = UserInfo.getUserId();
        // get both user's manager and manager's manager
        User user = [SELECT Id, ManagerId, Manager.ManagerId FROM User WHERE Id =: userId LIMIT 1];
        for (Carrier_Approval_System__c carrierApproval : records) {
            // if user's manager has not been set, null is assigned
            carrierApproval.Manager__c = user.ManagerId;
            // if user's manager's manager has not been set null is assigned
            carrierApproval.Managers_Manager__c = user.Manager.ManagerId;
        }
    }

}
