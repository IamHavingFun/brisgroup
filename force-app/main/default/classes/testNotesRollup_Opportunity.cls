@isTest(SeeAllData = True)

private class testNotesRollup_Opportunity {
    static testMethod void test() {
        //Set up test data  
        TestUtilityClass.setUpData();
        //Getting opportunity information
        Opportunity oppty = TestUtilityClass.opp;
        oppty.Notes__c = 'Test Notes';
        Test.startTest();
        update oppty;
        Test.stopTest();        
    }
}