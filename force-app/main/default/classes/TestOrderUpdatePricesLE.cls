/* Test class to test OrderUpdatePricesLE class
 * Author : Steve Mason
 * Since : Oct 2019
 * Email : smason@bristan.com
 */

@isTest(SeeAllData = True)
private class TestOrderUpdatePricesLE {

    static testMethod void OrderPriceUpdateUnitTest() {
        Map<String,Map<String,String>> priceRes = new  Map<String,Map<String,String>>();
        //Set up test data  
        TestUtilityClass.setUpData();
        //Getting opportunity information
        Order__c ordr = TestUtilityClass.ord;
        Order__c ordr2 = TestUtilityClass.ord2;
        Order__c ordr3 = TestUtilityClass.ord3;        
        PageReference pageRef = Page.GetPricesVFOrders; //replace with your VF page name
        Test.setCurrentPage(pageRef);
        Apexpages.StandardController stdController = new Apexpages.StandardController(ordr); 
        OrderUpdatePricesLE controller = new OrderUpdatePricesLE(stdController);
        Apexpages.StandardController stdController2 = new Apexpages.StandardController(ordr2); 
        OrderUpdatePricesLE controller2 = new OrderUpdatePricesLE(stdController2);        
        Apexpages.StandardController stdController3 = new Apexpages.StandardController(ordr3); 
        OrderUpdatePricesLE controller3 = new OrderUpdatePricesLE(stdController3);        
        //Creating Different Price maps       
        Map<String,string> prices1 = new Map<String,string>();
        prices1.put('HY PUMP70','164.08');
        Map<String,string> prices4 = new Map<String,string>();
        prices4.put('HY PUMP71','145.50');
        
        //Creating a map that stores Site and its corresponding product information
        Map<String,Map<String,string>> sites =new Map<String,Map<String,string>>();
        sites.put('01',prices1);
        sites.put('04',prices4);
        system.debug('*****sites: ' + sites);
         
        //Creating an instance of  OrderUpdatePrices class
        OrderUpdatePricesLE oup = new OrderUpdatePricesLE(stdController);
        OrderUpdatePricesLE oup2 = new OrderUpdatePricesLE(stdController2);
        OrderUpdatePricesLE oup3 = new OrderUpdatePricesLE(stdController3);        
        PageReference ordReturn3 = oup3.getPrices();
        PageReference ordReturn2 = oup2.getPrices();
        PageReference ordReturn = oup.getPrices();        
        ordReturn = oup.backToOrder();
        
        //calling createList method of QuoteUpdatePrices class
        oup.createLists(ordr.Id);
        oup2.createLists(ordr2.Id);
        Map<String,Map<String,String>> price = oup.getPrice();
        price = oup2.getPrice();
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        oup.updateIfsPrice(sites);
        oup2.updateIfsPrice(sites);
        
        //Getting the Opportunity Line Items to verify prices have been updated
        List<Order_Line__c> oli = [SELECT Id,Customer_Price__c,Product__r.Name,Product__r.Site__c,Order__c FROM Order_Line__c WHERE Order__c =: ordr.Id];
        
        //Looping through each line item to check prices has been updated
//        for(Order_Line__c o: oli){
//          system.assertEquals(o.Customer_Price__c, decimal.valueOf(sites.get(o.Product__r.Site__c).get(o.Product__r.Name))*1.2);
//        }
    }
}