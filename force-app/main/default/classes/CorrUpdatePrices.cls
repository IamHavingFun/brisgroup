/* This class executes on a button click 'Get Prices' present on Correspondence detail page. Upon button click 
 * this class creates a list of Product Names that are currently added as Price_Enquiry_Line__c items on this 
 * Price Enquiry and pass this List along with the Customer Number(Account Number) and Site to webService which returns 
 * a map of ProductName and Ifs Price, which is used to update the IFS price on Price_Enquiry_Line__c. 
 * Author - Steve Mason
 * Since - October 2014
 * E-mail - smason@bristan.com
 */
 
global class CorrUpdatePrices{
    //List to hold all the Order_Line__c items related to a Correspondence__c
    public List<Price_Enquiry_Line__c> masterList = new List<Price_Enquiry_Line__c>();
    //List to hold Price_Enquiry_Line__c items from masterList depending upon which site they belong
    public List<Price_Enquiry_Line__c> site_01 = new List<Price_Enquiry_Line__c>();
//    public List<Price_Enquiry_Line__c> site_02 = new List<Price_Enquiry_Line__c>();
//    public List<Price_Enquiry_Line__c> site_03 = new List<Price_Enquiry_Line__c>();
    public List<Price_Enquiry_Line__c> site_04 = new List<Price_Enquiry_Line__c>();
    //List to hold Product Names from the separate lists created above, this lists will be passed to Web Service to generate product information in SOAP Request
    List<string> code01 = new List<String>();
//    List<string> code02 = new List<String>();
//    List<string> code03 = new List<String>();
    List<string> code04 = new List<String>();
    //Defining map to hold site , its corresponding Product & price Response
    public static Map<String,Map<String,String>> priceRes = new  Map<String,Map<String,String>>();
    //to Store Account Number(Customer no) of the Account related to an order, this will be passed as'CUSTOMER_NO' to web service
    Public String cusNo;
    Public String curr;
    
    //Will be called from Button "Get Prices" on Correspondence Detail Page
    @AuraEnabled
    webservice static void createList(Id CorrId)
    {
        CorrUpdatePrices up = new CorrUpdatePrices();
        try{
            up.createLists(CorrId);
            priceRes = up.getPrice();
            up.updateIfsPrice(priceRes);}
        catch(Exception e){
        system.debug(e);
        }
    }
    
    //This method will separate line items from master list depending on the product site and add it to respective Site list defined above
    public void createLists(Id oppId)
    {
        masterList = [SELECT Id, Product_Code__c, Product_Site__c, Correspondence__c, Customer_Price__c, Product_Active__c FROM Price_Enquiry_Line__c WHERE Correspondence__c = :oppId];         
        system.debug('****masterList: ' + masterList.size());
        cusNo = [Select id, Account_Number__c from Correspondence__c where id = :oppid].Account_Number__c;
        curr = [Select id, Currency__c from Correspondence__c where id = :oppid].Currency__c;       
        System.debug('****CustNo : ' +cusNo);
        for(Price_Enquiry_Line__c oli : masterList)
        {
            if(oli.Product_Active__c) {
                if(oli.Product_Site__c == '01')
                {site_01.add(oli); }
//                if(oli.Product_Site__c == '02')
//                {site_02.add(oli); }
//                if(oli.Product_Site__c == '03')
//                {site_03.add(oli);}
                if(oli.Product_Site__c == '04')
                {site_04.add(oli); }
            }
        }
        system.debug('****Site01 : ' + site_01.size());
//        system.debug('****Site02 : ' + site_02.size());
//        system.debug('****Site03 : ' + site_03.size());
        system.debug('****Site04 : ' + site_04.size());
        //Getting the Names of Products from different Site Lists created 
        if(!site_01.isEmpty())
        {
            for(Price_Enquiry_Line__c s01 : site_01){code01.add(s01.Product_Code__c);} 
        }
/*      if(!site_02.isEmpty())
        {
            for(Price_Enquiry_Line__c s02 : site_02){code02.add(s02.Product_Code__c);} 
        }
        if(!site_03.isEmpty())
        {
            for(Price_Enquiry_Line__c s03 : site_03){code03.add(s03.Product_Code__c);} 
        }  */
        if(!site_04.isEmpty())
        {
            for(Price_Enquiry_Line__c s04 : site_04){code04.add(s04.Product_Code__c);} 
        }
        
    }
    //This method will call the callWebservice method to get the Prices of the products added on Correspondence and store them in a map along with the site information
    public Map<String,Map<String,String>> getPrice()
    {
        Map<String,Map<String,String>> response = new  Map<String,Map<String,String>>();
        if(!site_01.isEmpty())
        {
            string site = '01';
            Map<String,String> res =  CorrUpdatePrices.callWebservice(code01,cusNo,site,curr);
            response.put(site,res);
        }
/*      if(!site_02.isEmpty())
        {
            string site = '02';
            Map<String,String> res =  CorrUpdatePrices.callWebservice(code02,cusNo,site,curr);
            response.put(site,res);
        }
        if(!site_03.isEmpty())
        {
            string site = '03';
            Map<String,String> res =  CorrUpdatePrices.callWebservice(code03,cusNo,site,curr);
            response.put(site,res);
        }  */
        if(!site_04.isEmpty())
        {
            string site = '04';
            Map<String,String> res =  CorrUpdatePrices.callWebservice(code04,cusNo,site,curr);
            response.put(site,res);
        }
        return response;
    }
    
    //This method makes the Web Service call and returns Price information
    public static Map<string,String> callWebservice(List<string> names,String customerNo,String site, String Curr)
    {
        CorrPriceReqCallout h = new CorrPriceReqCallout();
        Map<String,String> resp = h.main(names,customerNo,site,Curr);
        return resp;
    }
    
    //Method to Update the Prices of Price Enquiry Line Items
    public void updateIfsPrice(Map<String,Map<String,String>> prods)
    {
        system.debug('********priceres: ' + prods);
        List<Price_Enquiry_Line__c> updtIfsPrice = new List<Price_Enquiry_Line__c>();
        for(Price_Enquiry_Line__c oli : masterList)
        {
            system.debug('Inside for loop');
           
            if(oli.Product_Active__c) 
            {           
                if(prods.containsKey(oli.Product_Site__c))
                {
                    system.debug('Inside if to update');
                    oli.Customer_Price__c = decimal.valueOf(prods.get(oli.Product_Site__c).get(oli.Product_Code__c));
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