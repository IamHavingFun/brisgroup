@isTest
// test for the 'Populate Assigned To Field' trigger (Opportunity)
private class tstPopulateAssignedToField_Opportunity {

    @IsTest
    static void test() {

        User user = DataFactory.createAdminUser('username@testuser.bristan.com');
        insert user;

        System.runAs(user) {
            // create dummy Opportunity
            Opportunity o = new Opportunity(Name = 'Wills', Division__c = 'Heritage',CloseDate=date.today(),
                                            StageName = 'Initiating', Postcode__c = '780001',
                                            Address_Line_1__c='Buckinghamshire', Customer_Order_Number__c='Test Opportunity',
                                            Estimated_Start_Date__c = date.today(), Estimated_Completion__c = date.today().addDays(60),
                                            OwnerId = user.Id);
                insert o;
        }

        // get the custom "Assigned To" field value
        String assignedUser = [SELECT Assigned_To__c FROM Opportunity WHERE
                Customer_Order_Number__c = 'Test Opportunity' LIMIT 1].Assigned_To__c;

        // test "Assigned To"
        System.assertEquals(user.FirstName + ' ' + user.LastName, assignedUser);
    }
}