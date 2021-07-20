trigger ECNUpdateProductFields on ECN__c (before insert, before update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        ECNTriggerHandler.updateRelatedProducts(Trigger.new);
    }

}