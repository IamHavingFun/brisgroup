/**
 * @author PolSource
 */
@IsTest(seeAllData = true)
private class AccountUpdateControllerTest {

    @IsTest
    static void testUpdatePersonAccount() {
        // Insert Person Account
        RecordType recType = [SELECT id, name, sobjectType, ispersontype FROM RecordType WHERE ispersontype = true AND sobjectType = 'account' LIMIT 1];
        Account testAccount = new Account();  
        testAccount.FirstName = 'Bob';
        testAccount.LastName = 'Hoskins';
        testAccount.Salutation = 'Mr'; 
        testAccount.PersonMobilePhone = '07969258019'; 
        testAccount.Mobile_2__c = '07969258019'; 
        testAccount.PersonHomePhone = '01827464415'; 
        testAccount.PersonEmail = 'bob@bobbie.com';
        testAccount.Data_Source__pc = 'Bristan Website';
        testAccount.RecordTypeId = recType.Id;
        testAccount.dupcheck__dc3DisableDuplicateCheck__c = true;
        insert(testAccount);
        //Fetch and update person account
        Account testAccount2 = [SELECT Id, FirstName, LastName, IsPersonAccount, dupcheck__dc3DisableDuplicateCheck__c, Salutation, PersonEmail, PersonMobilePhone, Mobile_2__c, PersonHomePhone, Data_Source__pc from Account where Id = :testAccount.Id LIMIT 1];
        PageReference pageRef = Page.Account_VF; 
        Test.setCurrentPage(pageRef);
        Apexpages.StandardController stdController = new Apexpages.StandardController(testAccount2);
        AccountUpdateController controller = new AccountUpdateController(stdController);
        controller.save();
        testAccount2 = [SELECT dupcheck__dc3DisableDuplicateCheck__c FROM Account WHERE Id = :testAccount2.Id LIMIT 1];
        System.assert(!testAccount2.dupcheck__dc3DisableDuplicateCheck__c, 'Disable Duplicate Check must be FALSE');
    }
    
    @IsTest
    static void testUpdateIndirectAccount() {
        // Insert Indirect Account
        RecordType recType = [SELECT id,name,sobjectType,ispersontype FROM recordType WHERE ispersontype = false AND sobjectType = 'account' AND name='Indirect' LIMIT 1];
        Account testAccount3 = new Account();  
        testAccount3.Name = 'Bob';
        testAccount3.Email__c = 'cheese@burger.com';
        testAccount3.dupcheck__dc3DisableDuplicateCheck__c = false;
        testAccount3.RecordTypeId = recType.Id;
        insert(testAccount3);
        //Fetch and update indirect account
        Account testAccount4 = [SELECT Id, Email__c, Name, dupcheck__dc3DisableDuplicateCheck__c, IsPersonAccount, RecordTypeId FROM Account WHERE Id = :testAccount3.Id LIMIT 1];
        PageReference pageRef2 = Page.Account_VF; 
        Test.setCurrentPage(pageRef2);
        Apexpages.StandardController stdController2 = new Apexpages.StandardController(testAccount4);
        AccountUpdateController controller2 = new AccountUpdateController(stdController2);
        controller2.save();
        testAccount4 = [SELECT dupcheck__dc3DisableDuplicateCheck__c FROM Account WHERE Id = :testAccount4.Id LIMIT 1];
        System.assert(!testAccount4.dupcheck__dc3DisableDuplicateCheck__c, 'Disable Duplicate Check must be FALSE');
    }

    @IsTest
    static void testUpdateOtherAccount() {
        // Insert Competitor Account
        RecordType recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=false and sobjectType='account' and name='Competitor' limit 1];
        Account testAccount5 = new Account();  
        testAccount5.Name = 'Bob';
        testAccount5.RecordTypeId = RecType.Id;
        insert(testAccount5);
        //Fetch and update indirect account
        Account testAccount6 = [SELECT Id, Name, IsPersonAccount, RecordTypeId from Account where Id = :testAccount5.Id LIMIT 1];
        PageReference pageRef3 = Page.Account_VF; 
        Test.setCurrentPage(pageRef3);
        Apexpages.StandardController stdController3 = new Apexpages.StandardController(testAccount6);
        AccountUpdateController controller3 = new AccountUpdateController(stdController3);
        PageReference response = controller3.save();
        System.assertEquals('/'+testAccount6.Id, response.getUrl(), 'Return Page Reference does not match');
    }
    
    @IsTest
    static void testException() {
        Account testAccount99 = new Account();
        PageReference pageRefError = Page.Account_VF; 
        Test.setCurrentPage(pageRefError);
        Apexpages.StandardController stdController99 = new Apexpages.StandardController(testAccount99); 
        AccountUpdateController controller99 = new AccountUpdateController(stdController99);    
        PageReference pr = controller99.save();
        System.assert(pr == null, 'Exception must have been thrown');
    }
}