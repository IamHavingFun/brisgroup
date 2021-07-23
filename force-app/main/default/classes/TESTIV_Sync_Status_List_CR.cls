@isTest (seeAllData=true)
private class TESTIV_Sync_Status_List_CR{
    static testMethod void runTest(){
        List<User> userlist = [select Id from User where CommunityNickname = 'sbarsby@bristan.com' limit 1];
        
        BMCServiceDesk__Status__c status = new BMCServiceDesk__Status__c(
            Name = 'OPENED',
            BMCServiceDesk__inactive__c = false,
            BMCServiceDesk__appliesToIncident__c = true,
            BMCServiceDesk__appliesToChange__c = true
        );
        insert status;

        BMCServiceDesk__Status__c status2 = new BMCServiceDesk__Status__c(
            Name = 'WAITING FOR CUSTOMER',
            BMCServiceDesk__inactive__c = false,
            BMCServiceDesk__appliesToIncident__c = true,
            BMCServiceDesk__appliesToChange__c = true
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

        BMCServiceDesk__Change_Request__c incident = new BMCServiceDesk__Change_Request__c();
        incident.BMCServiceDesk__FKInitiator__c = userlist[0].Id;
        incident.BMCServiceDesk__Change_Description__c = 'Test';
        incident.BMCServiceDesk__FKImpact__c = impact.id ;
        incident.BMCServiceDesk__FKUrgency__c = urg.id;
        incident.BMCServiceDesk__FKStatus__c = status.id;
        incident.BMCServiceDesk__FKPriority__c = priority.id;
        incident.BMCServiceDesk__Back_out_Plan_Details__c  = '12345678910';
        incident.BMCServiceDesk__Change_Description__c  = '12345678910';
        incident.BMCServiceDesk__Reason_for_Change_Details__c = '12345678910';
        incident.BMCServiceDesk__Roll_Out_Plan_Details__c = '12345678910';
        incident.CR_Test_Plan_Details__c = '12345678910';       
        Test.startTest();
        insert incident;
        incident.BMCServiceDesk__FKStatus__c = status2.Id;
        update incident;
        Test.stopTest();

        String statusUpdate = [
            SELECT BMCServiceDesk__FKStatus__c
            FROM BMCServiceDesk__Change_Request__c
            WHERE Id = :incident.Id
        ].BMCServiceDesk__FKStatus__c;

        System.assertEquals(status2.id, statusUpdate);

    }
}