/**
 * @author PolSource
 * @description Trigger file for Engineer_Work_Order__c SOBject
 */
trigger UpdateEngNameOnCase on Engineer_Work_Order__c (after update) {

  if (Trigger.isAfter && Trigger.isUpdate) {
    // send emails after records are updated.
    EngineerWorkOrderTriggerHandler.updateEngineerNameOnCases(Trigger.new);
  }

}