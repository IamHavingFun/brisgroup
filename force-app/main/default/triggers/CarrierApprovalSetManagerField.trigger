trigger CarrierApprovalSetManagerField on Carrier_Approval_System__c (before insert) {
  for (Carrier_Approval_System__c ca : Trigger.new)
  {
    String userId = UserInfo.getUserId();
    User user = [SELECT Id, ManagerId from User where Id =: userId LIMIT 1];
    ca.Manager__c = user.ManagerId;
    String managerId = user.ManagerId;
    User manager = [SELECT Id, ManagerId from User where Id =: managerId LIMIT 1];
    ca.Managers_Manager__c = manager.ManagerId;
  }
}