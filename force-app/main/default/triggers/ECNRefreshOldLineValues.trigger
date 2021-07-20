trigger ECNRefreshOldLineValues on ECN__c (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        ECNTriggerHandler.updateChildLinesOldValue(Trigger.new);
    }
}