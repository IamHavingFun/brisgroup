/**
 * 
 * @author PolSource
 */
public with sharing class ECNTriggerHandler {

    private ECNTriggerHandler() {}

    /**
     * @param records 
     */
    public static void updateChildLinesOldValue(List<ECN__c> records) {
        // ECN Id List
        List<String> ecnIds = new List<String>();
        for (ECN__c ecn : records) {
            // If ECN's status is New or Rejected or Awaiting Finance Approval
            if(ecn.Status__c=='New' || ecn.Status__c=='Rejected' || ecn.Status__c=='Awaiting Finance Approval') {
                // Add ECN Id to List
                ecnIds.add(ecn.Id);
            }
        }
    
        List<ECN_Line__c> lines = [SELECT Id, Field_to_Change__c, New_Value__c, Old_Value__c FROM ECN_Line__c WHERE ECN__c IN :ecnIds];
        for(ECN_Line__c line : lines) {
          // Loop and update all lines on an ECN at New status when the ECN is saved
          // This is to retrigger the 'fetch old value' trigger so that the correct value is pulled when changing the product on a cloned ECN
          line.Old_Value__c = '';
        }
    
        if (!lines.isEmpty()) {
            update lines;
        }        
    }
    
    /**
     * @param records 
     */
    public static void updateRelatedProducts(List<ECN__c> records) {
        // get all product and ECN IDs (binding variable used on WHERE clause)
        List<String> productIds = getAllProductIds(records);
        System.debug('productIds: ' + productIds);
        List<String> newEcnIds = getNewECNIds(records);
        List<String> allecnIds = getAllECNIds(records);
        
        updateOldValueOnLines(newEcnIds);

        // 
        Map<String, ECN_Line_Field_to_Change_Product_Map__mdt> productApiFieldByECNChange = getProductFieldMappings();
        // List of Lines by ECN record Id
        Map<String, List<ECN_Line__c>> linesByECN = getECNLinesByECNId(allecnIds);
        // Returns Sales Group Id based on its Key
        Map<String, String> salesGroupIdByKey = getSalesGroupIdByKey(linesByECN.values());
        // Returns Supplier Id based on its Key
        Map<String, String> supplierIdByKey = getSupplierIdByKey(linesByECN.values());

        // products to be updated
        List<Product__c> products = new List<Product__c>();
        // build query for Product__c object
        String query = getProductQuery();
        // Returns a Product__c record based on its ID
        Map<String, Product__c> productsById = new Map<String, Product__c>((List<Product__c>) Database.query(query));
        for (ECN__c ecn : records) {
            // get Product Record
            Product__c proddata = productsById.get(ecn.Product__c);
            ID PASOwner = proddata.OwnerID;
            // Update PAS_Owner__c field value with Owner Id value from Product record
            ecn.PAS_Owner__c = PASOwner;  

            if (ecn.Status__c == 'Completed') {
                Product__c prod = productsById.get(ecn.Product__c);

                if (!linesByECN.containsKey(ecn.Id)) {
                    continue;
                }
                list<ECN_Line__c> el = linesByECN.get(ecn.Id);
                
                if (ecn.Type__c == 'Discontinuation') {
                    prod.Discontinuation_Effective_Date__c = ecn.Effective_Date__c;
                }

                for (ECN_Line__c ecnl : el) {
                    if (ecnl.Field_to_Change__c == 'Sales Group') {
                        // Get Sales Group Id based on its Key
                        prod.Sales_Group__c = salesGroupIdByKey.get(ecnl.New_Value__c);
                    } else if (ecnl.Field_to_Change__c == 'Supplier') {
                        // Get Supplier Id based on its key
                        prod.Supplier__c = supplierIdByKey.get(ecnl.New_Value__c);
                    } else if (productApiFieldByECNChange.containsKey(ecnl.Field_to_Change__c)) {
                        // productMap variable contains Product Field to use and its Data Type (to Properly format it when assigning the new value)
                        ECN_Line_Field_to_Change_Product_Map__mdt productMap = productApiFieldByECNChange.get(ecnl.Field_to_Change__c);
                        Object newValue = null;
                        // Field Type is Decimal, new value must be formatted using Decimal.valueOf function
                        if (productMap.Product_Field_Type__c == 'Decimal'  && !String.isBlank(ecnl.New_Value__c)) {
                            newValue = Decimal.valueOf(ecnl.New_Value__c);
                        } else if (productMap.Product_Field_Type__c == 'Boolean') {
                            // Field Type is Boolean, new value must be formatted using Boolean.valueOf function
                            newValue = Boolean.valueOf(ecnl.New_Value__c);
                        } else {
                            // String value is used
                            newValue = ecnl.New_Value__c;
                        }
                        if (ecnl.Field_to_Change__c == 'Supersede Code') {
                            prod.Supersede_Date__c = ecn.Effective_Date__c;
                        }
                        prod.put(productMap.Product_Field_API_Name__c, newValue);
                    }
                }
                // update product status to Complete
                prod.Status__c = 'Complete';
                // add record to lisy
                products.add(prod);
            }
        }
        if (!products.isEmpty()) {
            // Perform DML operation using List of SObjects
            update products;
        }
    }

    /**
     * @param records ECN record
     * @return  `List<String>` all Product Ids
     */
    private static List<String> getAllProductIds(List<ECN__c> records) {
        List<String> productIds = new List<String>();
        for (ECN__c ecn : records) {
            if (String.isNotBlank(ecn.Product__c)) {
                productIds.add(ecn.Product__c);
            }
        }
        return productIds;
    }

    /**
     * @param records ECN records
     * @return  `List<String>` all ECN ids were their status is one of the following: New, Rejected or Awaiting Finance Approval
     */
    private static List<String> getNewECNIds(List<ECN__c> records) {
        List<String> newEcnIds = new List<String>();
        List<String> allowedStatuses = new List<String> {'New', 'Rejected', 'Awaiting Finance Approval'};
        for (ECN__c ecn : records) {
            if (allowedStatuses.contains(ecn.Status__c) && String.isNotBlank(ecn.Id)) {
                newEcnIds.add(ecn.Id);
            }
        }
        return newEcnIds;
    }

    /**
     * @param records ECN Records we want to get their Ids
     * @return  `List<String>`
     */
    private static List<String> getAllECNIds(List<ECN__c> records) {
        List<String> ecnIds = new List<String>();
        for (ECN__c ecn : records) {
            if (String.isNotBlank(ecn.Id)) {
                ecnIds.add(ecn.Id);
            }
        }
        return ecnIds;
    }

    private static void updateOldValueOnLines(List<String> newEcnIds) {
        List<ECN_Line__c> lines = new List<ECN_Line__c>();
        for (ECN_Line__c line : [SELECT Id FROM ECN_Line__c WHERE ECN__c IN :newEcnIds]) {
            // Loop and update all lines on an ECN at New status when the ECN is saved
            // This is to retrigger the 'fetch old value' trigger so that the correct value is pulled when changing the product on a cloned ECN
            line.Old_Value__c = '';
            lines.add(line);
        }
        if (!lines.isEmpty()) {
            update lines;
        }        
    }

    /**
     * @param allecnIds 
     * @return  `Map<String, List<ECN_Line__c>>` List of ECN_Line__c records given an ECN Id
     */
    private static Map<String, List<ECN_Line__c>> getECNLinesByECNId(List<String> allecnIds) {
        Map<String, List<ECN_Line__c>> linesByECN = new Map<String, List<ECN_Line__c>>();
        for (ECN_Line__c line : [SELECT Id, Field_to_Change__c, New_Value__c, ECN__c FROM ECN_Line__c WHERE ECN__c IN :allecnIds]) {
            // If map already has values for the given ECN Id
            if (linesByECN.containsKey(line.ECN__c)) {
                // Get list and add new record to it
                List<ECN_Line__c> lineList = linesByECN.get(line.ECN__c);
                lineList.add(line);
                // update map for the given ECN Id
                linesByECN.put(line.ECN__c, lineList);                
            } else {
                // Create new map entry with a list including the current ECN_Line__c record
                linesByECN.put(line.ECN__c, new List<ECN_Line__c>{ line });
            }
        }
        return linesByECN;
    }

    /**
     * @return  `Map<String, ECN_Line_Field_to_Change_Product_Map__mdt>` map that returns the ECN_Line_Field_to_Change_Product_Map__mdt configuration
     *          record based on the ECN Line Field to Change Value
     */
    private static Map<String, ECN_Line_Field_to_Change_Product_Map__mdt> getProductFieldMappings() {
        Map<String, ECN_Line_Field_to_Change_Product_Map__mdt> productApiFieldByECNChange = new Map<String, ECN_Line_Field_to_Change_Product_Map__mdt>();
        // Query all Active configuration records
        for (ECN_Line_Field_to_Change_Product_Map__mdt productFieldMap : [SELECT MasterLabel, Product_Field_API_Name__c, Product_Field_Type__c FROM ECN_Line_Field_to_Change_Product_Map__mdt WHERE Is_Active__c = TRUE]) {
            // add new key/value to map            
            productApiFieldByECNChange.put(productFieldMap.MasterLabel, productFieldMap);
        }
        return productApiFieldByECNChange;
    }

    /**
     * @param arrayLines 
     * @return  `Map<String, String>` Map that returns Sales Group Id based on its KEY field value
     */
    private static Map<String, String> getSalesGroupIdByKey(List<List<ECN_Line__c>> arrayLines) {
        Map<String, String> salesGroupIdByKey = new Map<String, String>();
        // store all keys found on each ECN Line record
        Set<String> keys = new Set<String>();
        for (List<ECN_Line__c> lines : arrayLines) {
            for (ECN_Line__c ecnl : lines) {
                // Add key to list only if Field_to_Change__c field value equals 'Sales Group'
                if (ecnl.Field_to_Change__c == 'Sales Group') {
                    keys.add(ecnl.New_Value__c);
                }
            }
        }
        // query all Sales_Group__c record whose Key are present in the given list
        for (Sales_Group__c salesGroup : [SELECT Id, Key__c FROM Sales_Group__c WHERE Key__c IN :keys]) {
            salesGroupIdByKey.put(salesGroup.Key__c, salesGroup.Id);
        }
        return salesGroupIdByKey;
    }

    private static Map<String, String> getSupplierIdByKey(List<List<ECN_Line__c>> arrayLines) {
        Map<String, String> supplierIdByKey = new Map<String, String>();
        // store all keys found on each ECN Line record
        Set<String> keys = new Set<String>();
        for (List<ECN_Line__c> lines : arrayLines) {
            for (ECN_Line__c ecnl : lines) {
                // Add key to list only if Field_to_Change__c field value equals 'Supplier'
                if (ecnl.Field_to_Change__c == 'Supplier') {
                    keys.add(ecnl.New_Value__c);
                }
            }
        }
        // query all Supplier__c record whose Key are present in the given list
        for (Supplier__c supplier : [SELECT Id, Key__c FROM Supplier__c WHERE Key__c IN :keys]) {
            supplierIdByKey.put(supplier.Key__c, supplier.Id);
        }
        return supplierIdByKey;
    }

    /**
     * @return  `String` with a SOQL Query including all Available fields for the Product__c object
     */
    private static String getProductQuery() {
        // Get Describe Map for all Product__c fields
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get('Product__c').getDescribe().fields.getMap();
        // Get all Product__c fields
        List<String> fieldAPINames = new List<String>(objectFields.keySet());
        // build query
        String query = 'SELECT ' + String.join(fieldAPINames, ',');
        query += ' FROM Product__c';
        query += ' WHERE Id IN :productIds';
        return query;
    }
}