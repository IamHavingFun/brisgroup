/**
 * @description trigger file for ContentDocumentLink SObject 
 */
trigger emailAttachmentShare on ContentDocumentLink (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        // insert ContentDocumentLink records to link EmailMessage records
        ContentDocumentLinkTriggerHandler.insertDocumentLinksForEmailMessages(Trigger.new);
    }

}