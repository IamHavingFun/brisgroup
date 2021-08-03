/**
 * @author  PolSource
 */
trigger CaseTrigger on Case (before insert, before update, after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        // copy all case comments from a cloned case to the new case
        CaseTriggerHandler.copyAllCommentsFromCase(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        // Update information on related Contact and Account records
        CaseTriggerHandler.updateDatesOnContactAndAccounts(Trigger.new);
    }

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        // Update Closed By value on all Cases before they are persisted to the database
        CaseTriggerHandler.updateClosedBy(Trigger.new);
    }

}