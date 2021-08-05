/**
 * @author 
 * @since 
 */
@IsTest
private class Test_Lock_Request_On_Completion {

    @IsTest
    static void myUnitTest() {
        ProcessInstance pi;
        User contextuser = TestUtilityDataFactory.insertSystemUser('System Administrator', 'tmp');

        System.runAs(contextuser) {

            Account_Request__c o = new Account_Request__c(Name='Test Business');
            insert o;
            system.debug('#### Req =' + o);
            
            o.Locked__c = true;
            o.Status__c = 'Completed';
            
            update o;
            pi = [SELECT Status FROM ProcessInstance WHERE TargetObjectId = :o.Id];
        }
        System.assertEquals('Approved', pi.Status, 'Approval Process Failed');
    }
}