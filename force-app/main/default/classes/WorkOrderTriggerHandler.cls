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
            string delimiter = ' ';
            List<String> postalCodes = new List<String>();
            for (WorkOrder wo : records) {
              if (String.isNotBlank(wo.PostalCode)) {
                postalCodes.add(wo.PostalCode.substringBefore(delimiter));
              }
            }
            Map<String, Postcode_Mapping__c> postCodesByOutwardCode = new Map<String, Postcode_Mapping__c>();
            for (Postcode_Mapping__c postcodeMap : [SELECT Service_Territory__c, Outward_Code__c FROM Postcode_Mapping__c WHERE Outward_Code__c IN :postalCodes]) {
              postCodesByOutwardCode.put(postcodeMap.Outward_Code__c, postcodeMap);
            }
            for (WorkOrder wo : records) {
              Id serviceTerritoryId = null;
              WorkOrder woOld;
              string postcode;
              if (Trigger.isUpdate) {
                  woOld = (WorkOrder) System.Trigger.oldMap.get(wo.id);
              }
              if (wo.PostalCode != null) {
                  postcode = wo.PostalCode;
              }
              
              if (postcode != null && postcode != '') {
                  postcode = postcode.substringBefore(delimiter);
            
                  if (woOld.PostalCode != wo.PostalCode && String.isNotBlank(wo.PostalCode) && postCodesByOutwardCode.containsKey(postcode)) {
                    serviceTerritoryId = postCodesByOutwardCode.get(postcode).Service_Territory__c;
                  }
                  wo.ServiceTerritoryId = serviceTerritoryId;
              }
            }
          } catch(Exception e) {
            System.debug('************************** Exception in WorkOrder_Get_Service_Territory trigger:'+e);
          }        
    }
}