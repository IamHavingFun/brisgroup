@isTest
// test for the 'Populate Assigned To Field' triggers
private class tstPopulateAssignedToField_Event {
    
    @IsTest
    static void test() {

        User user = DataFactory.createAdminUser('username@testuser.bristan.com');
        insert user;

        System.runAs(user) {
            // create dummy Event & Task
            Event e = new Event(ActivityDateTime = Date.Today(), Description = 'Test Event',
                    DurationInMinutes = 10, Subject = 'Test Event', Type = 'Test Event',
                    OwnerId = user.Id);
            insert e;
        }

        // get the custom "Assigned To" field value
        String assignedUser = [SELECT Assigned_To__c FROM Event WHERE
                Subject = 'Test Event' LIMIT 1].Assigned_To__c;

        // test "Assigned To"
        System.assertEquals(user.FirstName + ' ' + user.LastName, assignedUser);
    }
}