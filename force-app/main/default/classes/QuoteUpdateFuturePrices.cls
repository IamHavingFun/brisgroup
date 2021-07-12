/* This class queries the Future_Quote_Price__c object for prices and
 * update the quote line item with this price 
 * Author - Steve Mason
 * Since - November 2014
 * E-mail - smason@bristan.com
 */

global class QuoteUpdateFuturePrices{
    public List<QuoteLineItem> masterList = new List<QuoteLineItem>();
    Public String cusNo;
    Public double price;
    webservice static void createList(Id qtId)
    {
        QuoteUpdateFuturePrices qup = new  QuoteUpdateFuturePrices();
        try{
            qup.createLists(qtId);
        }
        catch(Exception e){
        system.debug(e);
        }    
    }
    
public void createLists(Id qId)
    {
        List<QuoteLineItem> updatePrice = new List<QuoteLineItem>();
        masterList = [SELECT Id, PricebookEntry.Product2.Name , PriceBookEntry.Product2.Site__c, QuoteId, IFS_Price__c FROM QuoteLineItem WHERE QuoteId =: qId];         
        system.debug('****masterList: ' + masterList.size());
        cusNo = [SELECT Id,Opportunity.Account.AccountNumber FROM Quote WHERE Id=:qid].Opportunity.Account.AccountNumber;
        cusNo = cusNo.substring(0,4);
        System.debug('****CustNo : ' +cusNo);
        Map<string, double> priceMap = new Map<string, double>();
        Future_Quote_Price__c[] fp;
        fp = [SELECT Id, Product_Code__c, Price__c from Future_Quote_Price__c where Account_Number__c =:cusNo];
        for (Future_Quote_Price__c eachpart : fp){   
            if(!priceMap.containsKey(eachpart.Product_Code__c)) {
                priceMap.put(eachpart.Product_Code__c, eachpart.Price__c); 
            }
        }
        System.debug(priceMap);
        
        for(QuoteLineItem qli : masterList)
        {
           System.debug('****Site: ' +qli.PriceBookEntry.Product2.Site__c);
           System.debug('****Product: ' +qli.PricebookEntry.Product2.Name);   
           if(priceMap.containsKey(qli.PricebookEntry.Product2.Name)) {
             price = priceMap.get(qli.PricebookEntry.Product2.Name);
           }
           else {
             price = null;
           }
           if(price != null) {
             System.debug('****Price found!');           
             System.debug('****Price : ' +price);
             qli.IFS_Price__c = decimal.valueOf(price);
             try{
               updatePrice.add(qli); 
             }
             catch(Exception e){
               System.debug(e);
             }
           }
           else
           {
             System.debug('****Price NOT FOUND!');
             qli.IFS_Price__c = null;
             try{
               updatePrice.add(qli);
             }
             catch(Exception e){
               System.debug(e);
             }             
           }
        }
        
        try{
            if(!updatePrice.isEmpty()){
                update updatePrice; 
            }
        }
        catch(Exception e){
            System.debug(e);
        }
        
    }
}