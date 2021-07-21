/**
 * @author PolSource
 */
public with sharing class ECNLineTriggerHandler {

    private ECNLineTriggerHandler() {}
    
    /**
     * @param records 
     */
    public static void updateOldValue(List<ECN_Line__c> records) {
        List<String> productIds = new List<String>();
        // get all product Ids
        for (ECN_Line__c ecnl : records) {
          productIds.add(ecnl.PAS_Id__c);
        }
        // get all product fields
        String objectName = 'Product__c';
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();        
        // add all field api names to the list
        List<String> objectApiFields = new List<String>(objectFields.keySet());
        // Get all ACTIVE ECN Line Field To Change Product Map records
        // this map returns the API name of the Product__c object we are going to use based on the Field_to_Change__c field value from ECN Line record
        Map<String, String> productApiFieldByECNChange = new Map<String, String>();
        for (ECN_Line_Field_to_Change_Product_Map__mdt productFieldMap : [SELECT MasterLabel, Product_Field_API_Name__c FROM ECN_Line_Field_to_Change_Product_Map__mdt WHERE Is_Active__c = TRUE]) {
          productApiFieldByECNChange.put(productFieldMap.MasterLabel, productFieldMap.Product_Field_API_Name__c);
        }
        // Build query
        String query = 'SELECT ' + String.join(objectApiFields, ',');
        query += ' FROM ' + objectName;
        query += ' WHERE Id IN :productIds'; 
        // This Map returns a Product__c record given its ID
        Map<Id, Product__c> productsById = new Map<Id, Product__c>((List<Product__c>) Database.query(query));
        for (ECN_Line__c ecnl : records) {
          // Get Product Id FROM ECN Line record
            String pasId = ecnl.PAS_Id__c;
            system.debug('*****Trigger GetOldValue PAS ID: ' + pasId);
            // Get Product Record for the given ID
            Product__c prod = productsById.get(pasId);
            system.debug('*****Trigger GetOldValue Product ID: ' + prod.Id);
    
            String oldValue = '';

            // Checks if the value coming from Field_to_Change__c is found on productApiFieldByECNChange map
            if (productApiFieldByECNChange.containsKey(ecnl.Field_to_Change__c)) {
              // get Product Field API Name
              String productFieldAPIName = productApiFieldByECNChange.get(ecnl.Field_to_Change__c);
              // Sets old value based on Product's property
              oldvalue = String.valueOf(prod.get(productFieldAPIName));
            }
            ecnl.Old_Value__c = oldValue;
        }
    }
}