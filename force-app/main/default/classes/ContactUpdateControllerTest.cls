/**
 * @author 
 * @since 
 */
@IsTest(SeeAllData = true)
private class ContactUpdateControllerTest {
    @IsTest
    static void testUpdateContact() {
        // Insert Person Account
        Contact testContact = new Contact();  
        testContact.FirstName = 'Bob';
        testContact.LastName = 'Hoskins';
        testContact.Salutation = 'Mr'; 
        testContact.Email = 'cheese@burger.com'; 
        testContact.dupcheck__dc3DisableDuplicateCheck__c = false;
        insert(testContact);
        //Fetch and update person account
        Contact testContact2 = [SELECT FirstName, LastName, Salutation, Email, dupcheck__dc3DisableDuplicateCheck__c from Contact where Id = :testContact.Id LIMIT 1];
        PageReference pageRef = Page.ContactVFEdit; 
        Test.setCurrentPage(pageRef);
        Apexpages.StandardController stdController = new Apexpages.StandardController(testContact2);
        ContactUpdateController controller = new ContactUpdateController(stdController);
        controller.save();
        testContact2 = [SELECT dupcheck__dc3DisableDuplicateCheck__c FROM Contact WHERE Id = :testContact2.Id];
        System.assert(!testContact2.dupcheck__dc3DisableDuplicateCheck__c, 'Disable Duplicate Check field must be set to FALSE');
    }

    @IsTest
    static void testException() {
        // Force VF error
        Contact testContact3 = new Contact(); 
        PageReference pageRef2 = Page.ContactVFEdit; 
        Test.setCurrentPage(pageRef2);
        Apexpages.StandardController stdController2 = new Apexpages.StandardController(testContact3);
        ContactUpdateController controller2 = new ContactUpdateController(stdController2);
        PageReference pr  = controller2.save();
        System.assert(pr == null, 'Exception must have been thrown');
    }
}