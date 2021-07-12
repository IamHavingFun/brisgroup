trigger WorkOrder_Get_Service_Territory on WorkOrder (before insert, before update) {
  try {
    for (WorkOrder wo : Trigger.new)
    {
      Id ServiceTerritory;
      WorkOrder woOld;
      string postcode;
      string delimiter = ' ';
      if(trigger.isUpdate) {
          woOld = System.Trigger.oldMap.get(wo.id);
      }
      if(wo.PostalCode != null) {
          postcode = wo.PostalCode;
      }
      
      if(postcode != null && postcode != '') {
          postcode = postcode.substringBefore(delimiter);
    
          if(woOld.PostalCode != wo.PostalCode && wo.PostalCode != '' && wo.PostalCode != null)
          {
            try {
              ServiceTerritory = [select Service_Territory__c from Postcode_Mapping__c where Outward_Code__c = :postcode LIMIT 1].Service_Territory__c;
            } 
            catch(Exception ex) {
              ServiceTerritory = null;
            }
            wo.ServiceTerritoryId = ServiceTerritory;
          }  
      }
    }
  }
  catch(Exception e) {
    System.debug('************************** Exception in WorkOrder_Get_Service_Territory trigger:'+e);
  }
}