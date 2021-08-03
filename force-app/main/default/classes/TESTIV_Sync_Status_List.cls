@isTest (seeAllData=true)
private class TESTIV_Sync_Status_List{
    static testMethod void runTest(){
        List<User> userlist = [select Id from User where CommunityNickname = 'chart@bristan.com' limit 1];

        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : p.id limit 1];

        TestUtilityClass.setUpData();
        BMCServiceDesk__BMC_BaseElement__c BS = TestUtilityClass.bs;
        BMCServiceDesk__Impact__c impact = TestUtilityClass.impact;
        BMCServiceDesk__Urgency__c urg = TestUtilityClass.urg;
        BMCServiceDesk__Status__c status = TestUtilityClass.status;
        BMCServiceDesk__Status__c status2 = TestUtilityClass.status;
        BMCServiceDesk__Priority__c priority = TestUtilityClass.priority;

        BMCServiceDesk__Incident__c incident = new BMCServiceDesk__Incident__c();
        incident.BMCServiceDesk__FKClient__c = userlist[0].Id;
        incident.BMCServiceDesk__incidentDescription__c = 'Test';
        incident.BMCServiceDesk__FKBusinessService__c = BS.id;
        incident.BMCServiceDesk__FKImpact__c = impact.id ;
        incident.BMCServiceDesk__FKUrgency__c = urg.id;
        incident.BMCServiceDesk__FKStatus__c = status.id;
        incident.BMCServiceDesk__FKPriority__c = priority.id;

        System.runAs(thisuser){
            Test.startTest();
            insert incident;
            incident.BMCServiceDesk__FKStatus__c = status2.Id;
            update incident;
            Test.stopTest();
        }

        String statusUpdate = [
            SELECT BMCServiceDesk__FKStatus__c
            FROM BMCServiceDesk__Incident__c
            WHERE Id = :incident.Id
        ].BMCServiceDesk__FKStatus__c;

        System.assertEquals(status2.id, statusUpdate);

    }
}