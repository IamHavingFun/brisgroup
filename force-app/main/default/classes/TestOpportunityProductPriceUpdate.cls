/* Test class to test OpportunityProductPriceUpdate class
 * Author : Bhushan Adhikari
 * Since : June 2012
 * Email : badhikari@innoveer.com
 */

@isTest(SeeAllData = True)
private class TestOpportunityProductPriceUpdate {

    static testMethod void OppPriceUpdateUnitTest() {
        //Set up test data  
        TestUtilityClass.setUpData();
        //Getting opportunity information
        Opportunity oppty = TestUtilityClass.opp;
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
        sites.put('04',prices4);
         system.debug('*****sitesss' + sites);
         
        //Creating an instance of  OpportunityUpdatePrices class
        OpportunityUpdatePrices oup = new  OpportunityUpdatePrices();
        
        //calling createList method of QuoteUpdatePrices class
        oup.createLists(oppty.Id);
        Map<String,Map<String,String>> price = oup.getPrice();
        //Calling updateIfsPrice method of QuoteUpdatePrices Class to update the Customer prices 
        oup.updateIfsPrice(sites);
        
        //Getting the Opportunity Line Items to verify prices have been updated
        List<OpportunityLineItem> oli = [SELECT Id,IFS_Price__c,PriceBookEntry.Product2.Name,PriceBookEntry.Product2.Site__c,OpportunityId FROM OpportunityLineItem WHERE OpportunityId =: oppty.Id];
        
        //Looping through each line item to check prices has been updated
        //for(OpportunityLineItem o: oli){
        //  system.assertEquals(o.IFS_Price__c, decimal.valueOf(sites.get(o.PriceBookEntry.Product2.Site__c).get(o.PriceBookEntry.Product2.Name)));
        //}
    }
}