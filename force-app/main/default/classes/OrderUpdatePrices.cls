/* This class executes on a button click 'Get Prices' present on Order detail page. Upon button click 
 * this class creates a list of Product Names that are currently added as Order_Line__c items on this 
 * Order and pass this List along with the Customer Number(Account Number) and Site to webService which returns 
 * a map of ProductName and Ifs Price, which is used to update the IFS price on Order_Line__c. 
 * Author - Steve Mason
 * Since - August 2013
 * E-mail - smason@bristan.com
 */
 
global with sharing class OrderUpdatePrices{
    //List to hold all the Order_Line__c items related to an Order__c
    public List<Order_Line__c> masterList = new List<Order_Line__c>();
    //List to hold Order_Line__c items from masterList depending upon which site they belong
    public List<Order_Line__c> site_01 = new List<Order_Line__c>();
    public List<Order_Line__c> site_04 = new List<Order_Line__c>();
    //List to hold Product Names from the separate lists created above, this lists will be passed to Web Service to generate product information in SOAP Request
    List<string> code01 = new List<String>();
    List<string> code04 = new List<String>();
    //Defining map to hold site , its corresponding Product & price Response
    public static Map<String,Map<String,String>> priceRes = new  Map<String,Map<String,String>>();
    //to Store Account Number(Customer no) of the Account related to an order, this will be passed as'CUSTOMER_NO' to web service
    Public String cusNo;
    
    //Will be called from Button "Get Prices" on Order Detail Page
    @AuraEnabled
    webservice static boolean createList(Id orderId)
    {
        OrderUpdatePrices up = new OrderUpdatePrices();
        try{
            up.createLists(orderId);
            priceRes = up.getPrice();
            up.updateIfsPrice(priceRes);
            return true;
        }
        catch(Exception e){
        system.debug(e);
        return false;
        }
    }
    
    @AuraEnabled
    public static Integer getLineCount(Id orderId) {
        Integer lines = (integer)[Select id, Line_Count__c from Order__c where id = :orderId].Line_Count__c;
        return lines;
    }
    
    //This method will separate line items from master list depending on the product site and add it to respective Site list defined above
    public void createLists(Id oppId)
    {
        masterList = [SELECT Id, Product_Code__c, Site__c, Order__c, Customer_Price__c, Product_Active__c FROM Order_Line__c WHERE Order__c = :oppId];         
        system.debug('****masterList: ' + masterList.size());
        cusNo = [Select id, IFS_Customer__c from Order__c where id = :oppid].IFS_Customer__c;
        System.debug('****CustNo : ' +cusNo);
        for(Order_Line__c oli : masterList)
        {
            if(oli.Product_Active__c) {
                if(oli.Site__c == '01')
                {site_01.add(oli); }
                if(oli.Site__c == '04')
                {site_04.add(oli); }
            }
        }
        system.debug('****Site01 : ' + site_01.size());
        system.debug('****Site04 : ' + site_04.size());
        //Getting the Names of Products from different Site Lists created 
        if(!site_01.isEmpty())
        {
            for(Order_Line__c s01 : site_01){code01.add(s01.Product_Code__c);} 
        }
        if(!site_04.isEmpty())
        {
            for(Order_Line__c s04 : site_04){code04.add(s04.Product_Code__c);} 
        }
        
    }
    
    //This method will call the callWebservice method to get the Prices of the products added on Order and store them in a map along with the site information
    public Map<String,Map<String,String>> getPrice()
    {
        Map<String,Map<String,String>> response = new  Map<String,Map<String,String>>();
        if(!site_01.isEmpty())
        {
            string site = '01';
            Map<String,String> res =  OrderUpdatePrices.callWebservice(code01,cusNo,site);
            response.put(site,res);
        }
        if(!site_04.isEmpty())
        {
            string site = '04';
            Map<String,String> res =  OrderUpdatePrices.callWebservice(code04,cusNo,site);
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
     
    //Method to Update the Prices of Order Line Items
    public void updateIfsPrice(Map<String,Map<String,String>> prods)
    {
        system.debug('********priceres: ' + prods);
        List<Order_Line__c> updtIfsPrice = new List<Order_Line__c>();
        for(Order_Line__c oli : masterList)
        {
            system.debug('Inside for loop');
           
            if(oli.Product_Active__c) 
            {           
                if(prods.containsKey(oli.Site__c))
                {
                    system.debug('Inside if to update');
                    if(cusNo == '5116/00000')
                    {
                      oli.Customer_Price__c = decimal.valueOf(prods.get(oli.Site__c).get(oli.Product_Code__c));  // no VAT for 5116 (export)
                    }
                    else
                    {
                      oli.Customer_Price__c = decimal.valueOf(prods.get(oli.Site__c).get(oli.Product_Code__c))*1.2;  // multiply by 1.2 to add VAT
                    }
                    updtIfsPrice.add(oli);
                }
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