@isTest (seeAllData=true)
private class TESTIV_Sync_Status{
    static testMethod void runTest(){
        List<User> userlist = [select Id from User where CommunityNickname = 'chart@bristan.com' limit 1];
        List<BMCServiceDesk__BMC_BaseElement__c> BS = [Select id from BMCServiceDesk__BMC_BaseElement__c where BMCServiceDesk__ClassID__c =
            'BMC_BUSINESSSERVICE' AND BMCServiceDesk__Name__c = 'Generic Service' LIMIT 1];
        LIST<BMCServiceDesk__Impact__c> IMPACT = [Select id from BMCServiceDesk__Impact__c where BMCServiceDesk__inactive__c = false and Name = '4. LOW: Single User affected' LIMIT 1];
        LIST<BMCServiceDesk__Urgency__c> URG = [Select id from BMCServiceDesk__Urgency__c where BMCServiceDesk__inactive__c = false LIMIT 1];
        List<BMCServiceDesk__Status__c> status = [select id from BMCServiceDesk__Status__c where Name = 'OPENED'];
        List<BMCServiceDesk__Priority__c> priority = [select id from BMCServiceDesk__Priority__c where Name = '1'];
        BMCServiceDesk__Incident__c incident = new BMCServiceDesk__Incident__c();
        incident.BMCServiceDesk__FKClient__c = userlist[0].Id;
        incident.BMCServiceDesk__incidentDescription__c = 'Test';
        incident.BMCServiceDesk__FKBusinessService__c = BS[0].id;
        incident.BMCServiceDesk__FKImpact__c = IMPACT[0].id ;
        incident.BMCServiceDesk__FKUrgency__c = URG[0].id;
        incident.BMCServiceDesk__FKStatus__c = status[0].id;
        incident.BMCServiceDesk__FKPriority__c = priority[0].id;
        Test.startTest();
        insert incident;
        incident.IN_Status__c = 'WAITING FOR CUSTOMER';
        update incident;
        Test.stopTest();
    }
}