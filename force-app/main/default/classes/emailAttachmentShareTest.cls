@istest
public class emailAttachmentShareTest {
        static testmethod void attachmentTester() {
            Case c = new Case();
            insert c;
            
            EmailMessage em = new EmailMessage();
            em.parentId = c.id;
            em.MessageDate = Date.today();
            em.FromAddress = 'test@from.com';
            em.ToAddress = 'test@to.com';
            em.Subject = 'test subject';
            em.TextBody = 'heres a text body.';
            em.Incoming = true;
            insert em;
        
            string fileString=EncodingUtil.Base64Encode(blob.valueof('attachment body'));     
 
            ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
            conVer.PathOnClient = 'test.txt'; // The files name, extension is very important here which will help the file in preview.
            conVer.Title = 'test file'; // Display name of the files
            conVer.VersionData = EncodingUtil.base64Decode(fileString); // converting your binary string to Blob
            try {
                insert conVer;    //Insert ContentVersion
            }
            catch(DMLException e) {
                system.debug('####### FAILED TO SAVE ATTACHMENT');
            } 
            // First get the Content Document Id from ContentVersion Object
            Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
            //create ContentDocumentLink  record 
            ContentDocumentLink conDocLink = New ContentDocumentLink();
            conDocLink.LinkedEntityId = em.Id; // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
            conDocLink.ContentDocumentId = conDoc;  //ContentDocumentId Id from ContentVersion
            conDocLink.shareType = 'V';
            conDocLink.Visibility = 'AllUsers';
            try {
                insert conDocLink; 
            }
            catch(DMLException e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment!'));
                system.debug('####### FAILED TO SAVE ATTACHMENT');
            }   
            
            //List<Attachment> attachments = [Select Id From Attachment Where parentId = :em.id];
            //system.debug('********* attachments: ' + attachments.size());
            //System.assert(attachments.size() == 1, 'Wrong number of attachments (( ' + attachments.size() );
        }   
    }