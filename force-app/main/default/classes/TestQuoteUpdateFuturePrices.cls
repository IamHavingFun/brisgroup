/* 
 * Author : Steve Mason
 * Since : Nov 2014
 * Email : smason@bristan.com
 */

@isTest(SeeAllData = True)
private class TestQuoteUpdateFuturePrices {
        public static List<Product2> product = new List<Product2>();
        public static List<Future_Quote_Price__c> fqp = new List<Future_Quote_Price__c>(); 
        public static List<QuoteLineItem> Qli = new List<QuoteLineItem>();                       

static testMethod void QuoteUpdateFuturePricesUnitTest() {
        //Set up test data  
        TestUtilityClass.setUpData();
        //Account Data
        Account acc = TestUtilityClass.acc;
        //Getting standard PriceBook information
        PriceBook2 pb = [SELECT Id,Name FROM PriceBook2 WHERE Name=:'Standard Price Book' Limit 1];     
        //Opportunity Data
        Opportunity opp = TestUtilityClass.opp;
        //Quote Data
        Quote q = TestUtilityClass.q;
        // Inserting Product Data 
        product.add(new Product2(Name='J BAS C',ProductCode='J BAS C',Site__c = '01', IsActive=true));
        product.add(new Product2(Name='PM BAS C',ProductCode='PM BAS C',Site__c = '01', IsActive=true));
        try{
            insert product;
        }
        catch(DMLException e){
            system.debug(e);
        }
        //Inserting Products into StandardPricebook       
        List<PriceBookEntry> pbe = new List<PriceBookEntry>();
        pbe.add(new PriceBookEntry(Product2Id= product[0].id, PriceBook2Id=pb.id,UnitPrice=100,IsActive=True,CurrencyIsoCode=' GBP'));
        pbe.add(new PriceBookEntry(Product2Id= product[1].id, PriceBook2Id=pb.id,UnitPrice=150,IsActive=True,CurrencyIsoCode=' GBP'));
        try{
            insert pbe;
        }
        catch(Exception e){
        system.debug(e);}   
        // Inserting Future Price
        fqp.add(new Future_Quote_Price__c(Product_Code__c='J BAS C',Site__c='01',Price__c = 123.45, Account_Number__c='0269/04261'));
        try{
            insert fqp;
        }
        catch(DMLException e){
            system.debug(e);
        }
//creating QuoteLineItems  
        QuoteLineItem qp = new QuoteLineItem(Quoteid = q.id,unitPrice = 105.00,PriceBookEntryId= pbe[0].id,IFS_Price__c=0,Quantity=10);
        Qli.add(qp);
        QuoteLineItem qp2 = new QuoteLineItem(Quoteid = q.id,unitPrice = 104.00,PriceBookEntryId= pbe[1].id,IFS_Price__c=0,Quantity=10);
        Qli.add(qp2);
        insert Qli;         
// Call price update
        QuoteUpdateFuturePrices qufp = new QuoteUpdateFuturePrices();
        qufp.createLists(q.Id);

        
        //Getting the Opportunity Line Items to verify prices have been updated
//        List<OpportunityLineItem> oli = [SELECT Id,IFS_Price__c,PriceBookEntry.Product2.Name,PriceBookEntry.Product2.Site__c,OpportunityId FROM OpportunityLineItem WHERE OpportunityId =: oppty.Id];
        
        //Looping through each line item to check prices has been updated
        //for(OpportunityLineItem o: oli){
//          system.assertEquals(o.IFS_Price__c, decimal.valueOf(sites.get(o.PriceBookEntry.Product2.Site__c).get(o.PriceBookEntry.Product2.Name)));
  //      }
    }
}