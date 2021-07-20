trigger OrderLineDeleteTrigger on Order_Line__c (before delete) {

  if (Trigger.isBefore && Trigger.isDelete) {
    OrderLineTriggerHandler.validatePermissionBeforeDelete(Trigger.old);
  }
}