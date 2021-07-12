/* Test class to test OrderUpdatePrices class
 * Author : Steve Mason
 * Since : Sept 2013
 * Email : smason@bristan.com
 */

@isTest(SeeAllData = True)
private class TestStaffSaleUpdatePricesLE {

    static testMethod void StaffSalePriceUpdateUnitTest() {
        //Set up test data  
        TestUtilityClass.setUpData();
        //Getting opportunity information
        Staff_Sale__c ordr = TestUtilityClass.ss;
        Staff_Sale__c ordr2 = TestUtilityClass.ss2;      
        //Creating a map that stores Site and its corresponding product information
        Map<String,Map<String,string>> sites =new Map<String,Map<String,string>>();
        //Creating Different Price maps       
        Map<String,string> prices1 = new Map<String,string>();
        prices1.put('HY PUMP7012','164.08');
        sites.put('01',prices1);
        prices1.put('HY PUMP7014','164.08');
        sites.put('01',prices1);
        Map<String,string> prices4 = new Map<String,string>();
        prices4.put('HY PUMP7013','145.50');
        sites.put('04',prices4);
        prices4.put('HY PUMP7015','145.50');
        sites.put('04',prices4);
        system.debug('*****sitesss' + sites);
        
        //Creating an instance of  OrderUpdatePrices class
        StaffSalesUpdatePricesLE oup = new StaffSalesUpdatePricesLE();
        
        //calling createList method of QuoteUpdatePrices class
        oup.createLists(ordr.Id);
        Map<String,Map<String,String>> price = oup.getPrice();
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        oup.updateIfsPrice(sites);
        oup.updateIfsStock(sites);
        Map<String,Map<String,string>> res = oup.getStock();      
        //calling createList method of QuoteUpdatePrices class
        oup.createLists(ordr2.Id);
        price = oup.getPrice();
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        oup.updateIfsPrice(sites);
        oup.updateIfsStock(sites);        
        res = oup.getStock();     
        
        //Getting the Opportunity Line Items to verify prices have been updated
        List<Staff_Sale_Line__c> oli = [SELECT Id,Customer_Price__c,Product__r.Name,Product__r.Site__c,Staff_Sale__c FROM Staff_Sale_Line__c WHERE Staff_Sale__c =: ordr.Id];
        
        Integer lines = StaffSalesUpdatePricesLE.getLineCount(ordr.Id);
        Boolean o1 = StaffSalesUpdatePricesLE.createList(ordr.Id);
        Boolean o2 = StaffSalesUpdatePricesLE.createList(ordr2.Id);
        
        //Looping through each line item to check prices has been updated
        for(Staff_Sale_Line__c o: oli){
          system.assertEquals(o.Customer_Price__c, decimal.valueOf(sites.get(o.Product__r.Site__c).get(o.Product__r.Name))*1.2);
        }
    }
}