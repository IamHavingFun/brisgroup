trigger IncidentShare on BMCServiceDesk__Incident__c (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        BMCServiceDeskIncidentTriggerHandler.createIncidentShareRecords(Trigger.new);
    }

}