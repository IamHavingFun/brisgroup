/**
 * @author PolSource
 */
public with sharing class EngineerWorkOrderTriggerHandler {

    private EngineerWorkOrderTriggerHandler() {}

    /**
     * @param records `List<Engineer_Work_Order__c>`
     */
    public static void updateEngineerNameOnCases(List<Engineer_Work_Order__c> records) {

        // Hold all case ids
        Set<Id> caseId = new Set<Id>(); 
        // set used to determine if a case has been proccessed or not
        Set<String> caseSet = new Set<String>();
        // 
        List<Case> updateThisCase = new List<Case>();        
        List<String> assignedEngineerIds = new List<String>();

        for (Engineer_Work_Order__c WO : records) {
            // Add Case id to set
            caseId.add(WO.Case__c);
            // Add Engineer Id to List
            assignedEngineerIds.add(WO.Assigned_Engineer__c);
        }
        // Get all case records related to the Engineer Work Orders
        Map<Id, Case> caseMap = new Map<Id, Case>([SELECT Id, CaseNumber, IFS_Eng_Name__c, Service_Agent__c, WO_Status__c FROM Case WHERE Id IN :caseId]);
        // A map that returns an user object based on its ID (Engineer Id)
        Map<String, User> userMap = new Map<String, User>([SELECT Id, Name FROM User WHERE Id IN :assignedEngineerIds]);
      
        for (Engineer_Work_Order__c WO :records) {
          //  Checking Map of Case if it contains the Case Id
          if (caseMap.containsKey(WO.Case__c)) { 
            // Getting the Case to be updated into a variable
            Case CS1 =  caseMap.get(WO.Case__c);
            system.debug('**** CS1.id =' + CS1.Id);
            if (String.isNotBlank(WO.Assigned_engineer__c)) {
              system.debug('**** WO.Assigned_Engineer__c =' + WO.Assigned_Engineer__c); 
              User US1 = userMap.get(WO.Assigned_engineer__c);
              system.debug('**** US1.Name =' + US1.Name);
              CS1.IFS_Eng_Name__c = US1.Name; //WO.Assigned_Engineer__r.Name; //Update the field
              CS1.Service_Agent__c = null;
              system.debug('**** IFS_Eng_Name Updated');        
            } else if (String.isNotBlank(WO.Service_Agent__c)) {
              system.debug('**** WO.Assigned_Engineer__c =' + WO.Service_Agent__c); 
              CS1.Service_Agent__c = WO.Service_Agent__c; //WO.Assigned_Engineer__r.Name; //Update the field
              CS1.IFS_Eng_Name__c = null;
              system.debug('**** IFS_Eng_Name Updated');
            } else { 
              CS1.IFS_Eng_Name__c = null;
              CS1.Service_Agent__c = null;
            }  
            CS1.WO_Status__c = WO.Status__c;
            //If the list of Cases is not containing the Case Id
            if (!caseSet.contains(WO.Case__c)) {
              // Add it to the list of Cases
              caseSet.add(WO.Case__c);
              // Add to the list of Cases which needs to be updated
              updateThisCase.add(CS1); 
            }
          } 
        } 
        
        // checks whether the updateThisCase is not empty
        if (!updateThisCase.isEmpty()) {
            try {
              // Updating Case
                update updateThisCase; 
                system.debug('**** Case Updated');        
            } catch(Exception e) {
              System.debug('Error on WO Engineer: ' + e.getStackTraceString());
            }
        }
    }
}