trigger ECNGetOldValue on ECN_Line__c (before insert, before update) {

  if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    ECNLineTriggerHandler.updateOldValue(Trigger.new);
  }

}