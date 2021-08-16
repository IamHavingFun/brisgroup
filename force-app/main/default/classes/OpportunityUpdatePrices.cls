/* This class executes on a button click 'Update Prices' present on Opportunity detail page. Upon button click 
 * this class creates a list of Product Names that are currently added as OpportunityLineItem on this 
 * Opportunity and pass this List along with the Customer Number(Account Number) and Site to webService which returns 
 * a map of ProductName and Ifs Price, which is used to update the IFS price on OpportunityLineItem. 
 * Author - Bhushan Adhikari
 * Since - June 2012
 * E-mail - badhikari@innoveer.com
 */
 
global with sharing class OpportunityUpdatePrices{
    //List to hold all the OpportunityLineItems related to an Opportunity
    public List<OpportunityLineItem> masterList = new List<OpportunityLineItem>();
    //List to hold OpportunityLineItems from masterList depending upon which site they belong
    public List<OpportunityLineItem> site_01 = new List<OpportunityLineItem>();
    public List<OpportunityLineItem> site_04 = new List<OpportunityLineItem>();
    //List to hold Product Names from the separate lists created above, this lists will be passed to Web Service to generate product information in SOAP Request
    List<string> code01 = new List<String>();
    List<string> code04 = new List<String>();
    //Defining map to hold site , its corresponding Product & price Response
    public static Map<String,Map<String,String>> priceRes = new  Map<String,Map<String,String>>();
    //to Store Account Number(Customer no) of the Account related to an opportunity, this will be passed as'CUSTOMER_NO' to web service
    Public String cusNo;
    Public String marNo;
    Public String custType;
    
    //Will be called from Button "Update Prices" on Opportunity Detail Page
    @AuraEnabled
    webservice static void createList(Id optyId)
    {
        OpportunityUpdatePrices up = new  OpportunityUpdatePrices();
        try{
            up.createLists(optyId);
            priceRes = up.getPrice();
            up.updateIfsPrice(priceRes);}
        catch(Exception e){
        system.debug(e);
        }
    }
    
    //This method will separate line items from master list depending on the product site and add it to respective Site list defined above
    public void createLists(Id oppId)
    {
        masterList = [SELECT Id, PricebookEntry.Product2.Name , PriceBookEntry.Product2.Site__c, OpportunityId, IFS_Price__c FROM OpportunityLineItem WHERE OpportunityId =: oppId];         
        system.debug('****masterList: ' + masterList.size());
        cusNo = [Select id, name, Account.AccountNumber from Opportunity where id=:oppid].Account.AccountNumber;
        marNo = [Select id, name, MarketingAccNum__c from Opportunity where id=:oppid].MarketingAccNum__c;
        custType = [Select id, name, AccountType__c from Opportunity where id=:oppid].AccountType__c;
        if(custType != '012D0000000708V')
        {
            cusNo = marNo;
        }
        System.debug('****CustNo : ' +cusNo);
        for(OpportunityLineItem oli : masterList)
        {
            if(oli.PriceBookEntry.Product2.site__c == '01')
            {site_01.add(oli); }
            if(oli.PriceBookEntry.Product2.site__c == '04')
            {site_04.add(oli); }
        }
        system.debug('****Site01 : ' + site_01.size());
        system.debug('****Site04 : ' + site_04.size());
        //Getting the Names of Products form different Site Lists created 
        if(!site_01.isEmpty())
        {
            for(OpportunityLineItem s01 : site_01){code01.add(s01.PricebookEntry.Product2.Name);} 
        }
        if(!site_04.isEmpty())
        {
            for(OpportunityLineItem s04 : site_04){code04.add(s04.PricebookEntry.Product2.Name);} 
        }
        
    }
    //This method will call the callWebservice method to get the Prices of the products added on Opportunity and store them in a map alog with the site information
    public Map<String,Map<String,String>> getPrice()
    {
        Map<String,Map<String,String>> response = new  Map<String,Map<String,String>>();
        if(!site_01.isEmpty())
        {
            string site = '01';
            Map<String,String> res =  OpportunityUpdatePrices.callWebservice(code01,cusNo,site);
            response.put(site,res);
        }
        if(!site_04.isEmpty())
        {
            string site = '04';
            Map<String,String> res =  OpportunityUpdatePrices.callWebservice(code04,cusNo,site);
            response.put(site,res);
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
        List<OpportunityLineItem> updtIfsPrice = new List<OpportunityLineItem>();
        for(OpportunityLineItem oli : masterList)
        {
            system.debug('Inside for loop');
           
            if(prods.containsKey(oli.PriceBookEntry.Product2.Site__c))
            {
                system.debug('Inside if to update');
                oli.IFS_Price__c = decimal.valueOf(prods.get(oli.PriceBookEntry.Product2.Site__c).get(oli.PriceBookEntry.Product2.Name));
                updtIfsPrice.add(oli);
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