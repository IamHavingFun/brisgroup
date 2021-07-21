/**
 * @author PolSource
 */
public with sharing class WorkOrderTriggerHandler {

    private WorkOrderTriggerHandler() {}

    /**
     * @param records 
     */
    public static void updateServiceTerritory(List<WorkOrder> records) {
        try {
            // character used to get Postal Code from Work Order
            String delimiter = ' ';
            // All postal codes from record list
            List<String> postalCodes = new List<String>();
            for (WorkOrder wo : records) {
              // checks if Work Order has a valid Postal Code
              if (String.isNotBlank(wo.PostalCode)) {
                // add postal code to List
                postalCodes.add(wo.PostalCode.substringBefore(delimiter));
              }
            }
            // Map returns a Postcode_Mapping object given its Outward_Code value
            Map<String, Postcode_Mapping__c> postCodesByOutwardCode = new Map<String, Postcode_Mapping__c>();
            // Get all Postcode Mapping records that match any of the Postal Codes from the list
            for (Postcode_Mapping__c postcodeMap : [SELECT Service_Territory__c, Outward_Code__c FROM Postcode_Mapping__c WHERE Outward_Code__c IN :postalCodes]) {
              postCodesByOutwardCode.put(postcodeMap.Outward_Code__c, postcodeMap);
            }
            // Iterate over all Work Order records
            for (WorkOrder wo : records) {
              Id serviceTerritoryId = null;
              WorkOrder woOld;
              String postcode;
              // if Update operation is in progress, get old version of Work Order record
              if (Trigger.isUpdate) {
                  woOld = (WorkOrder) System.Trigger.oldMap.get(wo.id);
              }
              if (String.isNotBlank(wo.PostalCode)) {
                  postcode = wo.PostalCode;
              }
              
              if (String.isNotBlank(postcode)) {
                  postcode = postcode.substringBefore(delimiter);
            
                  if (woOld.PostalCode != wo.PostalCode && String.isNotBlank(wo.PostalCode) && postCodesByOutwardCode.containsKey(postcode)) {
                    // get service territory Id from Post Mapping record that matches the Work Order's postal code
                    serviceTerritoryId = postCodesByOutwardCode.get(postcode).Service_Territory__c;
                  }
                  // set Service territory Id on Work Order
                  wo.ServiceTerritoryId = serviceTerritoryId;
              }
            }
          } catch(Exception e) {
            System.debug('************************** Exception in WorkOrder_Get_Service_Territory trigger:'+e);
          }        
    }
}