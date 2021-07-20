trigger emailAttachmentShare on ContentDocumentLink (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        ContentDocumentLinkTriggerHandler.insertDocumentLinksForEmailMessages(Trigger.new);
    }

}