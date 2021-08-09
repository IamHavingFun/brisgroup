/**
 * @author 
 * @since 
 */
@IsTest
private class TESTIV_Sync_Status {
    
    private static final String PROFILE_SYSTEM_ADMIN = 'System Administrator';

    @TestSetup
    static void makeData() {
        // Create Manager User
        User manager = TestUtilityDataFactory.insertSystemUser(PROFILE_SYSTEM_ADMIN, 'mngr');
        // Create Supervisor User
        User supervisor = TestUtilityDataFactory.insertSystemUser(PROFILE_SYSTEM_ADMIN, 'sup');
        // set manager's Id
        supervisor.ManagerId = manager.Id;
        update supervisor;
        // Create Agent User
        User agent = TestUtilityDataFactory.insertSystemUser(PROFILE_SYSTEM_ADMIN, 'adm');
        // set manager's Id
        agent.ManagerId = supervisor.Id;
        update agent;          
        TestUtilityDataFactory.insertSystemUser('Standard User', 'std');
    }

    @IsTest
    static void runTest(){

        User stdUser = [SELECT Id FROM User WHERE Alias = 'std'];
        User supUser = [SELECT Id FROM User WHERE Alias = 'sup'];
        User manUser = [SELECT Id FROM User WHERE Alias = 'mngr'];
        System.debug('TEST:stdUser: ' + stdUser);

        BMCServiceDesk__Incident__c incident = TestUtilityDataFactory.createIncidentRecord(stdUser.Id, supUser.Id, manUser.Id);

        User contextuser = [SELECT Id FROM User WHERE Alias = 'adm'];
        System.runAs(contextuser){
            Test.startTest();
            insert incident;
            incident.IN_Status__c = 'WAITING FOR CUSTOMER';
            update incident;
            Test.stopTest();
        }
       
        String statusUpdate = [SELECT IN_Status__c FROM BMCServiceDesk__Incident__c WHERE Id = :incident.Id].IN_Status__c;

        System.assertEquals('WAITING FOR CUSTOMER', statusUpdate);
    }
}