/* This class executes on a button click 'Get Prices' present on Order detail page. Upon button click 
 * this class creates a list of Product Names that are currently added as Order_Line__c items on this 
 * Order and pass this List along with the Customer Number(Account Number) and Site to webService which returns 
 * a map of ProductName and Ifs Price, which is used to update the IFS price on Order_Line__c. 
 * Author - Steve Mason
 * Since - August 2013
 * E-mail - smason@bristan.com
 */
 
global with sharing class StaffSalesUpdatePrices{
    //List to hold all the Order_Line__c items related to an Order__c
    public List<Staff_Sale_Line__c> masterList = new List<Staff_Sale_Line__c>();
    //List to hold Order_Line__c items from masterList depending upon which site they belong
    public List<Staff_Sale_Line__c> site_01 = new List<Staff_Sale_Line__c>();
    public List<Staff_Sale_Line__c> site_04 = new List<Staff_Sale_Line__c>();
    //List to hold Product Names from the separate lists created above, this lists will be passed to Web Service to generate product information in SOAP Request
    List<string> code01 = new List<String>();
    List<string> code04 = new List<String>();
    //Defining map to hold site , its corresponding Product & price Response
    public static Map<String,Map<String,String>> priceRes = new  Map<String,Map<String,String>>();
    public static Map<String,Map<String,String>> stockRes = new  Map<String,Map<String,String>>();
    //to Store Account Number(Customer no) of the Account related to an order, this will be passed as'CUSTOMER_NO' to web service
    Public String cusNo;
    Public String stock_level = '';
    
    //Will be called from Button "Get Prices" on Order Detail Page
    @AuraEnabled
    webservice static boolean createList(Id recordId)
    {
        StaffSalesUpdatePrices up = new StaffSalesUpdatePrices();
        try{
            up.createLists(recordId);
            priceRes = up.getPrice();
            stockRes = up.getStock();
            up.updateIfsPrice(priceRes);
            up.updateIfsStock(stockRes);
            return true;
        }
        catch(Exception e){
            system.debug(e);
            return false;
        }
    }
    
    //This method will separate line items from master list depending on the product site and add it to respective Site list defined above
    public void createLists(Id oppId)
    {
        masterList = [SELECT Id, Product_Code__c, Site__c, Staff_Sale__c, Customer_Price__c, Product_Active__c, Stock_Level__c, Package_Part__c, Package_Part_Components__c FROM Staff_Sale_Line__c WHERE Staff_Sale__c = :oppId];         
        system.debug('****masterList: ' + masterList.size());
        cusNo = [Select id, Sales_Type__c from Staff_Sale__c where id = :oppid].Sales_Type__c;
        if(cusNo == 'Staff Sales' || cusNo == 'Customer') {
          cusNo = '0010/00000'; }
        else {
          cusNo = '0009/00000'; }
        System.debug('****CustNo : ' +cusNo);
        for(Staff_Sale_Line__c oli : masterList)
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
            for(Staff_Sale_Line__c s01 : site_01){code01.add(s01.Product_Code__c);} 
        }
        if(!site_04.isEmpty())
        {
            for(Staff_Sale_Line__c s04 : site_04){code04.add(s04.Product_Code__c);} 
        }
        
    }
    
    //This method will call the callWebservice method to get the Prices of the products added on Order and store them in a map along with the site information
    public Map<String,Map<String,String>> getPrice()
    {
        Map<String,Map<String,String>> response = new  Map<String,Map<String,String>>();
        if(!site_01.isEmpty())
        {
            string site = '01';
            Map<String,String> res =  StaffSalesUpdatePrices.callWebservice(code01,cusNo,site);
            response.put(site,res);
        }
        if(!site_04.isEmpty())
        {
            string site = '04';
            Map<String,String> res =  StaffSalesUpdatePrices.callWebservice(code04,cusNo,site);
            response.put(site,res);
        }
        return response;
    }
    
    //This method will call the callWebservice method to get the Stock of the products added on Order and store them in a map along with the site information
    public Map<String,Map<String,String>> getStock()
    {
        Map<String,Map<String,String>> responseStock = new  Map<String,Map<String,String>>();
        if(!site_01.isEmpty())
        {
            string site = '01';
            Map<String,String> resMap = new Map<String, String>();
            for(String prodCode : code01)  // For each product code in code01
            {
              for(Staff_Sale_Line__c s01 : site_01)  // Loop through the lines in site_01
              {
                if(s01.Product_Code__c == prodCode)  // Check if line code = code01 code
                {
                  if(s01.Package_Part__c)  //  If it's a package part, do this
                  { 
                    stock_level = '999999'; // reset stock level
                    system.debug('********STOCK_LEVEL: ' + stock_level);
                    // Get and loop component parts, to find the lowest value for stock level
                    String[] comps = s01.Package_Part_Components__c.split(';');  // Split package part components by semicolon
                    system.debug('********COMPS: ' + comps);
                    for(String comp : comps)  // Loop comps array
                    {
                      string compCode = comp.split('~').get(0);  // Get code from comp
                      system.debug('********COMPCODE: ' + compCode);
                      string compQty = comp.split('~').get(1);  // Get qty from comp
                      system.debug('********COMPQTY: ' + compQty);
                      String res = StaffSalesUpdatePrices.callWebserviceStock(compCode,cusNo,site);  // Get stock level
                      system.debug('********RES: ' + res);
                      if(res.IsNumeric())  // Check response is numeric
                      {
                        Integer i = integer.valueof(res);  // convert response to integer
                        i = i/integer.valueof(compQty);  // divide result by component qty 
                        if(i < integer.valueof(stock_level)) stock_level = res;  // if response is less than than stock_level, set stock_level
                      }
                      else {
                        stock_level = '0'; }  //  Not numeric, so not in stock
                    }
                    if(stock_level=='999999') stock_level = '0';  // Reset stock_level if it hasn't changed (most likely no stock)
                    if(integer.valueof(stock_level) > 0) {
                      resMap.put(prodCode,'In Stock'); } // Put prodCode and stock_level into resMap
                    else {
                      resMap.put(prodCode,'Out of Stock'); }
                      
                  }
                  else
                  {
                    String res =  StaffSalesUpdatePrices.callWebserviceStock(prodCode,cusNo,site);
                    if(res.IsNumeric())
                    {
                      if(integer.valueof(res) > 0) {
                        resMap.put(prodCode,'In Stock'); }
                      else {
                        resMap.put(prodCode,'Out of Stock'); }
                    }
                    else {
                      resMap.put(prodCode,'Out of Stock'); 
                    }
                  }
                }
              }
            }
            responseStock.put(site,resMap);
        }
        if(!site_04.isEmpty())
        {
            string site = '04';
            Map<String,String> resMap = new Map<String, String>();
            for(String prodCode : code04)  // For each product code in code01
            {
              for(Staff_Sale_Line__c s04 : site_04)  // Loop through the lines in site_04
              {
                if(s04.Product_Code__c == prodCode)  // Check if line code = code04 code
                {
                  if(s04.Package_Part__c)  //  If it's a package part, do this
                  { 
                    stock_level = '999999'; // reset stock level
                    system.debug('********STOCK_LEVEL: ' + stock_level);
                    // Get and loop component parts, to find the lowest value for stock level
                    String[] comps = s04.Package_Part_Components__c.split(';');  // Split package part components by semicolon
                    system.debug('********COMPS: ' + comps);
                    for(String comp : comps)  // Loop comps array
                    {
                      string compCode = comp.split('~').get(0);  // Get code from comp
                      system.debug('********COMPCODE: ' + compCode);
                      string compQty = comp.split('~').get(1);  // Get qty from comp
                      system.debug('********COMPQTY: ' + compQty);
                      String res = StaffSalesUpdatePrices.callWebserviceStock(compCode,cusNo,site);  // Get stock level
                      system.debug('********RES: ' + res);
                      if(res.IsNumeric())  // Check response is numeric
                      {
                        Integer i = integer.valueof(res);  // convert response to integer
                        i = i/integer.valueof(compQty);  // divide result by component qty 
                        if(i < integer.valueof(stock_level)) stock_level = res;  // if response is less than than stock_level, set stock_level
                      }
                      else {
                        stock_level = '0'; }  //  Not numeric, so not in stock
                    }
                    if(stock_level=='999999') stock_level = '0';  // Reset stock_level if it hasn't changed (most likely no stock)
                    if(integer.valueof(stock_level) > 0) {
                      resMap.put(prodCode,'In Stock'); } // Put prodCode and stock_level into resMap
                    else {
                      resMap.put(prodCode,'Out of Stock'); }
                      
                  }
                  else
                  {
                    String res =  StaffSalesUpdatePrices.callWebserviceStock(prodCode,cusNo,site);
                    if(res.IsNumeric())
                    {
                      if(integer.valueof(res) > 0) {
                        resMap.put(prodCode,'In Stock'); }
                      else {
                        resMap.put(prodCode,'Out of Stock'); }
                    }
                    else {
                      resMap.put(prodCode,'Out of Stock'); }
                  }
                }
              }
            }
            responseStock.put(site,resMap);
        }
        return responseStock;
    }
    
    //This method makes the Web Service call and returns Price information
    public static Map<string,String> callWebservice(List<string> names,String customerNo,String site)
    {
        PriceReqCallout h = new PriceReqCallout();
        Map<String,String> resp = h.main(names,customerNo,site);
        return resp;
    }
    
    //This method makes the Web Service call and returns Stock information
    public static String callWebserviceStock(String names,String customerNo,String site)
    {
        QuantityRequestCallout g = new QuantityRequestCallout();
        String Quantity = g.main(names, '',site);
        if (Quantity == ''){
            Quantity = 'Quantity not found';
        }
        return Quantity;
    }
    
    //Method to Update the Prices of Order Line Items
    public void updateIfsPrice(Map<String,Map<String,String>> prods)
    {
        system.debug('********priceres: ' + prods);
        List<Staff_Sale_Line__c> updtIfsPrice = new List<Staff_Sale_Line__c>();
        for(Staff_Sale_Line__c oli : masterList)
        {
            system.debug('Inside for loop');
           
            if(oli.Product_Active__c) 
            {           
                if(prods.containsKey(oli.Site__c))
                {
                    system.debug('Inside if to update');
                    oli.Customer_Price__c = decimal.valueOf(prods.get(oli.Site__c).get(oli.Product_Code__c))*1.2;  // multiply by 1.2 to add VAT
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
    
    //Method to Update the Stock of Order Line Items
    public void updateIfsStock(Map<String,Map<String,String>> prods)
    {
        system.debug('********stockres: ' + prods);
        List<Staff_Sale_Line__c> updtIfsStock = new List<Staff_Sale_Line__c>();
        for(Staff_Sale_Line__c oli : masterList)
        {
            system.debug('Inside for loop');
           
            if(oli.Product_Active__c) 
            {           
                if(prods.containsKey(oli.Site__c))
                {
                    system.debug('Inside if to update');
                    oli.Stock_Level__c = prods.get(oli.Site__c).get(oli.Product_Code__c);  
                    updtIfsStock.add(oli);
                }
            }
        }
        try{
            if(!updtIfsStock.isEmpty()){
                update updtIfsStock; 
            }
        }
        catch(Exception e){
            System.debug(e);
        }
    }
}