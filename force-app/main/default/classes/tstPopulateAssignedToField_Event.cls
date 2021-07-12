@isTest
// test for the 'Populate Assigned To Field' triggers
private class tstPopulateAssignedToField_Event {
    static testMethod void test() {
        // create dummy Event & Task
        Event e = new Event(ActivityDateTime=Date.Today(), Description='Test Event',
                            DurationInMinutes=10, Subject='Test Event', Type='Test Event',
                            OwnerId = '005D00000023Sse'); 
                            
        Test.startTest();
        insert e;
        Test.stopTest();        

        // get the custom "Assigned To" field value
        String strType_e = [SELECT Assigned_To__c FROM Event WHERE
                            Id = :e.Id LIMIT 1].Assigned_To__c;

        // test "Assigned To"
        System.assertEquals(strType_e,'Steve Mason');
    }
}