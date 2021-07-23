/**
 * @description trigger file for OrderLineDeleteTrigger SObject
 */
trigger OrderLineDeleteTrigger on Order_Line__c (before delete) {

  if (Trigger.isBefore && Trigger.isDelete) {
    // checks if context user has enough permissions to delete the records
    OrderLineTriggerHandler.validatePermissionBeforeDelete(Trigger.old);
  }
}