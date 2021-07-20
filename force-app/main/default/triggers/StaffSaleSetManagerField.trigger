trigger StaffSaleSetManagerField on Staff_Sale__c (before insert) {
  
  if (Trigger.isBefore && Trigger.isInsert) {
    StaffSaleTriggerHandler.setManagersIds(Trigger.new);
  }
  
}