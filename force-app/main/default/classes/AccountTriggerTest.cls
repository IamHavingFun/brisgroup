/**
 * @author PolSource
 */
@IsTest
public with sharing class AccountTriggerTest {

    private static final String ASSERT_CLEANSE_COMPLETE = 'Cleanse_Complete_Date__c must be set to Today';
    private static final String ASSERT_DATA_CLEANSE_DATE = 'Data_Cleanse_Date__c must be set to Today';
    private static final String ASSERT_DEACTIVATE_ACCOUNT_DATE = 'Deactivate_Account_Date__c must be set to Today';
    private static final String COUNTRY = 'USA';
    private static final String POSTAL_CODE = '000154';

    @TestSetup
    static void initData() {
        // Create Manager User
        User manager = TestUtilityDataFactory.insertSystemUser('Standard User', 'mngr');
        //  Create PAS User
        User contextUser = TestUtilityDataFactory.insertSystemUser('Standard User', 'temp');
        contextUser.ManagerId = manager.Id;
        update contextUser;
        //  Assign user to Permission Set
        TestUtilityDataFactory.assignUserToPermissionSet(contextUser.Id, 'Create_Direct_Accounts');        
    }

    @IsTest
    static void updateDateFieldsOnSaveTest() {
        Date todayDate;
        String newYork = 'New York';
        List<Account> accounts = new List<Account>();
        // create person account record
        Account personAccount = TestUtilityDataFactory.createPersonAccount();
        personAccount.Cleanse_Complete__c = true;
        personAccount.Data_Cleanse__c = true;
        personAccount.Deactivate_Account__c = true;
        personAccount.GDPR_Confirmed__pc = 'Verbal';
        personAccount.PersonMobilePhone = '07999876544';
        accounts.add(personAccount);
        // create Business Account record
        Account businessAccount = TestUtilityDataFactory.createBusinessAccount('Direct');
        businessAccount.Cleanse_Complete__c = true;
        businessAccount.Data_Cleanse__c = true;
        businessAccount.Deactivate_Account__c = true;
        businessAccount.Heritage_Customer__c = true;
        businessAccount.Heritage_New_Customer_Pack_Sent__c = false;
        businessAccount.Address_Line_1__c = 'Test Address';
        businessAccount.Address_Line_2__c = 'ADL #2';
        businessAccount.Town__c = newYork;
        businessAccount.County__c = newYork;
        businessAccount.Postcode__c = POSTAL_CODE;
        businessAccount.Countrynew__c = COUNTRY;
        accounts.add(businessAccount);
        //  Get context user
        User contextUser = [SELECT Id FROM User WHERE Alias = 'temp'];
        Test.startTest();
        System.runAs(contextUser) {
            todayDate = System.today();
            insert accounts;
        }
        Test.stopTest();
        personAccount = [SELECT Cleanse_Complete_Date__c, Data_Cleanse_Date__c, Deactivate_Account_Date__c, GDPR_Confirmed_Date__pc, Mobile_Phone_Email__pc FROM Account WHERE Id = :personAccount.Id];
        System.assertEquals(todayDate, personAccount.Cleanse_Complete_Date__c, ASSERT_CLEANSE_COMPLETE);
        System.assertEquals(todayDate, personAccount.Data_Cleanse_Date__c, ASSERT_DATA_CLEANSE_DATE);
        System.assertEquals(todayDate, personAccount.Deactivate_Account_Date__c, ASSERT_DEACTIVATE_ACCOUNT_DATE);
        System.assertEquals(todayDate, personAccount.GDPR_Confirmed_Date__pc, 'GDPR_Confirmed_Date__pc must be set to Today');
        System.assertEquals('07999876544@textmarketer.biz', personAccount.Mobile_Phone_Email__pc, 'Mobile_Phone_Email__pc must be set');
        businessAccount = [SELECT Cleanse_Complete_Date__c, Data_Cleanse_Date__c, Deactivate_Account_Date__c, Heritage_Customer_From__c, Heritage_New_Customer_Pack_Sent__c, BillingStreet, BillingCity,
                            BillingState, BillingPostalCode, BillingCountry
                           FROM Account WHERE Id = :businessAccount.Id];
        System.assertEquals(todayDate, businessAccount.Cleanse_Complete_Date__c, ASSERT_CLEANSE_COMPLETE);
        System.assertEquals(todayDate, businessAccount.Data_Cleanse_Date__c, ASSERT_DATA_CLEANSE_DATE);
        System.assertEquals(todayDate, businessAccount.Deactivate_Account_Date__c, ASSERT_DEACTIVATE_ACCOUNT_DATE);
        System.assertEquals(todayDate, businessAccount.Heritage_Customer_From__c, 'Heritage_Customer_From__c must be set to Today');
        System.assert(businessAccount.Heritage_New_Customer_Pack_Sent__c, 'Heritage_New_Customer_Pack_Sent__c must be TRUE');
        System.assertEquals('Test Address, ADL #2', businessAccount.BillingStreet, 'BillingStreet does not match');
        System.assertEquals(newYork, businessAccount.BillingCity, 'BillingCity does not match');
        System.assertEquals(newYork, businessAccount.BillingState, 'BillingState does not match');
        System.assertEquals(POSTAL_CODE, businessAccount.BillingPostalCode, 'BillingPostalCode does not match');
        System.assertEquals(COUNTRY, businessAccount.BillingCountry, 'BillingCountry does not match');
    }

    @IsTest
    static void updateDateFieldsOnUpdateTest() {
        String newYork = 'New York';
        Date todayDate;
        List<Account> accounts = new List<Account>();
        // create person account record
        Account personAccount = TestUtilityDataFactory.createPersonAccount();
        personAccount.PersonMobilePhone = '07999876544';
        accounts.add(personAccount);
        // create Business Account record
        Account businessAccount = TestUtilityDataFactory.createBusinessAccount('Direct');
        businessAccount.Address_Line_1__c = 'Test Address';
        businessAccount.Address_Line_2__c = 'ADL #2';
        businessAccount.Town__c = newYork;
        businessAccount.County__c = newYork;
        businessAccount.Postcode__c = POSTAL_CODE;
        businessAccount.Countrynew__c = COUNTRY;
        accounts.add(businessAccount);        
        //  Get context user
        User contextUser = [SELECT Id FROM User WHERE Alias = 'temp'];
        Test.startTest();
        System.runAs(contextUser) {
            todayDate = System.today();
            insert accounts;
            List<Account> updatedAccounts = new List<Account>();
            // Update person account fields
            personAccount.Cleanse_Complete__c = true;
            personAccount.Data_Cleanse__c = true;
            personAccount.Deactivate_Account__c = true;
            personAccount.GDPR_Confirmed__pc = 'Verbal';
            // update business account fields
            businessAccount.Cleanse_Complete__c = true;
            businessAccount.Data_Cleanse__c = true;
            businessAccount.Deactivate_Account__c = true;
            businessAccount.Heritage_Customer__c = true;
            businessAccount.Heritage_New_Customer_Pack_Sent__c = false;
            updatedAccounts.addAll(new List<Account>{personAccount, businessAccount});
            update updatedAccounts;

        }
        Test.stopTest();
        personAccount = [SELECT Cleanse_Complete_Date__c, Data_Cleanse_Date__c, Deactivate_Account_Date__c, GDPR_Confirmed_Date__pc, Mobile_Phone_Email__pc FROM Account WHERE Id = :personAccount.Id];
        System.assertEquals(todayDate, personAccount.Cleanse_Complete_Date__c, ASSERT_CLEANSE_COMPLETE);
        System.assertEquals(todayDate, personAccount.Data_Cleanse_Date__c, ASSERT_DATA_CLEANSE_DATE);
        System.assertEquals(todayDate, personAccount.Deactivate_Account_Date__c, ASSERT_DEACTIVATE_ACCOUNT_DATE);
        System.assertEquals(todayDate, personAccount.GDPR_Confirmed_Date__pc, 'GDPR_Confirmed_Date__pc must be set to Today');
        System.assertEquals('07999876544@textmarketer.biz', personAccount.Mobile_Phone_Email__pc, 'Mobile_Phone_Email__pc must be set');
        businessAccount = [SELECT Cleanse_Complete_Date__c, Data_Cleanse_Date__c, Deactivate_Account_Date__c, Heritage_Customer_From__c, Heritage_New_Customer_Pack_Sent__c, BillingStreet, BillingCity,
                            BillingState, BillingPostalCode, BillingCountry
                           FROM Account WHERE Id = :businessAccount.Id];
        System.assertEquals(todayDate, businessAccount.Cleanse_Complete_Date__c, ASSERT_CLEANSE_COMPLETE);
        System.assertEquals(todayDate, businessAccount.Data_Cleanse_Date__c, ASSERT_DATA_CLEANSE_DATE);
        System.assertEquals(todayDate, businessAccount.Deactivate_Account_Date__c, ASSERT_DEACTIVATE_ACCOUNT_DATE);
        System.assertEquals(todayDate, businessAccount.Heritage_Customer_From__c, 'Heritage_Customer_From__c must be set to Today');
        System.assert(businessAccount.Heritage_New_Customer_Pack_Sent__c, 'Heritage_New_Customer_Pack_Sent__c must be TRUE');
        System.assertEquals('Test Address, ADL #2', businessAccount.BillingStreet, 'BillingStreet does not match');
        System.assertEquals(newYork, businessAccount.BillingCity, 'BillingCity does not match');
        System.assertEquals(newYork, businessAccount.BillingState, 'BillingState does not match');
        System.assertEquals(POSTAL_CODE, businessAccount.BillingPostalCode, 'BillingPostalCode does not match');
        System.assertEquals(COUNTRY, businessAccount.BillingCountry, 'BillingCountry does not match');
    }

    @IsTest
    static void assignedToValuesTest() {        
        User contextuser = [SELECT Id, Name, ManagerName__c FROM User WHERE Alias = 'temp'];
        Account personAccount = TestUtilityDataFactory.createPersonAccount();
        Test.startTest();
        System.runAs(contextuser) {
            insert personAccount;
        }
        Test.stopTest();
        personAccount = [SELECT Assigned_To__c, ManagerName__c FROM Account WHERE Id = :personAccount.Id];
        System.assertEquals(contextuser.Name, personAccount.Assigned_To__c, 'Assigned_To__c value does not match');
        System.assertEquals(contextuser.ManagerName__c, personAccount.ManagerName__c, 'ManagerName__c value does not match');
    }

    @IsTest
    static void calculateRollUpsTest() {
        Integer totalOrders = 10, totalWarranties = 7, totalCases = 5, totalCalls = 12, totalChats = 3;
        Account personAccount = TestUtilityDataFactory.createPersonAccount();
        insert personAccount;
        String contactId = [SELECT Id FROM Contact WHERE AccountId = :personAccount.Id][0].Id;
        Test.startTest();
        TestUtilityDataFactory.insertOrderRecordsForAccount('Standard_Order', 'Pending', personAccount.Id, totalOrders);
        TestUtilityDataFactory.insertWarrantyRecordsForAccount(totalWarranties, contactId);
        TestUtilityDataFactory.insertCasesForAccount(totalCases, personAccount.Id, contactId);
        TestUtilityDataFactory.insertCallsForAccount(totalCalls, contactId);
        TestUtilityDataFactory.insertChatsForContact(totalChats, contactId);
        personAccount.Cleanse_Complete__c = true;
        update personAccount;
        Test.stopTest();
        personAccount = [SELECT Number_of_Orders__c, Number_of_Warranties__pc, Number_of_Cases__pc, Number_of_Calls__pc, Number_of_Live_Chats__pc FROM Account WHERE Id = :personAccount.Id];
        system.assertEquals(totalOrders, personAccount.Number_of_Orders__c, 'Number_of_Orders__c does not match');
        system.assertEquals(totalWarranties, personAccount.Number_of_Warranties__pc, 'Number_of_Warranties__pc does not match');
        system.assertEquals(totalCases, personAccount.Number_of_Cases__pc, 'Number_of_Cases__pc does not match');
        system.assertEquals(totalCalls, personAccount.Number_of_Calls__pc, 'Number_of_Calls__pc does not match');
        system.assertEquals(totalChats, personAccount.Number_of_Live_Chats__pc, 'Number_of_Live_Chats__pc does not match');
    }
}