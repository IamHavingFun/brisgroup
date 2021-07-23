// Jonathan Hersh - jhersh@salesforce.com
// November 13, 2008

trigger emailAttachmentReassigner on Attachment (before insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        // creates ContentDocumentLinks and ContentVersion records
        AttachmentTriggerHandler.createContentVersionAndLinkRecords(Trigger.new);
    }
    
}