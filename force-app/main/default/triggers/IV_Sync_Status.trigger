/**
 * @author PolSource
 */
trigger IV_Sync_Status on BMCServiceDesk__Incident__c (before insert, before update) {
    // Copyright InfraVision Ltd - Smon Martin - December 2014
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        // update IN_Status__c for all Incident records
        BMCServiceDeskIncidentTriggerHandler.updateServiceDeskStatus(Trigger.new);
    }
}