/**
 * @description Apex class provides code an use case coverage for Carrier_Approval_System__c trigger
 */
@IsTest
public class CarrierApprovalTriggerTest {

    private static final String PROFILE_SYSTEM_ADMIN = 'System Administrator';
    /**
     * @description when running user has a Manager and its Manager also has a Manager assigned
     * those ids should be set on Carrier_Approval_System__c record
     */
    @IsTest
    public static void managerFieldsShouldNotEmpty() {
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
        Test.startTest();
        System.runAs(agent) {
            Carrier_Approval_System__c ca = TestUtilityDataFactory.createNextDayApprovalSystem('New');
            // Test Before Insert trigger's use case
            insert ca;
        }
        Test.stopTest();
        Carrier_Approval_System__c updatedApprovalSystem = [SELECT Id, Manager__c, Managers_Manager__c FROM Carrier_Approval_System__c LIMIT 1][0];
        System.assert(String.isNotBlank(updatedApprovalSystem.Manager__c), 'Manager\'s Id must not be empty');
        System.assert(String.isNotBlank(updatedApprovalSystem.Managers_Manager__c), 'Manager\'s Manager\'s Id must not be empty');
    }

    /**
     * @description when running user has not a manager assigned Carrier_Approval_System__c 
     * record should not have their Manager and Manager's Manager Ids fields populated
     */
    @IsTest
    public static void managerFieldsShouldBeEmpty(){
        // Create Agent User
        User agent = TestUtilityDataFactory.insertSystemUser(PROFILE_SYSTEM_ADMIN, 'agt');
        Test.startTest();
        System.runAs(agent){
            Carrier_Approval_System__c ca = TestUtilityDataFactory.createNextDayApprovalSystem('New');
            // Test Before Insert trigger's use case
            insert ca;
        }
        Test.stopTest();
        Carrier_Approval_System__c updatedApprovalSystem = [SELECT Id, Manager__c, Managers_Manager__c FROM Carrier_Approval_System__c LIMIT 1][0];
        System.assert(String.isBlank(updatedApprovalSystem.Manager__c), 'User does not have a manager assigned');
        System.assert(String.isBlank(updatedApprovalSystem.Managers_Manager__c), 'Manager\'s Manager Id must be empty');
    }
}