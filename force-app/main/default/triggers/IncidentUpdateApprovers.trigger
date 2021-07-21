/**
 * @author PolSource
 * @description Trigger file for BMCServiceDesk__Incident__c SOBject
 */
trigger IncidentUpdateApprovers on BMCServiceDesk__Incident__c (before insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        // update IN_Status__c field value before records are persisted to the database
        BMCServiceDeskIncidentTriggerHandler.updateDelegateOnIncidents(Trigger.new);
    }
}