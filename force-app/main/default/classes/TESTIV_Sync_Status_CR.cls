/**
 * @author 
 * @since 
 */
@IsTest
private class TESTIV_Sync_Status_CR{

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
        BMCServiceDesk__Change_Request__c changeRequest = TestUtilityDataFactory.createChangeRequestRecord(stdUser.Id);
        System.runAs(contextuser){
            Test.startTest();
            insert changeRequest;
            changeRequest.CR_Status__c = 'AWAITING DELIVERY';
            update changeRequest;
            Test.stopTest();
        }
        
        String statusUpdate = [SELECT CR_Status__c FROM BMCServiceDesk__Change_Request__c WHERE Id = :changeRequest.Id].CR_Status__c;

        System.assertEquals('AWAITING DELIVERY', statusUpdate);

    }
}