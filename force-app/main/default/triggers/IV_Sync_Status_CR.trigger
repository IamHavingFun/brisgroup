trigger IV_Sync_Status_CR on BMCServiceDesk__Change_Request__c (before insert, before update) {
    // Copyright InfraVision Ltd - Smon Martin - December 2014
    for (BMCServiceDesk__Change_Request__c inc: trigger.new){
        string oldStatus;
        string newStatus;
        if (Trigger.isUpdate) { // only old reference with update, not insert!
            BMCServiceDesk__Change_Request__c oldInc = Trigger.oldMap.get(inc.ID);
            BMCServiceDesk__Change_Request__c newInc = Trigger.newMap.get(inc.ID);
            //Retrieve the old and new Status__c Field
            oldStatus= oldInc.CR_Status__c;
            newStatus = newInc.CR_Status__c;
        }
        else {
            oldStatus= 'empty';
            newStatus = Inc.CR_Status__c;
        }
        if (oldStatus <> newStatus) {
            List<BMCServiceDesk__Status__c> status = new List<BMCServiceDesk__Status__c>();
            status = [select id,Name, BMCServiceDesk__state__c from BMCServiceDesk__Status__c where name = :newStatus];
            if(status.isEmpty()== False){
                inc.BMCServiceDesk__FKStatus__c = status[0].Id;
                inc.BMCServiceDesk__State__c = status[0].BMCServiceDesk__state__c;
            }
        }
    }
}