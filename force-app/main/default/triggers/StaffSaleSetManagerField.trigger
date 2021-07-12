trigger StaffSaleSetManagerField on Staff_Sale__c (before insert) {
  for (Staff_Sale__c ss : Trigger.new)
  {
    String userId = UserInfo.getUserId();
    User user = [SELECT Id, ManagerId from User where Id =: userId LIMIT 1];
    ss.Manager__c = user.ManagerId;
    String managerId = user.ManagerId;
    User manager = [SELECT Id, ManagerId from User where Id =: managerId LIMIT 1];
    ss.Manager_Manager__c = manager.ManagerId;
  }
}