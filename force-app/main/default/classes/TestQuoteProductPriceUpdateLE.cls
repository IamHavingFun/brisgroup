/*Test class to unit test QuoteProductPriceUpdate class that updates the customer prices of QuotelineItems.
 *Author : Bhushan Adhikari
 *Since : Oct 2019
 *E-mail : smason@bristan.com
 */
 
@isTest(SeeAllData = True)
private class TestQuoteProductPriceUpdateLE {

    static testMethod void QuotePriceUpdateUnitTest() {
        //setting up the required data
        TestUtilityClass.setUpData();
        //Getting the Quote information
        Quote quote = TestUtilityClass.q;
        Quote quote2 = TestUtilityClass.q2;
                
        //Creating Different Price maps       
        Map<String,string> prices1 = new Map<String,string>();
        prices1.put('HY PUMP70','164.08');
        Map<String,string> prices4 = new Map<String,string>();
        prices4.put('HY PUMP71','145.50');
        
        //Creating a map that stores Site and its corresponding product information
        Map<String,Map<String,string>> sites =new Map<String,Map<String,string>>();
        sites.put('01',prices1);
        sites.put('04',prices4);
        system.debug('*****sitesss' + sites);
        //Creating an instance of QuoteUpdatePrices class
        QuoteUpdatePricesLE qup = new  QuoteUpdatePricesLE();
        
        //calling createList method of QuoteUpdatePrices class
        qup.createLists(quote.Id);
        Map<String,Map<String,String>> res = qup.getPrice();
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        qup.updateIfsPrice(sites);
        
        //calling createList method of QuoteUpdatePrices class
        qup.createLists(quote2.Id);
        Map<String,Map<String,String>> res2 = qup.getPrice();
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        qup.updateIfsPrice(sites);
        
        //Getting the Quote Line Items to verify prices have been updated
        List<QuoteLineItem> qli = [SELECT Id,IFS_Price__c,PriceBookEntry.Product2.Name,PriceBookEntry.Product2.Site__c,QuoteId FROM QuoteLineItem WHERE QuoteId =: quote.Id];
        
        Integer lines = QuoteUpdatePricesLE.getLineCount(quote.Id);
        Boolean q1 = QuoteUpdatePricesLE.createList(quote.Id);
        Boolean q2 = QuoteUpdatePricesLE.createList(quote2.Id);
        
        //Looping through each line item to check prices has been updated
//        for(QuoteLineItem q: qli){
//          system.assertEquals(q.IFS_Price__c, decimal.valueOf(sites.get(q.PriceBookEntry.Product2.Site__c).get(q.PriceBookEntry.Product2.Name)));
//        }
    }
}