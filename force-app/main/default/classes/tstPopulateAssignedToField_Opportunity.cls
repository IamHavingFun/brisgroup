@isTest
// test for the 'Populate Assigned To Field' trigger (Opportunity)
private class tstPopulateAssignedToField_Opportunity {
    static testMethod void test() {
        // create dummy Opportunity
        Opportunity o = new Opportunity(Name = 'Wills', Division__c = 'Heritage',CloseDate=date.today(),
                                        StageName = 'Initiating', Postcode__c = '780001', 
                                        Address_Line_1__c='Buckinghamshire', Customer_Order_Number__c='Test Opportunity',
                                        Estimated_Start_Date__c = date.today(), Estimated_Completion__c = date.today().addDays(60),
                                        OwnerId = '005D00000023Sse'); 
                            
        Test.startTest();
        insert o;
        Test.stopTest();        

        // get the custom "Assigned To" field value
        String strType_o = [SELECT Assigned_To__c FROM Opportunity WHERE
                            Id = :o.Id LIMIT 1].Assigned_To__c;

        // test "Assigned To"
        System.assertEquals(strType_o,'Steve Mason');
    }
}