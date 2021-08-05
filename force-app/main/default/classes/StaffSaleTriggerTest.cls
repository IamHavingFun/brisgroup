/**
 * 
 * @author 
 * @since 
 */
@IsTest
public class StaffSaleTriggerTest {

    private static final String PROFILE_SYSTEM_ADMIN = 'System Administrator';

    @TestSetup
    static void initData() {
        // Create Manager User
        User manager = TestUtilityDataFactory.insertSystemUser(PROFILE_SYSTEM_ADMIN, 'mngr');
        // Create Supervisor User
        User supervisor = TestUtilityDataFactory.insertSystemUser(PROFILE_SYSTEM_ADMIN, 'sup');
        // set manager's Id
        supervisor.ManagerId = manager.Id;
        update supervisor;
        // Create Agent User
        User agent = TestUtilityDataFactory.insertSystemUser(PROFILE_SYSTEM_ADMIN, 'agt');
        // set manager's Id
        agent.ManagerId = supervisor.Id;
        update agent;         
    }

    @IsTest
    static void Test1() {
        Staff_Sale__c ss = new Staff_Sale__c();
        RecordType recordTypeSS = [SELECT Id from RecordType WHERE DeveloperName = 'Staff_Sales' LIMIT 1];
        User contextuser = [SELECT Id, ManagerId, Manager.ManagerId FROM User WHERE Alias = 'agt'];
        String recordId;
        Test.startTest();
        System.runAs(contextuser) {
            ss.RecordTypeId = recordTypeSS.Id;
            ss.Status__c = 'New';
            ss.Division__c = 'Bristan';
            ss.Sales_Type__c = 'Staff Sales';
            insert ss;
            recordId = ss.Id;
        }
        Test.stopTest();
        ss = [SELECT Manager__c, Manager_Manager__c FROM Staff_Sale__c WHERE Id = :recordId];
        System.assertEquals(contextuser.ManagerId, ss.Manager__c, 'Manager Id does not match');
        System.assertEquals(contextuser.Manager.ManagerId, ss.Manager_Manager__c, 'Manager\'s Manager Id does not match');
    }
}