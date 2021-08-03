/**
 * @author PolSource
 */
trigger ECNGetOldValue on ECN_Line__c (before insert, before update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        // Update Old value based on Field to Change field value
        ECNLineTriggerHandler.updateOldValue(Trigger.new);
    }

}