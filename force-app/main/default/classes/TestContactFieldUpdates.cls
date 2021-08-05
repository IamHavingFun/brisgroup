/**
 * @author 
 * @since 
 */
@IsTest
private class TestContactFieldUpdates {

    @TestSetup
    static void initData() {
        //  Create PAS User
        User contextUser = TestUtilityDataFactory.insertSystemUser('Standard User', 'temp');
        //  Assign user to Permission Set
        TestUtilityDataFactory.assignUserToPermissionSet(contextUser.Id, 'Create_Direct_Accounts');        
    }

    @IsTest
    static void myUnitTest() {
        String recordId;
        User contextuser = [SELECT Id FROM User WHERE Alias = 'temp'];
        Test.startTest();
        System.runAs(contextuser) {
            Account acc = TestUtilityDataFactory.createBusinessAccount('Direct');
            acc.AccountNumber = '111111';
            insert acc;
            Contact con = TestUtilityDataFactory.createContact();
            con.FirstName = 'Bob';
            con.LastName = 'Hoskins';
            con.AccountId = acc.Id;
            con.GDPR_Confirmed__c = 'Verbal';
            insert con;
            con.MobilePhone = '07999876544';
            con.GDPR_Confirmed__c = 'Written';
            update con;
            recordId = con.Id;
        }
        Test.stopTest();
        Contact con = [SELECT Account_RecType__c, Account_Number__c, Mobile_Phone_Email__c, GDPR_Confirmed_Date__c FROM Contact WHERE Id = :recordId];
        System.assertEquals('Direct', con.Account_RecType__c, 'Account record type was not set');
        System.assertEquals('111111', con.Account_Number__c, 'Account Number was not set');
        System.assertEquals('07999876544@textmarketer.biz', con.Mobile_Phone_Email__c, 'Mobile_Phone_Email__c was not set');
        System.assertEquals(System.today(), con.GDPR_Confirmed_Date__c, 'GDPR_Confirmed_Date__c was not set');

    }
}