/* Test class to test OrderUpdatePricesLE class
 * Author : Steve Mason
 * Since : Oct 2019
 * Email : smason@bristan.com
 */

@IsTest(SeeAllData = true)
private class TestOrderUpdatePricesLE {

    @IsTest
    static void testPriceOne(){
        //Set up test data  
        TestUtilityClass.setUpData(); 
        //Getting opportunity information
        Order__c ordr = TestUtilityClass.ord;
       //Creating Different Price maps       
        Map<String,String> prices1 = new Map<String,String>();
        prices1.put('HY PUMP70','164.08');
        //Creating a map that stores Site and its corresponding product information
        Map<String,Map<String,String>> sites =new Map<String,Map<String,String>>();
        sites.put('01',prices1);

        PageReference pageRef = Page.GetPricesVFOrders;
        Test.setCurrentPage(pageRef);
        Apexpages.StandardController stdController = new Apexpages.StandardController(ordr); 
        OrderUpdatePricesLE oup = new OrderUpdatePricesLE(stdController);
        PageReference ordReturn = oup.getPrices();
        ordReturn = oup.backToOrder();
        oup.createLists(ordr.Id);
        Map<String,Map<String,String>> price = oup.getPrice();
        System.assertEquals(URL.getSalesforceBaseUrl().toExternalForm()+'/' + ordr.Id, ordReturn.getUrl(), 'URL does not match');
        System.assert(price.containsKey('01'), 'Price was not returned');

    }

    @IsTest
    static void testPriceFour() {
        //Set up test data  
        TestUtilityClass.setUpData();
        //Getting opportunity information
        Order__c ordr2 = TestUtilityClass.ord2;
        PageReference pageRef = Page.GetPricesVFOrders; //replace with your VF page name
        Test.setCurrentPage(pageRef);
        Apexpages.StandardController stdController2 = new Apexpages.StandardController(ordr2); 
        //Creating Different Price maps       
        Map<String,String> prices1 = new Map<String,String>();
        prices1.put('HY PUMP70','164.08');
        Map<String,String> prices4 = new Map<String,String>();
        prices4.put('HY PUMP71','145.50');
        //Creating a map that stores Site and its corresponding product information
        Map<String,Map<String,String>> sites =new Map<String,Map<String,String>>();
        sites.put('01',prices1);
        sites.put('04',prices4);
         
        //Creating an instance of  OrderUpdatePrices class
        OrderUpdatePricesLE oup2 = new OrderUpdatePricesLE(stdController2);
        PageReference ordReturn2 = oup2.getPrices();
        
        //calling createList method of QuoteUpdatePrices class
        oup2.createLists(ordr2.Id);
        Map<String,Map<String,String>> price = oup2.getPrice();
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        oup2.updateIfsPrice(sites);
        System.assert(price.isEmpty(), 'Prices must be empty');
        System.assert(ordReturn2 == null, 'NULL must be returned');
    }

    @IsTest
    static void OrderPriceUpdateUnitTest() {
        //Set up test data  
        TestUtilityClass.setUpData();
        //Getting opportunity information
        Order__c ordr3 = TestUtilityClass.ord3;        
        PageReference pageRef = Page.GetPricesVFOrders; //replace with your VF page name
        Test.setCurrentPage(pageRef);
        Apexpages.StandardController stdController3 = new Apexpages.StandardController(ordr3); 
        //Creating Different Price maps       
        Map<String,String> prices1 = new Map<String,String>();
        prices1.put('HY PUMP70','164.08');
        Map<String,String> prices4 = new Map<String,String>();
        prices4.put('HY PUMP71','145.50');
        //Creating a map that stores Site and its corresponding product information
        Map<String,Map<String,String>> sites =new Map<String,Map<String,String>>();
        sites.put('01',prices1);
        sites.put('04',prices4);
         
        //Creating an instance of  OrderUpdatePrices class
        OrderUpdatePricesLE oup3 = new OrderUpdatePricesLE(stdController3);        
        PageReference ordReturn3 = oup3.getPrices();
        System.assert(ordReturn3 == null, 'NULL must be returned');
    }
}