// Jonathan Hersh - jhersh@salesforce.com
// November 13, 2008

trigger emailAttachmentReassigner on Attachment (before insert) {
    for( Attachment a : trigger.new ) {
        // Check the parent ID - if it's 02s, this is for an email message
        if( a.parentid == null )
            continue;
        
        String s = string.valueof( a.parentid );
        
        if( s.substring( 0, 3 ) == '02s' ) {
          EmailMessage eml = [select Id, parentID, Incoming from EmailMessage where id = :a.parentid];
          String z = string.valueof(eml.parentID);
          // Check if email parent is a case, if so reassign attachment to case
          if(z.substring(0,3) == '500' && eml.Incoming) {
            //a.parentid = [select parentID from EmailMessage where id = :a.parentid].parentID;
            
            string fileString=EncodingUtil.Base64Encode(a.Body);     
 
            ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
            conVer.PathOnClient = a.Name; // The files name, extension is very important here which will help the file in preview.
            conVer.Title = a.Description; // Display name of the files
            conVer.VersionData = EncodingUtil.base64Decode(fileString); // converting your binary string to Blob
            try {
                insert conVer;    //Insert ContentVersion
            }
            catch(DMLException e) {
                system.debug('####### FAILED TO SAVE ATTACHMENT');
                continue;
            } 
            // First get the Content Document Id from ContentVersion Object
            Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
            //create ContentDocumentLink  record 
            ContentDocumentLink conDocLink = New ContentDocumentLink();
            conDocLink.LinkedEntityId = [select parentID from EmailMessage where id = :a.parentid].parentID; // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
            conDocLink.ContentDocumentId = conDoc;  //ContentDocumentId Id from ContentVersion
            conDocLink.shareType = 'V';
            try {
                insert conDocLink; 
            }
            catch(DMLException e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment!'));
                system.debug('####### FAILED TO SAVE ATTACHMENT');
                continue;
            }   
          }
        }
    }
}