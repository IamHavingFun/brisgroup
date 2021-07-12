@isTest
// test for the 'Populate Assigned To Field' trigger (Opportunity)
private class tstPopulateAssignedToField_Account {
    static testMethod void test() {
        // create dummy Opportunity
        Account o = new Account(Name = 'Test Account', OwnerId = '005D00000023Sse'); 
                            
        Test.startTest();
        insert o;
        Test.stopTest();        

        // get the custom "Assigned To" field value
        String strType_o = [SELECT Assigned_To__c FROM Account WHERE
                            Id = :o.Id LIMIT 1].Assigned_To__c;

        // test "Assigned To"
        System.assertEquals(strType_o,'Steve Mason');
    }
}