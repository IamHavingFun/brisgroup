// Jonathan Hersh - jhersh@salesforce.com
// November 13, 2008

trigger emailAttachmentReassigner on Attachment (before insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        AttachmentTriggerHandler.createContentVersionAndLinkRecords(Trigger.new);
    }
    
}