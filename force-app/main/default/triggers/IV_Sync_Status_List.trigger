trigger IV_Sync_Status_List on BMCServiceDesk__Incident__c (before insert, before update) {
    // Copyright InfraVision Ltd - Smon Martin - December 2014
    for (BMCServiceDesk__Incident__c inc: trigger.new){
        string oldStatus;
        string newStatus;
        if (Trigger.isUpdate) { // only old reference with update, not insert!
            BMCServiceDesk__Incident__c oldInc = Trigger.oldMap.get(inc.ID);
            BMCServiceDesk__Incident__c newInc = Trigger.newMap.get(inc.ID);
            //Retrieve the old and new BMCServiceDesk__FKStatus__c Field
            oldStatus= oldInc.BMCServiceDesk__FKStatus__c;
            newStatus = newInc.BMCServiceDesk__FKStatus__c;
        }
        else {
            oldStatus= 'empty';
            newStatus = Inc.BMCServiceDesk__FKStatus__c;
        }
        if (oldStatus <> newStatus) {
            List<BMCServiceDesk__Status__c> status = new List<BMCServiceDesk__Status__c>();
            status = [select id,Name, BMCServiceDesk__state__c from BMCServiceDesk__Status__c where id = :newStatus];
            if(status.isEmpty()== False){
                inc.IN_Status__c = status[0].Name;
            }
        }
    }
}