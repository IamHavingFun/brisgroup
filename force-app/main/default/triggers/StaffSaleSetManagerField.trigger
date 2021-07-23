/**
 * @description trigger file for Staff_Sale__c SObject
 */
trigger StaffSaleSetManagerField on Staff_Sale__c (before insert) {
  
  if (Trigger.isBefore && Trigger.isInsert) {
    // set Manager__c and Manager_Manager__c values for each inserted Staff Sale record
    StaffSaleTriggerHandler.setManagersIds(Trigger.new);
  }
  
}