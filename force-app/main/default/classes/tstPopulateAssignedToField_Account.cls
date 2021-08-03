@isTest
// test for the 'Populate Assigned To Field' trigger (Opportunity)
private class tstPopulateAssignedToField_Account {

    @IsTest
    static void test() {

        User user = DataFactory.createAdminUser('username@testuser.bristan.com');
        insert user;

        System.runAs(user) {
            // create dummy Opportunity
            Account o = new Account(Name = 'Test Account', OwnerId = user.Id);
            insert o;
        }
        // get the custom "Assigned To" field value
        String assignedUser = [SELECT Assigned_To__c FROM Account WHERE
                            Name = 'Test Account' LIMIT 1].Assigned_To__c;

        // test "Assigned To"
        System.assertEquals(user.FirstName + ' ' + user.LastName, assignedUser);
    }
}