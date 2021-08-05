@isTest(SeeAllData = True)
private class IncidentUpdateApproverTest {

    static testMethod void testManualShareRead()
    {
        Id managerID;
        Id delegateID;

        User userManager = DataFactory.createAdminUser('musername@testuser.bristan.com');
        insert userManager;
        User userApprover = DataFactory.createAdminUser('ausername@testuser.bristan.com');
        insert userApprover;
        User user = DataFactory.createAdminUser('uusername@testuser.bristan.com');
        user.RF_Manager__c = userManager.Id;
        user.RF_Delegated_Approver__c = userApprover.Id;
        insert user;
        
        // Select users for the test.
        List<User> users = [SELECT Id, RF_Manager__c, RF_Delegated_Approver__c FROM User WHERE Id = :user.Id LIMIT 1];
        Id User1Id = users[0].Id;
        // Get manager ID from user record
        managerID = users[0].RF_Manager__c;
        delegateID = users[0].RF_Delegated_Approver__c;
        system.debug('**********User ID: ' + User1Id); 
        system.debug('**********Approver ID: ' + managerID); 
        system.debug('**********Delegate ID: ' + delegateID); 
        
        // create new incident
        BMCServiceDesk__Incident__c i = new BMCServiceDesk__Incident__c();
        i.OwnerId = User1Id;
        i.BMCServiceDesk__FKClient__c = User1Id;
        insert i;
        system.debug('**********Incident ID: ' + i.Id); 
        string newId = i.Id;
        i = [SELECT Id, RF_Manager__c, RF_Delegated_Approver__c from BMCServiceDesk__Incident__c where Id=:newId LIMIT 1];
        System.assertEquals(managerID, i.RF_Manager__c);
        System.assertEquals(delegateID, i.RF_Delegated_Approver__c);        
    }
}