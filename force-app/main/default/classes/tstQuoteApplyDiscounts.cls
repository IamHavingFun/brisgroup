@isTest(SeeAllData = true)
private class tstQuoteApplyDiscounts {
    static testMethod void test() {
        // create dummy Sales Summary
        TestUtilityClass.setUpData();
        Quote qt = TestUtilityClass.q;
        Opportunity op = TestUtilityClass.opp;
        system.debug('#### Opportunity :' + op.id);                
        system.debug('#### Quote :' + qt.id);        
        
        QuoteApplyDiscounts qad = new QuoteApplyDiscounts();  
          qad.createLists(qt.id);
          qad.UpdateIfsPrice(qt.id);
    }
}