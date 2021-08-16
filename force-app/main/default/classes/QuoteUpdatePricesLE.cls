/* This class executes on a button click 'Update Prices' present on Quote detail page. Upon button click 
 * this class creates a list of Product Names that are currently added as QuoteLineItem on this 
 * Quote and pass this List along with the Customer Number(Account Number) and Site to webService which returns 
 * a map of Site , ProductName and Ifs Price, which is used to update the IFS price on QuoteLineItem. 
 * Author - Bhushan Adhikari
 * Since - June 2012
 * E-mail - badhikari@innoveer.com
 * Updated for Lightning - June 2021 - smason@bristan.com
 */

global with sharing class QuoteUpdatePricesLE{
    //List to hold all the QuoteLineItems related to an Quote
    public List<QuoteLineItem> masterList = new List<QuoteLineItem>();
    //List to hold QuoteLineItems from masterList depending upon which site they belong
    public List<QuoteLineItem> site_01 = new List<QuoteLineItem>();
    public List<QuoteLineItem> site_04 = new List<QuoteLineItem>();
    //List to hold Product Names from the separate lists created above, this lists will be passed to Web Service to generate product information in SOAP Request
    List<string> name01 = new List<String>();
    List<string> name04 = new List<String>();
    //Defining map to hold site , its corresponding Product & price Response
    public static Map<String,Map<String,String>> priceRes = new  Map<String,Map<String,String>>();
    //to Store Account Number(Customer no) of the Account related to an quote, this will be passed as 'CUSTOMER_NO' to web service
    Public String cusNo;
    Public String site1 = '01';
    Public String site4 = '04';
    //Will be called from Button "Update Prices" on Quote Detail Page
    @AuraEnabled
    webservice static boolean createList(Id qtId)
    {
        QuoteUpdatePrices qup = new  QuoteUpdatePrices();
        try {
            qup.createLists(qtId);
            priceRes = qup.getPrice();
            qup.updateIfsPrice(priceRes);
            return true;
        }
        catch(Exception e) {
            system.debug(e);
            return false;
        }    
    }
    
    @AuraEnabled
    public static Integer getLineCount(Id qtId) {
        Integer lines = (integer)[Select id, Line_Count__c from Quote where id = :qtId].Line_Count__c;
        return lines;
    }
    
    //This method will separate line items from master list depending on the product site and add it to respective Site list defined above
    public void createLists(Id qId)
    {
        masterList = [SELECT Id, PricebookEntry.Product2.Name , PriceBookEntry.Product2.Site__c, QuoteId, IFS_Price__c FROM QuoteLineItem WHERE QuoteId =: qId];         
        system.debug('****masterList: ' + masterList.size());
        cusNo = [SELECT Id,Opportunity.Account.AccountNumber FROM Quote WHERE Id=:qid].Opportunity.Account.AccountNumber;
        System.debug('****CustNo : ' +cusNo);
        for(QuoteLineItem qli : masterList)
        {
            if(qli.PriceBookEntry.Product2.site__c == '01')
            {site_01.add(qli); }
            if(qli.PriceBookEntry.Product2.site__c == '04')
            {site_04.add(qli); }
        }
        system.debug('****Site01 : ' + site_01.size());
        system.debug('****Site04 : ' + site_04.size());
        //Getting the Names of Products form different Site Lists created 
        if(!site_01.isEmpty())
        {
            for(QuoteLineItem s01 : site_01){name01.add(s01.PricebookEntry.Product2.Name);} 
        }
        if(!site_04.isEmpty())
        {
            for(QuoteLineItem s04 : site_04){name04.add(s04.PricebookEntry.Product2.Name);} 
        }
        
    }
    //This method will call the callWebservice method to get the Prices of the products added on Quote and store them in a map along with the site information
    public Map<String,Map<String,String>> getPrice()
    {
        Map<String,Map<String,String>> response = new  Map<String,Map<String,String>>();
        if(!site_01.isEmpty())
        {
            
            Map<String,String> res =  QuoteUpdatePricesLE.callWebservice(name01,cusNo,site1);
            response.put(site1,res);
        }
        if(!site_04.isEmpty())
        {
            Map<String,String> res =  QuoteUpdatePricesLE.callWebservice(name04,cusNo,site4);
            response.put(site4,res);
        }
        return response;
    }
    
    //This method makes the Web Service call and returns Price information
    public static Map<string,String> callWebservice(List<string> names,String customerNo,String site)
    {
        PriceReqCallout h = new PriceReqCallout();
        Map<String,String> resp = h.main(names,customerNo,site);
        return resp;
    }
    
    //Method to Update the Prices of Opportunity Line Item
    public void updateIfsPrice(Map<String,Map<String,String>> prods)
    {
        system.debug('********priceres: ' + prods);
        List<QuoteLineItem> updtIfsPrice = new List<QuoteLineItem>();
        for(QuoteLineItem qli : masterList)
        {
            system.debug('Inside for loop');
           
            if(prods.containsKey(qli.PriceBookEntry.Product2.Site__c))
            {
                system.debug('Inside if to update');
                qli.IFS_Price__c = decimal.valueOf(prods.get(qli.PriceBookEntry.Product2.Site__c).get(qli.PriceBookEntry.Product2.Name));
                updtIfsPrice.add(qli);
            }
        }
        try{
            if(!updtIfsPrice.isEmpty()){
                update updtIfsPrice; 
            }
        }
        catch(Exception e){
            System.debug(e);
        }
    }
}