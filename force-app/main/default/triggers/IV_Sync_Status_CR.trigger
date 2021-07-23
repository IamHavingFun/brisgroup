/**
 * @description trigger file for BMCServiceDesk__Change_Request__c SObject
 */
trigger IV_Sync_Status_CR on BMCServiceDesk__Change_Request__c (before insert, before update) {
    // Copyright InfraVision Ltd - Smon Martin - December 2014
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        // update value on FKStatus and State fields
        BMCServiceDeskChangeReqTriggerHandler.updateStatusAndStates(Trigger.new);
    }
}