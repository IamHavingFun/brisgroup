/* Test class to test CorrUpdatePrices class
 * Author : Steve Mason
 * Since : Oct 2014
 * Email : smason@bristan.com
 */

@isTest(SeeAllData = True)
private class TestCorrUpdatePricesLE {

    static testMethod void CorrPriceUpdateUnitTest() {
        //Set up test data  
        TestUtilityClass.setUpData();

        Test.startTest(); 

        //Getting opportunity information
        Correspondence__c ordr = TestUtilityClass.corr;
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
         
        //Creating an instance of  CorrUpdatePrices class
        CorrUpdatePricesLE oup = new CorrUpdatePricesLE();
        
        //calling createList method of QuoteUpdatePrices class
        oup.createLists(ordr.Id);
        Map<String,Map<String,String>> price = oup.getPrice();
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        oup.updateIfsPrice(sites);
        
        //Getting the Opportunity Line Items to verify prices have been updated
        List<Price_Enquiry_Line__c> oli = [SELECT Id,Customer_Price__c,Product__r.Name,Product__r.Site__c,Correspondence__c FROM Price_Enquiry_Line__c WHERE Correspondence__c =: ordr.Id];
        
        Integer lines = CorrUpdatePricesLE.getLineCount(ordr.Id);
        Boolean q1 = CorrUpdatePricesLE.createList(ordr.Id);
        //Boolean q2 = CorrUpdatePricesLE.createList(ordr.Id);

        Test.stopTest();
        
        //Looping through each line item to check prices has been updated
        for(Price_Enquiry_Line__c o: oli){
          system.assertEquals(o.Customer_Price__c, decimal.valueOf(sites.get(o.Product__r.Site__c).get(o.Product__r.Name)));
        }
    }
}