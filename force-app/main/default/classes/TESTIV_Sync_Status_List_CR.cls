@IsTest
private class TESTIV_Sync_Status_List_CR{

    private static final String PROFILE_SYSTEM_ADMIN = 'System Administrator';

    @TestSetup
    static void makeData() {
        // Create Agent User
        TestUtilityDataFactory.insertSystemUser(PROFILE_SYSTEM_ADMIN, 'adm');
        TestUtilityDataFactory.insertSystemUser('Standard User', 'std');
    }

    @IsTest
    static void runTest(){
        User stdUser = [SELECT Id FROM User WHERE Alias = 'std'];
        User contextuser = [SELECT Id FROM User WHERE Alias = 'adm'];
        BMCServiceDesk__Status__c status = DataFactory.createStatus('Updated', false, true);
        insert status;

        BMCServiceDesk__Change_Request__c changeRequest = TestUtilityDataFactory.createChangeRequestRecord(stdUser.Id);
        System.runAs(contextuser){
            Test.startTest();
            insert changeRequest;
            changeRequest.BMCServiceDesk__FKStatus__c = status.Id;
            update changeRequest;
            Test.stopTest();
        }
        
        String statusUpdate = [SELECT BMCServiceDesk__FKStatus__c FROM BMCServiceDesk__Change_Request__c WHERE Id = :changeRequest.Id].BMCServiceDesk__FKStatus__c;

        System.assertEquals(status.Id, statusUpdate);

    }
}