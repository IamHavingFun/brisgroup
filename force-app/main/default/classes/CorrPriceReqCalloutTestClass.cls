/* This test calss is used to test the apex webservice callout
 * With the web service processing broken up into 3 methods, 
 * we can test all of the Apex methods except for the small method that performs the web service call.
 * Author : Bhsuhan Adhikari
 * Modified: Steve Mason - Added currency parameter
 * Since : October 2014
 * E-mail : badhikari@innoveer.com
 */
@isTest(SeeAllData = true)
private class CorrPriceReqCalloutTestClass{
      static testMethod void testWebService(){
          CorrPriceReqCallout h = new CorrPriceReqCallout();
          //Creating a list of Product Names that will be passed to buildWebserviceRequest method
          List<string> names= new String[3];
          names[0] ='HY PUMP70';
          names[1] = 'HY PUMP50';
          names[2] = 'HY PUMP100';
          //Customer number
          String customer_No = '0269/0000';
          //creating site
          String site = '01';
          //creating currency
          String curr = 'GBP';
          //First, build the http request
          HttpRequest req = h.buildWebServiceRequest(names,customer_No,site,curr);
       
          //NOTE - WE DO NOT EXECUTE THE METHOD, invokeWebService. 
          //Now, since we can't execute the actual web service, 
          //write apex code to build a sample HttpResponse object
          HttpResponse res = new HttpResponse();
          res.setBody('<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">'+
            '<SOAP-ENV:Body>'+
                '<PRICE_AND_INVENTORY_REQUEST xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn:ifsworld-com:schemas:wstore_service_utility_get_price_and_inventory_response">'+
                    '<CUSTOMER_NO>0269/00000</CUSTOMER_NO>'+
                     '<SITE>01</SITE>'+
                     '<CURRENCY_CODE>GBP</CURRENCY_CODE>'+
                     '<PRICE_CHECK>1</PRICE_CHECK>'+
                     '<PRODUCTS>'+
                        '<PROD_AND_INVENT_DATA>'+
                            '<SALE_UNIT_PRICE>164.08</SALE_UNIT_PRICE>'+
                            '<PRODUCT_NO>HY PUMP70</PRODUCT_NO>'+
                            '<QUANTITY>1</QUANTITY>'+
                        '</PROD_AND_INVENT_DATA>'+
                        '<PROD_AND_INVENT_DATA>'+
                            '<SALE_UNIT_PRICE>0.0</SALE_UNIT_PRICE>'+
                            '<PRODUCT_NO>HY PUMP100</PRODUCT_NO>'+
                            '<QUANTITY>1</QUANTITY>'+
                        '</PROD_AND_INVENT_DATA>'+
                        '<PROD_AND_INVENT_DATA>'+
                            '<SALE_UNIT_PRICE>120.71</SALE_UNIT_PRICE>'+
                            '<PRODUCT_NO>HY PUMP50</PRODUCT_NO>'+
                            '<QUANTITY>1</QUANTITY>'+
                        '</PROD_AND_INVENT_DATA>'+
                    '</PRODUCTS>'+
                '</PRICE_AND_INVENTORY_REQUEST>'+
            '</SOAP-ENV:Body>'+
        '</SOAP-ENV:Envelope>');
        //Apply test data and attributes to the HttpResponse object as needed
        Map<String,String> mp = h.handleWebServiceResponse(res);
        system.assertEquals(mp.size(),3);
        
        Map<String,String> mn = h.main(names,customer_No,site,curr);
    }
}