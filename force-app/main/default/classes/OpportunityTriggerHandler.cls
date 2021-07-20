public with sharing class OpportunityTriggerHandler {

    public static void updateNoteOnProjects(List<Opportunity> records) {
        String notesRollup = '';

        List<String> projectIds = new List<String>();
        for (Opportunity o : records) {
            projectIds.add(o.Project__c);
        }
        Map<String, Opportunity> projects = new Map<String, Opportunity>([SELECT id, Name, Notes__c, Notes_Rollup__c, Record_Type_Name__c FROM Opportunity WHERE Id IN :projectIds]);
        Map<String, List<Opportunity>> opportunitiesByProject = new Map<String, List<Opportunity>>();
        for (Opportunity opp : [SELECT Id, Name, Notes__c, Project__c FROM Opportunity WHERE Project__c IN :projectIds]) {
            if (!opportunitiesByProject.containsKey(opp.Project__c)) {
                opportunitiesByProject.put(opp.Project__c, new List<Opportunity>{opp});
            } else {
                List<Opportunity> opps = opportunitiesByProject.get(opp.Project__c);
                opps.add(opp);
                opportunitiesByProject.put(opp.Project__c, opps);
            }
        }
    
        for (Opportunity o : records) {
            String recordType = o.Record_Type_Name__c;
            if (recordType == 'Opportunity' && o.Project__c != null) {
                String projId = o.Project__c;
                Opportunity proj = projects.get(projId);
                system.debug('*************************************************************************************************************************');
                system.debug('***************** Project ID: ' + proj.id + '************************************************************************');
                List<Opportunity> opportunities = opportunitiesByProject.get(projId);
                Opportunity newOpp = (Opportunity) Trigger.newMap.get(o.ID);
                if (proj.Record_Type_Name__c == 'Project') {
                    for (Opportunity opp : opportunities) {
                        if ((o.id == opp.id || o.id == null)) {
                            if (newOpp.Notes__c != '' && newOpp.Notes__c != null) {
                                system.debug('*************************************************************************************************************************');
                                system.debug('***************** Current Opportunity: Adding Notes *********************************************************************');
                                notesRollup += o.Name + ' (https://eu1.salesforce.com/' + o.id + '): ' + newOpp.Notes__c + '\r\n\r\n';     
                            }
                        } else {
                            if (opp.Notes__c != '' && opp.Notes__c != null) {
                                system.debug('*************************************************************************************************************************');
                                system.debug('***************** Other Opportunity: Adding Notes *********************************************************************');
                                notesRollup += opp.Name + ' (https://eu1.salesforce.com/' + opp.id + '): ' + opp.Notes__c + '\r\n\r\n';              
                            }
                        }
                    }
                    proj.Notes_Rollup__c = notesRollup;
                }
            }
        }
    
        if (!projects.values().isEmpty()) {
            update projects.values();
        }
    }
}
