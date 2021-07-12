@isTest(SeeAllData = true)
private class TestQuantityRequestCalloutStaffSale{
      static testMethod void testWebService(){
          QuantityRequestCalloutStaffSale h = new QuantityRequestCalloutStaffSale();
          //Creating a list of Product Names that will be passed to buildWebserviceRequest method
          String names;
          names ='HY PUMP70';
          //Customer number
          String customer_No = '026/0000';
          //creating site
          String site = '01';
          //First, build the http request
          HttpRequest req = h.buildWebServiceRequest(names,customer_No,site);
       
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
                     '<PRICE_CHECK>0</PRICE_CHECK>'+
                     '<INVENTORY_CHECK>1</INVENTORY_CHECK>'+
                     '<PRODUCTS>'+
                        '<PROD_AND_INVENT_DATA>'+
                            '<PRODUCT_NO>HY PUMP70</PRODUCT_NO>'+
                            '<QUANTITY>1</QUANTITY>'+
                        '</PROD_AND_INVENT_DATA>'+
                    '</PRODUCTS>'+
                '</PRICE_AND_INVENTORY_REQUEST>'+
            '</SOAP-ENV:Body>'+
        '</SOAP-ENV:Envelope>');
        //Apply test data and attributes to the HttpResponse object as needed
        String mp = h.handleWebServiceResponse(res);
 //       system.assertEquals(mp.size(),1);
    }
}