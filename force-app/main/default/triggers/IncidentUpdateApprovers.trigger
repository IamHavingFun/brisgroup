trigger IncidentUpdateApprovers on BMCServiceDesk__Incident__c (before insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        BMCServiceDeskIncidentTriggerHandler.updateDelegateOnIncidents(Trigger.new);
    }
}