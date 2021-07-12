// This trigger rolls up Opportunity 'Notes' field to proj 'Notes Rollup' field

trigger tgrNotesRollup on Opportunity (after insert, before update) { 
    Opportunity proj = null;
    List<Opportunity> opportunities = new List<Opportunity>();
    String notesRollup = '';
    String recordType = '';

    for (Opportunity o : Trigger.new)
    {
        recordType = o.Record_Type_Name__c;
        if(recordType == 'Opportunity' && o.Project__c != null) {
            String projId = o.Project__c;
            proj = [SELECT id, Name, Notes__c, Notes_Rollup__c, Record_Type_Name__c from Opportunity where id = :projId LIMIT 1];
            system.debug('*************************************************************************************************************************');
            system.debug('***************** Project ID: ' + proj.id + '************************************************************************');
            opportunities = [SELECT id, Name, Notes__c from Opportunity where Project__c = :projId];
            Opportunity newOpp = Trigger.newMap.get(o.ID);
            if(proj.Record_Type_Name__c == 'Project')
            {
                for(Opportunity opp : opportunities) {
                    if((o.id == opp.id || o.id == null)) {
                        if(newOpp.Notes__c != '' && newOpp.Notes__c != null) {
                            system.debug('*************************************************************************************************************************');
                            system.debug('***************** Current Opportunity: Adding Notes *********************************************************************');
                            notesRollup += o.Name + ' (https://eu1.salesforce.com/' + o.id + '): ' + newOpp.Notes__c + '\r\n\r\n';     
                        }
                    }
                    else {
                        if(opp.Notes__c != '' && opp.Notes__c != null) {
                            system.debug('*************************************************************************************************************************');
                            system.debug('***************** Other Opportunity: Adding Notes *********************************************************************');
                            notesRollup += opp.Name + ' (https://eu1.salesforce.com/' + opp.id + '): ' + opp.Notes__c + '\r\n\r\n';              
                        }               
                    }
                }
                proj.Notes_Rollup__c = notesRollup;
                update proj;
            }
        }
    }
}