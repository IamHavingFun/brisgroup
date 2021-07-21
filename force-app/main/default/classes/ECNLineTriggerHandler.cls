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
        // 
        Map<String, String> productApiFieldByECNChange = new Map<String, String>();
        for (ECN_Line_Field_to_Change_Product_Map__mdt productFieldMap : [SELECT MasterLabel, Product_Field_API_Name__c FROM ECN_Line_Field_to_Change_Product_Map__mdt WHERE Is_Active__c = TRUE]) {
          productApiFieldByECNChange.put(productFieldMap.MasterLabel, productFieldMap.Product_Field_API_Name__c);
        }
        // Build query
        String query = 'SELECT ' + String.join(objectApiFields, ',');
        query += ' FROM ' + objectName;
        query += ' WHERE Id IN :productIds'; 
        Map<Id, Product__c> productsById = new Map<Id, Product__c>((List<Product__c>) Database.query(query));
        for (ECN_Line__c ecnl : records) {
            String ecnId = ecnl.ECN__c;
            system.debug('*****Trigger GetOldValue ECN ID: ' + ecnId);
            String pasId = ecnl.PAS_Id__c;
            system.debug('*****Trigger GetOldValue PAS ID: ' + pasId);
            Product__c prod = productsById.get(pasId);
            system.debug('*****Trigger GetOldValue Product ID: ' + prod.Id);
    
            String oldValue = '';

            if (productApiFieldByECNChange.containsKey(ecnl.Field_to_Change__c)) {
              String productFieldAPIName = productApiFieldByECNChange.get(ecnl.Field_to_Change__c);
              oldvalue = String.valueOf(prod.get(productFieldAPIName));
            }
            ecnl.Old_Value__c = oldValue;
        }
    }
}