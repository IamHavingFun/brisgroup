@isTest(SeeAllData = true)
private class tstQuoteApplyDiscounts {


    static testMethod void test() {
        // create dummy Sales Summary
        TestUtilityClass.setUpData();
        Quote qt = TestUtilityClass.q;
        Opportunity op = TestUtilityClass.opp;
        QuoteApplyDiscounts qad = new QuoteApplyDiscounts();

        qad.createLists(qt.id);
        qad.masterList[0].IFS_Price__c = 100;
        qad.masterList[0].UnitPrice = 100;
        update qad.masterList;

        Decimal priceBefore = qad.masterList[0].UnitPrice;
        qad.UpdateIfsPrice(qt.id);

        System.assert(qad.masterList.size() > 0);
        System.assert(qad.disc > 0);
        System.assertNotEquals(priceBefore, qad.masterList[0].UnitPrice);

        //set discount value to null
        qad.disc = null;
        Boolean hasException;
        try {
            qad.UpdateIfsPrice(qt.id);
        } catch (Exception e) {
            hasException = true;
        }
        system.assertNotEquals(null, hasException, 'expected exception');
    }

}