/**
 * @author PolSource
 */
trigger ECNTrigger on ECN__c (before insert, before update, after update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        // Update fields on related product records based on the Field_to_Change__c values
        ECNTriggerHandler.updateRelatedProducts(Trigger.new);
    }

    if (Trigger.isAfter && Trigger.isUpdate) {
        // update value on Old Value field on all child records
        ECNTriggerHandler.updateChildLinesOldValue(Trigger.new);
    }
    
}