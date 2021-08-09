/**
 * @author 
 * @since 
 */
@IsTest
private class CardPaymentTriggerTest {

    @TestSetup
    static void initData() {
        User adminUser = TestUtilityDataFactory.insertSystemUser('System Administrator', 'sad');
        User stdUser = TestUtilityDataFactory.insertSystemUser('Standard User', 'tmp');
        //  Assign user to Permission Set
        TestUtilityDataFactory.assignUserToPermissionSet(adminUser.Id, 'Create_Direct_Accounts');        
        TestUtilityDataFactory.assignUserToPermissionSet(stdUser.Id, 'Create_Direct_Accounts'); 
    }

    @IsTest
    static void shouldSetPaymentIsFromConsoleView() {
        
        User contextUser = [SELECT Id FROM User WHERE Alias = 'sad'];
        String recordId;

        System.runAs(contextUser) {
            Account account = TestUtilityDataFactory.createBusinessAccount('Direct');
            insert account;
            Contact contact = TestUtilityDataFactory.createContact();
            insert contact;
            TestUtilityDataFactory.insertOrderRecordsForAccount('Standard_Order', 'Pending', account.Id, 1);
            Order__c ord = [SELECT Id FROM Order__c WHERE Case_Account__c = :account.Id LIMIT 1];
            Income_Card_Payment__c inc = new Income_Card_Payment__c(
                Immediate_Amount__c = 100,
                Contact__c = contact.Id,
                Payment_Status__c = 'Authorised',
                Card_Type__c  = '',
                Authorisation_Date__c  = Date.today(),
                Transaction_Type__c  = 'Sale',
                Order__c = ord.Id
            );
            Test.startTest();
            insert inc;
            recordId = inc.Id;
            Test.stopTest();
        }
        Income_Card_Payment__c incAfterUpdate = [SELECT Id, Payment_Is_From_Console_View__c FROM  Income_Card_Payment__c WHERE Id = :recordId];

        System.assert(incAfterUpdate.Payment_Is_From_Console_View__c, 'record not updated');
    }


    @IsTest
    static void shouldSetPaymentIsFromConsoleViewAsFalse() {
        
        User contextUser = [SELECT Id FROM User WHERE Alias = 'tmp'];
        String recordId;

        System.runAs(contextUser) {
            Account account = TestUtilityDataFactory.createBusinessAccount('Direct');
            insert account;
            Contact contact = TestUtilityDataFactory.createContact();
            insert contact;
            TestUtilityDataFactory.insertOrderRecordsForAccount('Standard_Order', 'Pending', account.Id, 1);
            Order__c ord = [SELECT Id FROM Order__c WHERE Case_Account__c = :account.Id LIMIT 1];
            Income_Card_Payment__c inc = new Income_Card_Payment__c(
                Immediate_Amount__c = 100,
                Contact__c = contact.Id,
                Payment_Status__c = 'Authorised',
                Card_Type__c  = '',
                Authorisation_Date__c  = Date.today(),
                Transaction_Type__c  = 'Sale',
                Order__c = ord.Id
            );
            Test.startTest();
            insert inc;
            recordId = inc.Id;
            Test.stopTest();
        }
        Income_Card_Payment__c incAfterUpdate = [SELECT Id, Payment_Is_From_Console_View__c FROM  Income_Card_Payment__c WHERE Id = :recordId];

        System.assert(!incAfterUpdate.Payment_Is_From_Console_View__c, 'User not covered by trigger');
    }
     
}