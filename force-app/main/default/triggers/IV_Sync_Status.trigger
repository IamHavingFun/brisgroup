trigger IV_Sync_Status on BMCServiceDesk__Incident__c (before insert, before update) {
    // Copyright InfraVision Ltd - Smon Martin - December 2014
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        BMCServiceDeskIncidentTriggerHandler.updateServiceDeskStatus(Trigger.new);
    }
}