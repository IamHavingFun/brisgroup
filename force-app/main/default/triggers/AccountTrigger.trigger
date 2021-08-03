/**
 * @author PolSource
 */
trigger AccountTrigger on Account (before insert, before update) {

    if (Trigger.isBefore && Trigger.isUpdate) {
        // Calculate Custom Rollup fields on Account records
        AccountTriggerHandler.calculateRollUps(Trigger.new);
        // 
        AccountTriggerHandler.setAccountDateFieldsOnUpdate(Trigger.new);
    }

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        // Set Assigned_To__c and ManagerName__c values based on Owner's Properties
        AccountTriggerHandler.setAssignedToValues(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isInsert) {
        // 
        AccountTriggerHandler.setAccountDateFieldsOnSave(Trigger.new);
    }
}