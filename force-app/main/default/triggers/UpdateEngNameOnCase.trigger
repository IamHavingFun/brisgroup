trigger UpdateEngNameOnCase on Engineer_Work_Order__c (after update) {

  if (Trigger.isAfter && Trigger.isUpdate) {
    EngineerWorkOrderTriggerHandler.updateEngineerNameOnCases(Trigger.new);
  }

}