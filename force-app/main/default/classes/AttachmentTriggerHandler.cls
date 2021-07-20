public with sharing class AttachmentTriggerHandler {

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
                    //a.parentid = [select parentID from EmailMessage where id = :a.parentid].parentID;
                    string fileString = EncodingUtil.Base64Encode(a.Body);
     
                    ContentVersion conVer = new ContentVersion();
                    conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
                    conVer.PathOnClient = a.Name; // The files name, extension is very important here which will help the file in preview.
                    conVer.Title = a.Description; // Display name of the files
                    conVer.VersionData = EncodingUtil.base64Decode(fileString); // converting your binary string to Blob
                    conVer.Description = eml.parentID;
                    contentVersions.add(conVer);
                }
            }
        }
    
        if (!contentVersions.isEmpty()) {
            try {
                insert contentVersions;
                // get Ids from the newly inserted records
                Set<Id> contentVersionIds = (new Map<Id, ContentVersion>(contentVersions)).keySet();
                // list to hold new content document link records
                List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
                for (ContentVersion conVer : [SELECT ContentDocumentId, Description FROM ContentVersion WHERE Id IN :contentVersionIds]) {
                    ContentDocumentLink conDocLink = New ContentDocumentLink();
                    conDocLink.LinkedEntityId = conVer.Description; // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
                    conDocLink.ContentDocumentId = conVer.ContentDocumentId;  //ContentDocumentId Id from ContentVersion
                    conDocLink.shareType = 'V';
                    contentDocumentLinks.add(conDocLink);
                }
        
                if (!contentDocumentLinks.isEmpty()) {
                    insert contentDocumentLinks;
                }            
            } catch (DmlException e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error uploading attachment!'));
                system.debug('####### FAILED TO SAVE ATTACHMENT');            
            }
        }        
    }
}
