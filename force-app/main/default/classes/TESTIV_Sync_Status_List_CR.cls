@isTest (seeAllData=true)
private class TESTIV_Sync_Status_List_CR{
    static testMethod void runTest(){
        List<User> userlist = [select Id from User where CommunityNickname = 'sbarsby@bristan.com' limit 1];
        List<BMCServiceDesk__Status__c> status = [select id,Name, BMCServiceDesk__state__c from BMCServiceDesk__Status__c where NAME = 'OPENED'];
        List<BMCServiceDesk__Status__c> status2 = [select id,Name, BMCServiceDesk__state__c from BMCServiceDesk__Status__c where NAME = 'AWAITING DELIVERY'];
        List<BMCServiceDesk__BMC_BaseElement__c> BS = [Select id from BMCServiceDesk__BMC_BaseElement__c where BMCServiceDesk__ClassID__c =
            'BMC_BUSINESSSERVICE' AND BMCServiceDesk__Name__c = 'Generic Service' LIMIT 1];
        LIST<BMCServiceDesk__Impact__c> IMPACT = [Select id from BMCServiceDesk__Impact__c where BMCServiceDesk__inactive__c = false LIMIT 1];
        LIST<BMCServiceDesk__Urgency__c> URG = [Select id from BMCServiceDesk__Urgency__c where BMCServiceDesk__inactive__c = false LIMIT 1];
        List<BMCServiceDesk__Priority__c> priority = [select id from BMCServiceDesk__Priority__c where Name = '1'];
        BMCServiceDesk__Change_Request__c incident = new BMCServiceDesk__Change_Request__c();
        incident.BMCServiceDesk__FKInitiator__c = userlist[0].Id;
        incident.BMCServiceDesk__Change_Description__c = 'Test';
        incident.BMCServiceDesk__FKImpact__c = IMPACT[0].id ;
        incident.BMCServiceDesk__FKUrgency__c = URG[0].id;
        incident.BMCServiceDesk__FKStatus__c = status[0].id;
        incident.BMCServiceDesk__FKPriority__c = priority[0].id;
        incident.BMCServiceDesk__Back_out_Plan_Details__c  = '12345678910';
        incident.BMCServiceDesk__Change_Description__c  = '12345678910';
        incident.BMCServiceDesk__Reason_for_Change_Details__c = '12345678910';
        incident.BMCServiceDesk__Roll_Out_Plan_Details__c = '12345678910';
        incident.CR_Test_Plan_Details__c = '12345678910';       
        Test.startTest();
        insert incident;
        incident.BMCServiceDesk__FKStatus__c = status2[0].Id;
        update incident;
        Test.stopTest();
    }
}