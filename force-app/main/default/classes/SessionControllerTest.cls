/* Test class to test SessionController class
 * Author : Steve Mason
 * Since : Jun 2021
 * Email : smason@bristan.com
 */
@IsTest
private class SessionControllerTest {

    @TestSetup
    static void makeData() {
        User contextuser = TestUtilityDataFactory.insertSystemUser('System Administrator', 'sad');
        contextuser.Level__c = 'A';
        update contextuser;
        //  Assign user to Permission Set
        TestUtilityDataFactory.assignUserToPermissionSet(contextuser.Id, 'Create_Direct_Accounts');
    }

    @IsTest
    static void getUserDetailsTest() {   
        User contextuser = [SELECT Id, Level__c, Profile.Name FROM User WHERE Alias = 'sad'];
        User returnedUser;
        Test.startTest();
        System.runAs(contextuser) {
            returnedUser = SessionController.getUserDetails();    
        }
        Test.stopTest();
        System.assertEquals(contextuser.Level__c, returnedUser.Level__c, 'Level does not match');
        System.assertEquals(contextuser.Profile.Name, returnedUser.Profile.Name, 'Profile Name does not match');
    }

    @IsTest
    static void SessionControllerUnitTest() {
        //Getting order information
        // Account
        Account account = DataFactory.createAccount('TestAccount');
        insert account;
        // Case
        Case cs = DataFactory.createCase('Test Case');
        insert cs;
        //  Delivery Term
        Delivery_Term__c deliveryTerm = TestDataCreation.CreateDeliveryTermPST(); 
        // Create Order record
        Order__c order = DataFactory.createOrder(account, deliveryTerm, cs);
        insert order;
        // 
        Contact contact = DataFactory.createContact('FName', 'LName', account);
        insert contact;
        // Create Income Card Payment record
        Income_Card_Payment__c icp = DataFactory.createICP(15, contact, order);
        insert icp;
        
        String url = SessionController.makePaymentURL(order.Id);
        system.assertNotEquals(null, url);
        url = SessionController.deferredPaymentURL(order.Id);
        system.assertNotEquals(null, url);
        url = SessionController.refundURL(icp.Id);
        system.assertNotEquals(null, url);
        url = SessionController.releaseURL(icp.Id);
        system.assertNotEquals(null, url);
    }
}