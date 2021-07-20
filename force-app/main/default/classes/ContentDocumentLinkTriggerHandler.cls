public with sharing class ContentDocumentLinkTriggerHandler {

    public static void insertDocumentLinksForEmailMessages(List<ContentDocumentLink> records) {
        List<String> parentIds = new List<String>();
        for (ContentDocumentLink cv : records) {
            parentIds.add(cv.LinkedEntityId);
        }
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
                    conDocLink.LinkedEntityId = eml.ParentId;
                    conDocLink.ContentDocumentId = cv.ContentDocumentId;  //ContentDocumentId Id from ContentVersion
                    conDocLink.Visibility = 'AllUsers';
                    conDocLink.shareType = 'V';
                    contentDocumentLinks.add(conDocLink);
                }
            }
        }
    
        if (!contentDocumentLinks.isEmpty()) {
            try {
                insert contentDocumentLinks; 
            }
            catch(DMLException e) {
                system.debug('####### FAILED TO SAVE ATTACHMENT');
            } 
        }
    }
}
