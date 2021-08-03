/* Test class to test OrderUpdatePrices class
 * Author : Steve Mason
 * Since : Sept 2013
 * Email : smason@bristan.com
 */

@isTest(SeeAllData = True)
private class TestOrderUpdatePrices {

    static testMethod void OrderPriceUpdateUnitTest() {
        //Set up test data  
        TestUtilityClass.setUpData();
        //Getting opportunity information
        Order__c ordr = TestUtilityClass.ord;
        Order__c ordr2 = TestUtilityClass.ord2;
        //Creating Different Price maps       
        Map<String,string> prices1 = new Map<String,string>();
        prices1.put('HY PUMP70','164.08');
        Map<String,string> prices2 = new Map<String,string>();
        prices2.put('HY PUMP50','100.08');
        Map<String,string> prices3 = new Map<String,string>();
        prices3.put('HY PUMP100','95.00');
        Map<String,string> prices4 = new Map<String,string>();
        prices4.put('HY PUMP71','145.50');
        
        //Creating a map that stores Site and its corresponding product information
        Map<String,Map<String,string>> sites =new Map<String,Map<String,string>>();
        sites.put('01',prices1);
        sites.put('02',prices2);
        sites.put('03',prices3);
        sites.put('04',prices4);
         system.debug('*****sitesss' + sites);
         
        //Creating an instance of  OrderUpdatePrices class
        OrderUpdatePrices oup = new  OrderUpdatePrices();
        
        //calling createList method of QuoteUpdatePrices class
        oup.createLists(ordr.Id);
        Map<String,Map<String,String>> price = oup.getPrice();
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        oup.updateIfsPrice(sites);
        
        //calling createList method of QuoteUpdatePrices class
        oup.createLists(ordr2.Id);
        Map<String,Map<String,String>> price2 = oup.getPrice();
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        oup.updateIfsPrice(sites);
        
        //Getting the Opportunity Line Items to verify prices have been updated
        List<Order_Line__c> oli = [SELECT Id,Customer_Price__c,Product__r.Name,Product__r.Site__c,Order__c FROM Order_Line__c WHERE Order__c =: ordr.Id];
        
        Integer lines = OrderUpdatePrices.getLineCount(ordr.Id);
        Boolean o1 = OrderUpdatePrices.createList(ordr.Id);
        Boolean o2 = OrderUpdatePrices.createList(ordr2.Id);
        //Looping through each line item to check prices has been updated
        for(Order_Line__c o: oli){
          system.assertEquals(o.Customer_Price__c, decimal.valueOf(sites.get(o.Product__r.Site__c).get(o.Product__r.Name)));
        }
    }
}