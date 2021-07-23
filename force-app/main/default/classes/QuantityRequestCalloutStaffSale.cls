public with sharing class QuantityRequestCalloutStaffSale {
    
        public HttpRequest buildWebServiceRequest(String code,String cusNo ,string site){

        //Build HTTP Request object
        HttpRequest req = new HttpRequest();
        //set the Endpoint url
        Application_Config__c csURL = Application_Config__c.getInstance('QuantityRequestURL');
        string URL = csURL.Value__c;
        req.setEndpoint(URL);

//        req.setEndpoint('http://185.13.140.5:59080/fndext/soapgateway'); // live address **
//      req.setEndpoint('http://185.13.140.5:58080/fndext/soapgateway'); // test address **        
//      req.setEndpoint('http://185.13.140.5:60080/fndext/soapgateway');// IT1.1
        //set request method type
        req.setMethod('GET');
        // Specify username and password to access the endpoint 
        Application_Config__c csUser = Application_Config__c.getInstance('QuantityRequestUserName');
        string username = csUser.Value__c;
//        String username = 'ifsconnect';
        Application_Config__c csPass = Application_Config__c.getInstance('QuantityRequestPassword');
        string password = csPass.Value__c;
//        String password = 'trafficj4m$';
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        //set the Http Header
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'application/soap+xml;charset=utf-8'); 
        req.setHeader('Content-Length', '18'); 
        req.setHeader('soapAction', 'soap_access_provider:WstoreServiceUtility:GetPriceAndInventory');
        req.setTimeout(10000);
        String PAID;
        String result='';
        //for(String s: Codes){
        
        PAID = '<urn:PROD_AND_INVENT_DATA><urn:PRODUCT_NO>' + code + '</urn:PRODUCT_NO><urn:QUANTITY>1</urn:QUANTITY></urn:PROD_AND_INVENT_DATA>';
        result += PAID;
        system.debug('******RESULT STRING : ' + result);
        //}
        
        String soapMsg = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:ifsworld-com:schemas:wstore_service_utility_get_price_and_inventory_request">'+
                            '<soapenv:Header/>'+
                            '<soapenv:Body>'+
                            '<urn:PRICE_AND_INVENTORY_REQUEST>'+
                            '<urn:CUSTOMER_NO>0600/00000</urn:CUSTOMER_NO>'+
                            '<urn:SITE>' + site + '</urn:SITE>'+
                            '<urn:CURRENCY_CODE>GBP</urn:CURRENCY_CODE>'+
                            '<urn:PRICE_CHECK>0</urn:PRICE_CHECK>'+
                            '<urn:INVENTORY_CHECK>1</urn:INVENTORY_CHECK>'+
                            '<urn:PRODUCTS>'+ result +'</urn:PRODUCTS>'+
                            '</urn:PRICE_AND_INVENTORY_REQUEST>'+
                            '</soapenv:Body>'+
                         '</soapenv:Envelope>';
        //specify the request body
        
        
        system.debug('***************soapMsg : ' + soapMsg );
        req.setBody(soapMsg);
        return req;
    } // End of buildWebServiceRequest
    
    //Method that invokes the web service
    public HttpResponse invokeWebService(Http h, HttpRequest req){
     
         try{
             //Invoke Web Service
             HttpResponse res = h.send(req);
             return res;
             }
         catch (Exception e){
             system.debug('CallOutException : ' + e);

         }
         return null;    
    }// End of invokeWebService method
    
    //Method to parse the web service response uing DOM class
    public String handleWebServiceResponse(HttpResponse res){

        system.debug('*************Response : ' + res.getBody());
        string szReturnstring  = ''; 
        
        try
        {
            // Using DOm Class to parse the response
            DOM.Document doc = res.getBodyDocument();
            //Getting the Root element 
            Dom.XMLNode root = doc.getRootElement();
            //Map<String,string> mapprod  = new Map<String,String>();
            
            if(root != null)
            {
                Dom.XMLNode bdyNode = root.getChildElements().get(0);
                if(bdyNode  != null)
                {
                    system.debug('***************bdyNode ' + bdyNode.getName());
                    Dom.XMLNode reqNode = bdyNode.getChildElements().get(0); 
                 
                    if(reqNode != null)
                    {
                        system.debug('***************reqNode ' + reqNode.getName());
                        for(Dom.XMLNode nod: reqNode.getChildElements())
                        {
                            system.debug('***************nod' + nod.getName());
                            if(nod.getName() == 'PRODUCTS')
                            {
                                Dom.XMLNode prodcNode = nod;
                                system.debug('***************prodcNode ' + prodcNode.getName());
                                for(Dom.XMLNode prodinvntnoe : prodcNode.getChildElements())
                                {
                                    String Namespace = prodinvntnoe.getNamespace();
                                    System.debug('***************namespace '+ Namespace );
                                    if(prodinvntnoe.getChildElement('PRODUCT_NO',Namespace )!= null)
                                    {
                                        System.debug('***************quantity '+ prodinvntnoe.getChildElement('QUANTITY',Namespace ).getText() );
                                        
                                        if (prodinvntnoe.getChildElement('QUANTITY_AVAILABLE',Namespace ).getText() == '0')
                                        {
                                            szReturnstring = 'Out of Stock'; 
                                        }
                                        else 
                                        {
                                            szReturnstring = 'In Stock'; 
                                        }
                                        
                                        
                                        //mapprod .put(prodinvntnoe.getChildElement('PRODUCT_NO',Namespace ).getText()
                                        //,prodinvntnoe.getChildElement('QUANTITY',Namespace ).getText() + ' and unit price is ' + prodinvntnoe.getChildElement('SALE_UNIT_PRICE',Namespace ).getText()  );
                                    }
         
                                }
                            }
                        }
                    }
                }
            }
        }
        catch(Exception err)
        {
            szReturnstring  = 'Failed to get Quantity'; 
        }
        system.debug('***************szReturnstring : ' + szReturnstring );
        return szReturnstring;
    }//End of handleWebServiceResponse method
    
    public String main(String code,String cusNo, string s){
        
       //Building Http request
       Http h = new Http();
       system.debug('*************** h : ' +  h );
       HttpRequest req = buildWebServiceRequest(code,cusNo,s);
       
       req.setTimeout(5000);
       system.debug('*************** req : ' +  req );
       
       //invoking web service call 
       HttpResponse res;
       
              
        res = invokeWebService(h, req);
        system.debug('***************res : ' + res );
       
       //Finally handling the response
       String mresponse = 'Failed to get Quantity';
       if (res != null)
             mresponse = handleWebServiceResponse(res);
       
       system.debug('***************mresponse : ' + mresponse );
       
       //returning the response
        return mresponse;
    }
}