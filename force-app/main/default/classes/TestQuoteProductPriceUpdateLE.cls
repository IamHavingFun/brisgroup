/*Test class to unit test QuoteProductPriceUpdate class that updates the customer prices of QuotelineItems.
 *Author : Bhushan Adhikari
 *Since : Oct 2019
 *E-mail : smason@bristan.com
 */
 
@IsTest(SeeAllData = true)
private class TestQuoteProductPriceUpdateLE {

    @IsTest
    static void QuotePriceUpdateUnitTest() {
        //setting up the required data
        TestUtilityClass.setUpData();
        //Getting the Quote information
        Quote quote = TestUtilityClass.q;
        
        Boolean q1 = QuoteUpdatePricesLE.createList(quote.Id);
        System.assert(!q1, 'List must not be created');
        
    }

    @IsTest
    static void testQuoteGetPrice() {
        //setting up the required data
        TestUtilityClass.setUpData();
        //Getting the Quote information
        Quote quote = TestUtilityClass.q;
                
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
        System.assert(res.containsKey('01'), 'Key not present on response');

    }

    @IsTest
    static void testQuoteUpdateIfsPrice() {
        //setting up the required data
        TestUtilityClass.setUpData();
        //Getting the Quote information
        Quote quote = TestUtilityClass.q;
                
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
        
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        qup.updateIfsPrice(sites);
        List<QuoteLineItem> quoteLines = [SELECT Id, IFS_Price__c FROM QuoteLineItem WHERE QuoteId = :quote.Id];
        System.assert(!quoteLines.isEmpty(), 'Quote Lines were not created');
        System.assertEquals(150, quoteLines.size(), 'Quote Lines does not match');
    }

    @IsTest
    static void testQuoteGetLines() {
        //setting up the required data
        TestUtilityClass.setUpData();
        //Getting the Quote information
        Quote quote = TestUtilityClass.q;
        
        Integer lines = QuoteUpdatePricesLE.getLineCount(quote.Id);
        System.assertEquals(150, lines, 'Not the same number of lines were returned');

    }    
}