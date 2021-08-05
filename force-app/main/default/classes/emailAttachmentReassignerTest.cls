/**
 * @author 
 * @since 
 */
@IsTest
public class emailAttachmentReassignerTest {
    
    private static final String CASE_RECORD_TYPE_GENERAL = 'Bristan_General';

    @IsTest
    static void attachmentTester() {
        Case testCase = TestUtilityDataFactory.createCase(CASE_RECORD_TYPE_GENERAL);
        insert testCase;
        
        EmailMessage em = new EmailMessage();
        em.ParentId = testCase.id;
        em.MessageDate = Date.today();
        em.FromAddress = 'test@from.com';
        em.ToAddress = 'test@to.com';
        em.Subject = 'test subject';
        em.TextBody = 'heres a text body.';
        insert em;
                
    
        Attachment a = new Attachment();
        a.Name = 'test attachment';
        a.Body = Blob.ValueOf('attachment body');
        a.ParentId = em.id;
        insert a;   
        
        List<Attachment> attachments = [SELECT Id FROM Attachment WHERE ParentId = :em.id];
        System.assert(!attachments.isEmpty(), 'No Attachments were found');
        System.assertEquals(1, attachments.size(), 'Wrong number of Attachment records');
        
    }   
}