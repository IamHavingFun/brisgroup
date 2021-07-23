/**
 * @description trigger file for BMCServiceDesk__Incident__c SObject
 */
trigger IV_Sync_Status_List on BMCServiceDesk__Incident__c (before insert, before update) {
    // Copyright InfraVision Ltd - Smon Martin - December 2014
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        // update values on FKStatus and state fields
        BMCServiceDeskIncidentTriggerHandler.updateServiceDeskStatus(Trigger.new);
    }
}