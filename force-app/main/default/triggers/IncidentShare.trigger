/**
 * @author PolSource
 * @description Trigger file for BMCServiceDesk__Incident__c SOBject
 */
trigger IncidentShare on BMCServiceDesk__Incident__c (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        // For each new record inserted, we create two Incident__Share records
        BMCServiceDeskIncidentTriggerHandler.createIncidentShareRecords(Trigger.new);
    }

}