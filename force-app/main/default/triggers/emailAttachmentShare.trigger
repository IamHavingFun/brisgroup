trigger emailAttachmentShare on ContentDocumentLink (after insert) {
    for(ContentDocumentLink cv:trigger.new) {
        // Check the parent ID - if it's 02s, this is for an email message
 		Id parent = cv.LinkedEntityId;
        String s = string.valueof(parent);
        if(s.substring(0,3) == '02s') {
            EmailMessage eml = [select Id, ParentId, Incoming from EmailMessage where id = :parent];
          	String z = string.valueof(eml.parentID);
          	// Check if email parent is a case, if so reassign attachment to case
            if(z.substring(0,3) == '500' && eml.Incoming) {
	            //create ContentDocumentLink  record 
	            ContentDocumentLink conDocLink = New ContentDocumentLink();
	            conDocLink.LinkedEntityId = eml.ParentId;
	            conDocLink.ContentDocumentId = cv.ContentDocumentId;  //ContentDocumentId Id from ContentVersion
                conDocLink.Visibility = 'AllUsers';
	            conDocLink.shareType = 'V';
	            try {
	                insert conDocLink; 
	            }
	            catch(DMLException e) {
	                system.debug('####### FAILED TO SAVE ATTACHMENT');
	                continue;
	            } 
            }
        }
    }
}