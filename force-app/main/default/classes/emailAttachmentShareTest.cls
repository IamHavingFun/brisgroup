/**
 * @author 
 * @since 
 */
@IsTest
public class emailAttachmentShareTest {
    
    @IsTest
    static void attachmentTester() {
        Case c = new Case();
        insert c;
        
        EmailMessage em = new EmailMessage();
        em.ParentId = c.id;
        em.MessageDate = Date.today();
        em.FromAddress = 'test@from.com';
        em.ToAddress = 'test@to.com';
        em.Subject = 'test subject';
        em.TextBody = 'heres a text body.';
        em.Incoming = true;
        insert em;
    
        String fileString = EncodingUtil.Base64Encode(blob.valueof('attachment body'));     

        ContentVersion conVer = new ContentVersion();
        // to use S specify this document is in Salesforce, to use E for external files
        conVer.ContentLocation = 'S';
        // The files name, extension is very important here which will help the file in preview.
        conVer.PathOnClient = 'test.txt';
        // Display name of the files
        conVer.Title = 'test file';
        // converting your binary string to Blob
        conVer.VersionData = EncodingUtil.base64Decode(fileString);
        //Insert ContentVersion
        insert conVer;
        // First get the Content Document Id from ContentVersion Object
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
        //create ContentDocumentLink  record 
        ContentDocumentLink conDocLink = new ContentDocumentLink();
        // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
        conDocLink.LinkedEntityId = em.Id;
        //ContentDocumentId Id from ContentVersion
        conDocLink.ContentDocumentId = conDoc;
        conDocLink.shareType = 'V';
        conDocLink.Visibility = 'AllUsers';
        Test.startTest();
        insert conDocLink;
        Test.stopTest();
        List<ContentDocumentLink> records = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId = :c.Id];
        System.assertEquals(1, records.size(), 'No Content Document Link record created for Case');
    }   
}