public with sharing class EngineerWorkOrderTriggerHandler {

    public static void updateEngineerNameOnCases(List<Engineer_Work_Order__c> records) {

        Set<Id> caseId = new Set<Id>();  
        Set<String> caseSet = new Set<String>();
        List<Case> updateThisCase = new List<Case>();
        
        List<String> assignedEngineerIds = new List<String>();
        for (Engineer_Work_Order__c WO : records) {
            caseId.add(WO.Case__c);// Add Case id to set
            assignedEngineerIds.add(WO.Assigned_Engineer__c);
        }
        
        Map<Id, Case> caseMap = new Map<Id, Case>([SELECT Id, CaseNumber, IFS_Eng_Name__c, Service_Agent__c, WO_Status__c FROM Case WHERE Id IN :caseId]);
        Map<String, User> userMap = new Map<String, User>([SELECT Id, Name FROM User WHERE Id IN :assignedEngineerIds]);
      
        for (Engineer_Work_Order__c WO :records) {
          if (caseMap.containsKey(WO.Case__c)) { //  Checking Map of Case if it contains the Case Id
            Case CS1 =  caseMap.get(WO.Case__c);    //  Getting the Case to be updated into a variable
            system.debug('**** CS1.id =' + CS1.Id);
            if (WO.Assigned_engineer__c != null) {
              system.debug('**** WO.Assigned_Engineer__c =' + WO.Assigned_Engineer__c); 
              User US1 = userMap.get(WO.Assigned_engineer__c);
              system.debug('**** US1.Name =' + US1.Name);        
              CS1.IFS_Eng_Name__c = US1.Name; //WO.Assigned_Engineer__r.Name; //Update the field
              CS1.Service_Agent__c = null;
              system.debug('**** IFS_Eng_Name Updated');        
            } else {
              if (WO.Service_Agent__c != null) {
                system.debug('**** WO.Assigned_Engineer__c =' + WO.Service_Agent__c); 
                CS1.Service_Agent__c = WO.Service_Agent__c; //WO.Assigned_Engineer__r.Name; //Update the field
                CS1.IFS_Eng_Name__c = null;
                system.debug('**** IFS_Eng_Name Updated');          
              } else { 
                CS1.IFS_Eng_Name__c = null;
                CS1.Service_Agent__c = null;          
              }  
            }
            CS1.WO_Status__c = WO.Status__c;
            if (!caseSet.contains(WO.Case__c)) { //If the list of Cases is not containing the Case Id
              caseSet.add(WO.Case__c); // Add it to the list of Cases
              updateThisCase.add(CS1); // Add to the list of Cases which needs to be updated
            }
          } 
        } 
        
        if (!updateThisCase.isEmpty()) {
            try {
                update updateThisCase; // Updating Case
                system.debug('**** Case Updated');        
            } catch(Exception e){

            }
        }
    }
}
