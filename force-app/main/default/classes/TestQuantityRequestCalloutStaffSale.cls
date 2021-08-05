/**
 * @author 
 * @since 
 */
@IsTest
private class TestQuantityRequestCalloutStaffSale {

    @TestSetup
    static void initData() {
        Application_Config__c quantityRequestURL = new Application_Config__c(
            Name = 'QuantityRequestURL',
            Value__c = 'http://www.google.com'
        );
        insert quantityRequestURL;
        Application_Config__c quantityRequestUserName = new Application_Config__c(
            Name = 'QuantityRequestUserName',
            Value__c = 'testuser'
        );
        insert quantityRequestUserName;
        Application_Config__c quantityRequestPassword = new Application_Config__c(
            Name = 'QuantityRequestPassword',
            Value__c = 'testpassword'
        );
        insert quantityRequestPassword;
    }
    
    @IsTest
    static void testInvalidResponseWebService() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new QuantityFailedCalloutStaffSaleMock()); 
        QuantityRequestCalloutStaffSale h = new QuantityRequestCalloutStaffSale();
        //Creating a list of Product Names that will be passed to buildWebserviceRequest method
        String names;
        names ='HY PUMP70';
        //Customer number
        String customer_No = '026/0000';
        //creating site
        String site = '01';
        //First, build the http request
        String response = h.main(names, customer_No, site);        
        Test.stopTest();
        System.assertEquals('Failed to get Quantity', response, 'Response does not match');
    }

    @IsTest
    static void testOutOfStockCallout() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new QuantityCalloutStaffSaleMock('0')); 
        QuantityRequestCalloutStaffSale h = new QuantityRequestCalloutStaffSale();
        //Creating a list of Product Names that will be passed to buildWebserviceRequest method
        String names;
        names ='HY PUMP70';
        //Customer number
        String customer_No = '026/0000';
        //creating site
        String site = '01';
        //First, build the http request
        String response = h.main(names, customer_No, site);        
        Test.stopTest();
        System.assertEquals('Out of Stock', response, 'Response does not match');
    }

    @IsTest
    static void testInStockCallout() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new QuantityCalloutStaffSaleMock('10')); 
        QuantityRequestCalloutStaffSale h = new QuantityRequestCalloutStaffSale();
        //Creating a list of Product Names that will be passed to buildWebserviceRequest method
        String names;
        names ='HY PUMP70';
        //Customer number
        String customer_No = '026/0000';
        //creating site
        String site = '01';
        //First, build the http request
        String response = h.main(names, customer_No, site);        
        Test.stopTest();
        System.assertEquals('In Stock', response, 'Response does not match');
    }

    /**
     * Mock Test Data
     */
    public class QuantityCalloutStaffSaleMock implements HttpCalloutMock {
        
        private String quantity;

        /**
         * 
         * @param quantity 
         */
        public QuantityCalloutStaffSaleMock(String quantity) {
            this.quantity = quantity;
        }

        /**
         * Implement this interface method
         * @param request 
         * @return  `HTTPResponse`
         */
        public HTTPResponse respond(HTTPRequest request) {
            // Create a fake response
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
                                '<QUANTITY_AVAILABLE>' + quantity + '</QUANTITY_AVAILABLE>'+
                            '</PROD_AND_INVENT_DATA>'+
                        '</PRODUCTS>'+
                    '</PRICE_AND_INVENTORY_REQUEST>'+
                '</SOAP-ENV:Body>'+
            '</SOAP-ENV:Envelope>');
            res.setStatusCode(200);
            return res; 
        }
    } 

    /**
     * Mock Test Data
     */
    public class QuantityFailedCalloutStaffSaleMock implements HttpCalloutMock {
        
        /**
         * Implement this interface method
         * @param request 
         * @return  `HTTPResponse`
         */
        public HTTPResponse respond(HTTPRequest request) {
            // Create a fake response
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
            res.setStatusCode(200);
            return res; 
        }
    }    
}