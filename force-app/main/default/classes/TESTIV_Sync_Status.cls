@isTest (seeAllData=true)
private class TESTIV_Sync_Status{
    static testMethod void runTest(){

        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : p.id limit 1];

        List<User> userlist = [select Id from User where CommunityNickname = 'chart@bristan.com' limit 1];

        TestUtilityClass.setUpData();
        BMCServiceDesk__BMC_BaseElement__c newBS = TestUtilityClass.bs;
        BMCServiceDesk__Impact__c impact = TestUtilityClass.impact;
        BMCServiceDesk__Urgency__c urg = TestUtilityClass.urg;
        BMCServiceDesk__Status__c status = TestUtilityClass.status;
        BMCServiceDesk__Priority__c priority = TestUtilityClass.priority;

        BMCServiceDesk__Incident__c incident = new BMCServiceDesk__Incident__c();
        incident.BMCServiceDesk__FKClient__c = userlist[0].Id;
        incident.BMCServiceDesk__incidentDescription__c = 'Test';
        incident.BMCServiceDesk__FKBusinessService__c = newBS.Id;
        incident.BMCServiceDesk__FKImpact__c = impact.Id ;
        incident.BMCServiceDesk__FKUrgency__c = urg.Id;
        incident.BMCServiceDesk__FKStatus__c = status.Id;
        incident.BMCServiceDesk__FKPriority__c = priority.Id;

        System.runAs(thisuser){
            Test.startTest();
            insert incident;
            incident.IN_Status__c = 'WAITING FOR CUSTOMER';
            update incident;
            Test.stopTest();
        }
       
        String statusUpdate = [
            SELECT IN_Status__c
            FROM BMCServiceDesk__Incident__c
            WHERE Id = :incident.Id
        ].IN_Status__c;

        String statusUpdate2 = [
            SELECT IN_Status__c
            FROM BMCServiceDesk__Incident__c
            WHERE Id = :incident.Id
        ].IN_Status__c;

        System.assertEquals('WAITING FOR CUSTOMER', statusUpdate);
    }
}