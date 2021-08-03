@isTest (seeAllData=true)
private class TESTIV_Sync_Status_CR{
    static testMethod void runTest(){
        List<User> userlist = [select Id from User where CommunityNickname = 'sbarsby@bristan.com' limit 1];

        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : p.id limit 1];
  
        TestUtilityClass.setUpData();
        BMCServiceDesk__BMC_BaseElement__c newBS = TestUtilityClass.bs;
        BMCServiceDesk__Impact__c impact = TestUtilityClass.impact;
        BMCServiceDesk__Urgency__c urg = TestUtilityClass.urg;
        BMCServiceDesk__Status__c status = TestUtilityClass.status;
        BMCServiceDesk__Priority__c priority = TestUtilityClass.priority;

        BMCServiceDesk__Change_Request__c incident = new BMCServiceDesk__Change_Request__c();
        incident.BMCServiceDesk__FKInitiator__c = userlist[0].Id;
        incident.BMCServiceDesk__Change_Description__c  = 'Test';
        incident.BMCServiceDesk__FKImpact__c = impact.id ;
        incident.BMCServiceDesk__FKUrgency__c = urg.id;
        incident.BMCServiceDesk__FKStatus__c = status.id;
        incident.BMCServiceDesk__FKPriority__c = priority.id;
        incident.BMCServiceDesk__Back_out_Plan_Details__c  = '12345678910';
        incident.BMCServiceDesk__Change_Description__c  = '12345678910';
        incident.BMCServiceDesk__Reason_for_Change_Details__c = '12345678910';
        incident.BMCServiceDesk__Roll_Out_Plan_Details__c = '12345678910';
        incident.CR_Test_Plan_Details__c = '12345678910';  

        System.runAs(thisuser){
            Test.startTest();
            insert incident;
            incident.CR_Status__c = 'AWAITING DELIVERY';
            update incident;
            Test.stopTest();
        }
        
        String statusUpdate = [
            SELECT CR_Status__c
            FROM BMCServiceDesk__Change_Request__c
            WHERE Id = :incident.Id
        ].CR_Status__c;

        System.assertEquals('AWAITING DELIVERY', statusUpdate);

    }
}