/**
 * @author PolSource
 */
public with sharing class OpportunityTriggerHandler {

    private OpportunityTriggerHandler() {}

    /**
     * @param records 
     */
    public static void updateNoteOnProjects(List<Opportunity> records) {
        // String containing all notes from child records
        String notesRollup = '';

        // All Project Ids
        List<String> projectIds = getAllProjectIds(records);
        // returns an Opportunity record given an ID
        Map<String, Opportunity> projects = new Map<String, Opportunity>([SELECT id, Name, Notes__c, Notes_Rollup__c, Record_Type_Name__c FROM Opportunity WHERE Id IN :projectIds]);
        // returns an List of Opportunity records given an ID
        Map<String, List<Opportunity>> opportunitiesByProject = getOpportunitiesByProjectId(projectIds);
    
        for (Opportunity o : records) {
            String recordType = o.Record_Type_Name__c;
            if (recordType == 'Opportunity' && o.Project__c != null) {
                String projId = o.Project__c;
                Opportunity proj = projects.get(projId);
                system.debug('*************************************************************************************************************************');
                system.debug('***************** Project ID: ' + proj.id + '************************************************************************');
                List<Opportunity> opportunities = opportunitiesByProject.get(projId);
                Opportunity newOpp = (Opportunity) Trigger.newMap.get(o.ID);
                // if Project's Record Type Name is not project, skip to next opportunity record
                if (proj.Record_Type_Name__c != 'Project') {
                    continue;
                }

                // Loop through all Project's opportuniry records
                for (Opportunity opp : opportunities) {
                    if ((o.id == opp.id || o.id == null) && String.isNotBlank(newOpp.Notes__c)) {
                        system.debug('*************************************************************************************************************************');
                        system.debug('***************** Current Opportunity: Adding Notes *********************************************************************');
                        notesRollup += o.Name + ' (https://eu1.salesforce.com/' + o.id + '): ' + newOpp.Notes__c + '\r\n\r\n';
                    } else if (String.isNotBlank(opp.Notes__c)) {
                        system.debug('*************************************************************************************************************************');
                        system.debug('***************** Other Opportunity: Adding Notes *********************************************************************');
                        notesRollup += opp.Name + ' (https://eu1.salesforce.com/' + opp.id + '): ' + opp.Notes__c + '\r\n\r\n';
                    }
                }
                proj.Notes_Rollup__c = notesRollup;
            }
        }
    
        // checks whether the list is nempty or not.
        if (!projects.values().isEmpty()) {
            // update all opportunities
            update projects.values();
        }
    }

    /**
     * @param records `List<Opportunity>`
     * @return  `List<String>` of all project Ids from the given Opportunity list
     */
    private static List<String> getAllProjectIds(List<Opportunity> records) {
        List<String> projectIds = new List<String>();
        // iterates all Opportunity records and get their Project Id, Add it to the list, and finally returns the list
        for (Opportunity o : records) {
            projectIds.add(o.Project__c);
        }
        return projectIds;
    }

    /**
     * @param projectIds
     * @return  `Map<String, List<Opportunity>>` creates a list of Oppotunity records for each Project Id
     */
    private static Map<String, List<Opportunity>> getOpportunitiesByProjectId(List<String> projectIds) {
        Map<String, List<Opportunity>> opportunitiesByProject = new Map<String, List<Opportunity>>();
        for (Opportunity opp : [SELECT Id, Name, Notes__c, Project__c FROM Opportunity WHERE Project__c IN :projectIds]) {
            if (opportunitiesByProject.containsKey(opp.Project__c)) {
                // If project Id has a list linked to it, get it, add a new element and update the map's entry
                List<Opportunity> opps = opportunitiesByProject.get(opp.Project__c);
                opps.add(opp);
                opportunitiesByProject.put(opp.Project__c, opps);                
            } else {
                // adds a new map entry with a new list containing current iteration Opportunity record.
                opportunitiesByProject.put(opp.Project__c, new List<Opportunity>{opp});
            }
        }
        return opportunitiesByProject;
    }


    /**
     * @param records 
     */
    public static void tgrPopulateAssignedToField_Opportunity(List<Opportunity> records){

        Map<Id, String> ownerMap = new Map<Id, String>();
        Map<Id, String> managerMap = new Map<Id, String>();
    
//  Get owner name from user using OwnerID  

        for (Opportunity o : records)
        {
            ownerMap.put(o.OwnerId, null);
        }

        if (ownerMap.size() > 0)
        {
            for (User[] users : [SELECT Id, Name FROM User WHERE Id IN :ownerMap.keySet()])
        {
            for (Integer i=0; i<users.size(); i++)
            {
                ownerMap.put(users[i].Id, users[i].Name);
            }
        }
            for (Opportunity o : records)
            {
                o.Assigned_To__c  = ownerMap.get(o.OwnerId);
            }
        }  

//  Get ManagerName__c from user using OwnerID

        for (Opportunity o : records)
        {
            managerMap.put(o.OwnerId, null);
        }

        if (managerMap.size() > 0)
        {
            for (User[] users : [SELECT Id, ManagerName__c FROM User WHERE Id IN :managerMap.keySet()])
            {
                for (Integer i=0; i<users.size(); i++)
                {
                    managerMap.put(users[i].Id, users[i].ManagerName__c);
                }
            }
            for (Opportunity o : records)
            {
                o.ManagerName__c  = managerMap.get(o.OwnerId);
            }
        }  


    }


    /**
     * @param records 
     */
    public static void updateDivisionfieldonOpp(List<Opportunity> records){

        Try
        {     
            //Declaration 
            Map<id,user> UsrMap=new Map<id,user>([
                SELECT id,Name,Division__c,Approver_1__c,Approver_2__c,Approver_3__c
                FROM user
            ]); //Creating map of user ids and user record
        
               
            for(Opportunity Opp : records) {  
             //If Lead owner's division is not specified than lead record's division will also blank.  
                if( Opp.Division__c==Null){
                    if(UsrMap.get(Opp.ownerid).Division__c==Null) { 
                        Opp.Division__c='';
                    }//End of if statement    
                
                    else { //If Lead owner's division is specified than lead record's division will be updated by lead owner's 'Division'.  
                        Opp.Division__c=UsrMap.get(Opp.ownerid).Division__c;
                    }//End of else statement
                }
             
                //Updating the Approvers field on opportunity wrt Users field
                if(UsrMap.get(Opp.ownerid).Approver_1__c!=Null){
                    Opp.Approver_1__c=UsrMap.get(Opp.ownerid).Approver_1__c;
                }
              
                //Updating the Approvers field on opportunity wrt Users field
                if(UsrMap.get(Opp.ownerid).Approver_2__c!=Null){
                    Opp.Approver_2__c=UsrMap.get(Opp.ownerid).Approver_2__c;
                }
                
                //Updating the Approvers field on opportunity wrt Users field
                if(UsrMap.get(Opp.ownerid).Approver_3__c!=Null){
                    Opp.Approver_3__c=UsrMap.get(Opp.ownerid).Approver_3__c;
                }
            }  //End of for loop            
        
        }Catch(Exception e){
         system.debug('************************************Exception in Trigger on opp:'+e);
        }
        
    }  

}