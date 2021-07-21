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
        List<String> ecnIds = new List<String>();
        for (ECN__c ecn : records) {
            if(ecn.Status__c=='New' || ecn.Status__c=='Rejected' || ecn.Status__c=='Awaiting Finance Approval') {
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
        List<String> newEcnIds = getNewECNIds(records);
        List<String> allecnIds = getAllECNIds(records);
        
        updateOldValueOnLines(newEcnIds);

        // 
        Map<String, ECN_Line_Field_to_Change_Product_Map__mdt> productApiFieldByECNChange = getProductFieldMappings();
        // List of Lines by ECN record Id
        Map<String, List<ECN_Line__c>> linesByECN = getECNLinesByECNId(allecnIds);
        Map<String, String> salesGroupIdByKey = getSalesGroupIdByKey(linesByECN.values());
        Map<String, String> supplierIdByKey = getSupplierIdByKey(linesByECN.values());

        // products to be updated
        List<Product__c> products = new List<Product__c>();
        // build query for Product__c object
        String query = getProductQuery();
        Map<String, Product__c> productsById = new Map<String, Product__c>((List<Product__c>) Database.query(query));
        for (ECN__c ecn : records) {
            String ecnId = ecn.Id;
            Product__c proddata = productsById.get(ecn.Product__c);
            ID PASOwner = proddata.OwnerID;
            ecn.PAS_Owner__c = PASOwner;  

            if(ecn.Status__c == 'Completed') {
                system.debug('*****Trigger UpdateProductFields ECN ID: ' + ecnId);
                String prodId = ecn.Product__c;
                system.debug('*****Trigger UpdateProductFields Product ID: ' + prodId);         

                Product__c prod = productsById.get(prodId);
                    
                list<ECN_Line__c> el = linesByECN.get(ecnId);
                system.debug('ECN Lines: ' + el.size());
                
                if (ecn.Type__c == 'Discontinuation') {
                    prod.Discontinuation_Effective_Date__c = ecn.Effective_Date__c;
                }

                for (ECN_Line__c ecnl : el) {
                    if (ecnl.Field_to_Change__c == 'Sales Group') {
                        prod.Sales_Group__c = salesGroupIdByKey.get(ecnl.New_Value__c);
                    } else if (ecnl.Field_to_Change__c == 'Supplier') {
                        prod.Supplier__c = supplierIdByKey.get(ecnl.New_Value__c);
                    } else if (productApiFieldByECNChange.containsKey(ecnl.Field_to_Change__c)) {
                        ECN_Line_Field_to_Change_Product_Map__mdt productMap = productApiFieldByECNChange.get(ecnl.Field_to_Change__c);
                        Object newValue = null;
                        if (productMap.Product_Field_Type__c == 'Decimal'  && !String.isBlank(ecnl.New_Value__c)) {
                            newValue = Decimal.valueOf(ecnl.New_Value__c);
                        } else if (productMap.Product_Field_Type__c == 'Boolean') {
                            newValue = Boolean.valueOf(ecnl.New_Value__c);
                        } else {
                            newValue = ecnl.New_Value__c;
                        }
                        prod.put(productMap.Product_Field_API_Name__c, newValue);
                    }
                }
                prod.Status__c = 'Complete';
                products.add(prod);
            }
        }
        if (!products.isEmpty()) {
            update products;
        }
    }

    private static List<String> getAllProductIds(List<ECN__c> records) {
        List<String> productIds = new List<String>();
        for (ECN__c ecn : records) {
            productIds.add(ecn.Product__c);
        }
        return productIds;
    }

    private static List<String> getNewECNIds(List<ECN__c> records) {
        List<String> newEcnIds = new List<String>();
        for (ECN__c ecn : records) {
            if (ecn.Status__c == 'New' || ecn.Status__c == 'Rejected' || ecn.Status__c == 'Awaiting Finance Approval') {
                newEcnIds.add(ecn.Id);
            }
        }
        return newEcnIds;
    }

    private static List<String> getAllECNIds(List<ECN__c> records) {
        List<String> allecnIds = new List<String>();
        for (ECN__c ecn : records) {
            allecnIds.add(ecn.Id);
        }
        return allecnIds;
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

    private static Map<String, List<ECN_Line__c>> getECNLinesByECNId(List<String> allecnIds) {
        Map<String, List<ECN_Line__c>> linesByECN = new Map<String, List<ECN_Line__c>>();
        for (ECN_Line__c line : [SELECT Id, Field_to_Change__c, New_Value__c, ECN__c FROM ECN_Line__c WHERE ECN__c IN :allecnIds]) {
            if (linesByECN.containsKey(line.ECN__c)) {
                List<ECN_Line__c> lineList = linesByECN.get(line.ECN__c);
                lineList.add(line);
                linesByECN.put(line.ECN__c, lineList);                
            } else {
                linesByECN.put(line.ECN__c, new List<ECN_Line__c>{ line });
            }
        }
        return linesByECN;
    }

    private static Map<String, ECN_Line_Field_to_Change_Product_Map__mdt> getProductFieldMappings() {
        Map<String, ECN_Line_Field_to_Change_Product_Map__mdt> productApiFieldByECNChange = new Map<String, ECN_Line_Field_to_Change_Product_Map__mdt>();
        for (ECN_Line_Field_to_Change_Product_Map__mdt productFieldMap : [SELECT MasterLabel, Product_Field_API_Name__c, Product_Field_Type__c FROM ECN_Line_Field_to_Change_Product_Map__mdt WHERE Is_Active__c = TRUE]) {
            productApiFieldByECNChange.put(productFieldMap.MasterLabel, productFieldMap);
        }
        return productApiFieldByECNChange;
    }

    private static Map<String, String> getSalesGroupIdByKey(List<List<ECN_Line__c>> arrayLines) {
        Map<String, String> salesGroupIdByKey = new Map<String, String>();
        Set<String> keys = new Set<String>();
        for (List<ECN_Line__c> lines : arrayLines) {
            for (ECN_Line__c ecnl : lines) {
                if (ecnl.Field_to_Change__c == 'Sales Group') {
                    keys.add(ecnl.New_Value__c);
                }
            }
        }
        for (Sales_Group__c salesGroup : [SELECT Id, Key__c FROM Sales_Group__c WHERE Key__c IN :keys]) {
            salesGroupIdByKey.put(salesGroup.Key__c, salesGroup.Id);
        }
        return salesGroupIdByKey;
    }

    private static Map<String, String> getSupplierIdByKey(List<List<ECN_Line__c>> arrayLines) {
        Map<String, String> supplierIdByKey = new Map<String, String>();
        Set<String> keys = new Set<String>();
        for (List<ECN_Line__c> lines : arrayLines) {
            for (ECN_Line__c ecnl : lines) {
                if (ecnl.Field_to_Change__c == 'Supplier') {
                    keys.add(ecnl.New_Value__c);
                }
            }
        }
        for (Supplier__c supplier : [SELECT Id, Key__c FROM Supplier__c WHERE Key__c IN :keys]) {
            supplierIdByKey.put(supplier.Key__c, supplier.Id);
        }
        return supplierIdByKey;
    }

    private static String getProductQuery() {
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get('Product__c').getDescribe().fields.getMap();
        List<String> fieldAPINames = new List<String>(objectFields.keySet());
        String query = 'SELECT ' + String.join(fieldAPINames, ',');
        query += ' FROM Product__c';
        query += ' WHERE Id IN :productIds';
        return query;
    }
}