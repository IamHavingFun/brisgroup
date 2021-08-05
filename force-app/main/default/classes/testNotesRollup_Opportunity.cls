/**
 * @author 
 * @since 
 */
@IsTest
private class testNotesRollup_Opportunity {
    
    @TestSetup
    static void makeData() {
        // get price book
        Id pricebookId = Test.getStandardPricebookId();

        //Set up test data
        Opportunity proj = TestUtilityDataFactory.createOpportunity('Project', 'ProjectBristan', pricebookId);
        insert proj;        
    }

    @IsTest
    static void test() {
        // get price book
        Id pricebookId = Test.getStandardPricebookId();
        // Project Id
        Opportunity proj = [SELECT Id FROM Opportunity WHERE Name = 'ProjectBristan'];
        // create opportunities
        Opportunity opp = TestUtilityDataFactory.createOpportunity('Opportunity', 'OP1', pricebookId);
        opp.Project__c = proj.Id;
        opp.Notes__c = 'Note Test #1';
        Opportunity opp2 = TestUtilityDataFactory.createOpportunity('Opportunity', 'OP1', pricebookId);
        opp2.Notes__c = 'Note Test #2';
        opp2.Project__c = proj.Id;

        Test.startTest();
        List<Opportunity> opps = new List<Opportunity>{ opp, opp2 };
        insert opps;
        Test.stopTest();
        proj = [SELECT Notes_Rollup__c FROM Opportunity WHERE Id = :proj.Id];
        System.assert(String.isNotBlank(proj.Notes_Rollup__c), 'Notes were not rolled up');
    }
}