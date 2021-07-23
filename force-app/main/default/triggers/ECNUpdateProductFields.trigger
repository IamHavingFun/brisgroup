/**
 * @author  PolSource
 */
trigger ECNUpdateProductFields on ECN__c (before insert, before update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        // Update fields on related product records based on the Field_to_Change__c values
        ECNTriggerHandler.updateRelatedProducts(Trigger.new);
    }

}