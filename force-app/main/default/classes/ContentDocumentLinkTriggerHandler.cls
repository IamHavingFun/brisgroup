/**
 * @author PolSource
 */
public with sharing class ContentDocumentLinkTriggerHandler {

    private ContentDocumentLinkTriggerHandler() {}

    /**
     * @param records 
     */
    public static void insertDocumentLinksForEmailMessages(List<ContentDocumentLink> records) {
        // All parent ids
        List<String> parentIds = new List<String>();
        for (ContentDocumentLink cv : records) {
            // ID of the linked object.
            parentIds.add(cv.LinkedEntityId);
        }
        // Map returns an EmailMessage given its ID
        Map<String, EmailMessage> emailMessages = new Map<String, EmailMessage>([SELECT Id, ParentId, Incoming FROM EmailMessage WHERE Id IN :parentIds]);
        List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
        for (ContentDocumentLink cv : records) {
            // Check the parent ID - if it's 02s, this is for an email message
            Id parent = cv.LinkedEntityId;
            String s = string.valueof(parent);
            if (s.substring(0,3) == '02s') {
                EmailMessage eml = emailMessages.get(parent);
                  String z = string.valueof(eml.parentID);
                  // Check if email parent is a case, if so reassign attachment to case
                if (z.substring(0,3) == '500' && eml.Incoming) {
                    //create ContentDocumentLink  record 
                    ContentDocumentLink conDocLink = New ContentDocumentLink();
                    // ID of the linked object.
                    conDocLink.LinkedEntityId = eml.ParentId;
                    //ContentDocumentId Id from ContentVersion
                    conDocLink.ContentDocumentId = cv.ContentDocumentId; 
                    // The file is available to all users who have permission to see the file.
                    conDocLink.Visibility = 'AllUsers';
                    // Viewer permission. The user can explicitly view but not edit the shared file.
                    conDocLink.shareType = 'V';
                    contentDocumentLinks.add(conDocLink);
                }
            }
        }
    
        // only executes the DML operation if there is one or more items in the list
        if (!contentDocumentLinks.isEmpty()) {
            try {
                // perform DML operation using a list, in that way, all records are inserted in a single transaction.
                insert contentDocumentLinks; 
            }
            catch(DMLException e) {
                system.debug('####### FAILED TO SAVE ATTACHMENT');
            } 
        }
    }
}