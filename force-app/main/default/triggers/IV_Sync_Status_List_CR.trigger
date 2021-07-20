trigger IV_Sync_Status_List_CR on BMCServiceDesk__Change_Request__c (before insert, before update) {
    // Copyright InfraVision Ltd - Smon Martin - December 2014
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        BMCServiceDeskChangeReqTriggerHandler.updateChangeRequestStatus(Trigger.new);
    }
}