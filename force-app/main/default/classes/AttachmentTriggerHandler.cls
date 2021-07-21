/**
 * @author PolSource
 */
public with sharing class AttachmentTriggerHandler {

    private AttachmentTriggerHandler() {}

    /**
     * @param records given a list of attachment, this method creates ContentDocumentLinks and ContentVersion records
     */
    public static void createContentVersionAndLinkRecords(List<Attachment> records) {
        List<String> parentIds = new List<String>();
        for (Attachment a : records) {
            if (String.isNotBlank(a.ParentId)) {
                parentIds.add(a.ParentId);
            }
        }
        Map<String, EmailMessage> emailMessages = new Map<String, EmailMessage>([SELECT Id, parentID, Incoming FROM EmailMessage WHERE id IN :parentIds]);
        List<ContentVersion> contentVersions = new List<ContentVersion>();
    
        for (Attachment a : records) {
            // Check the parent ID - if it's 02s, this is for an email message
            if (a.parentid == null ) {
                continue;
            }
            
            String s = string.valueof( a.parentid );
            
            if (s.substring( 0, 3 ) == '02s') {
                EmailMessage eml = emailMessages.get(a.ParentId);
                String z = string.valueof(eml.parentID);
                // Check if email parent is a case, if so reassign attachment to case
                if (z.substring(0,3) == '500' && eml.Incoming) {

                    // Converts a Blob to an unencoded String representing its normal form.
                    string fileString = EncodingUtil.Base64Encode(a.Body);
     
                    ContentVersion conVer = new ContentVersion();
                    // Origin of the document: Document is located within Salesforce. Label is Salesforce.
                    conVer.ContentLocation = 'S';
                    // The files name, extension is very important here which will help the file in preview. 
                    conVer.PathOnClient = a.Name;
                    // Display name of the files
                    conVer.Title = a.Description; 
                    // converting your binary string to Blob
                    conVer.VersionData = EncodingUtil.base64Decode(fileString);
                    conVer.Description = eml.parentID;
                    contentVersions.add(conVer);
                }
            }
        }
    
        // check if any items were added to the list
        if (!contentVersions.isEmpty()) {
            try {
                // perform DML Operation upon a list of records
                insert contentVersions;
                // get Ids from the newly inserted records
                Set<Id> contentVersionIds = (new Map<Id, ContentVersion>(contentVersions)).keySet();
                // list to hold new content document link records
                List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
                for (ContentVersion conVer : [SELECT ContentDocumentId, Description FROM ContentVersion WHERE Id IN :contentVersionIds]) {
                    ContentDocumentLink conDocLink = New ContentDocumentLink();
                    // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
                    conDocLink.LinkedEntityId = conVer.Description; 
                    //ContentDocumentId Id from ContentVersion
                    conDocLink.ContentDocumentId = conVer.ContentDocumentId; 
                    // The permission granted to the user of the shared file in a library: Viewer permission. The user can explicitly view but not edit the shared file.
                    conDocLink.shareType = 'V';
                    contentDocumentLinks.add(conDocLink);
                }
                // check if any items were added to the list
                if (!contentDocumentLinks.isEmpty()) {
                    // perform DML Operation upon a list of records
                    insert contentDocumentLinks;
                }            
            } catch (DmlException e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error uploading attachment!'));
                system.debug('####### FAILED TO SAVE ATTACHMENT');            
            }
        }        
    }
}
