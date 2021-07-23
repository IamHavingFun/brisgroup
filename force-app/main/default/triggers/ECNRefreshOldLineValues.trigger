/**
 * @author PolSource
 */
trigger ECNRefreshOldLineValues on ECN__c (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        // update value on Old Value field on all child records
        ECNTriggerHandler.updateChildLinesOldValue(Trigger.new);
    }
}