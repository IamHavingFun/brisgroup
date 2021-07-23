@isTest (seeAllData=true)
private class TESTIV_Sync_Status_List{
    static testMethod void runTest(){
        List<User> userlist = [select Id from User where CommunityNickname = 'chart@bristan.com' limit 1];

        BMCServiceDesk__Status__c status = new BMCServiceDesk__Status__c(
            Name = 'OPENED',
            BMCServiceDesk__inactive__c = false,
            BMCServiceDesk__appliesToIncident__c = true
        );
        insert status;

        BMCServiceDesk__Status__c status2 = new BMCServiceDesk__Status__c(
            Name = 'WAITING FOR CUSTOMER',
            BMCServiceDesk__inactive__c = false,
            BMCServiceDesk__appliesToIncident__c = true
        );
        insert status2;

        BMCServiceDesk__BMC_BaseElement__c BS = new BMCServiceDesk__BMC_BaseElement__c(
            BMCServiceDesk__Name__c = 'Generic Service'
        );
        insert BS;

        BMCServiceDesk__Impact__c impact = new BMCServiceDesk__Impact__c(
            BMCServiceDesk__inactive__c = false,
            Name = '4. LOW: Single User affected'
        );
        insert impact;

        BMCServiceDesk__Urgency__c urg = new BMCServiceDesk__Urgency__c(
            Name = 'URGtest',
            BMCServiceDesk__inactive__c = false
        );
        insert urg;

        BMCServiceDesk__Priority__c priority = new BMCServiceDesk__Priority__c(
            Name = '1',
            BMCServiceDesk__description__c = 'Priority Test',
            BMCServiceDesk__FKImpact__c = impact.Id,
            BMCServiceDesk__FKUrgency__c = urg.Id
        );
        insert priority;

        BMCServiceDesk__Incident__c incident = new BMCServiceDesk__Incident__c();
        incident.BMCServiceDesk__FKClient__c = userlist[0].Id;
        incident.BMCServiceDesk__incidentDescription__c = 'Test';
        incident.BMCServiceDesk__FKBusinessService__c = BS.id;
        incident.BMCServiceDesk__FKImpact__c = impact.id ;
        incident.BMCServiceDesk__FKUrgency__c = urg.id;
        incident.BMCServiceDesk__FKStatus__c = status.id;
        incident.BMCServiceDesk__FKPriority__c = priority.id;
        Test.startTest();
        insert incident;
        incident.BMCServiceDesk__FKStatus__c = status2.Id;
        update incident;
        Test.stopTest();

        String statusUpdate = [
            SELECT BMCServiceDesk__FKStatus__c
            FROM BMCServiceDesk__Incident__c
            WHERE Id = :incident.Id
        ].BMCServiceDesk__FKStatus__c;

        System.assertEquals(status2.id, statusUpdate);

    }
}