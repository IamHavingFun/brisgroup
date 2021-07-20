public with sharing class BMCServiceDeskChangeReqTriggerHandler {

    public static void updateStatusAndStates(List<BMCServiceDesk__Change_Request__c> records) {
        List<String> newStatuses = new List<String>();
        for (BMCServiceDesk__Change_Request__c inc: records) {
            newStatuses.add(Inc.CR_Status__c);
        }
        Map<String, BMCServiceDesk__Status__c> serviceDeskStatusByName = new Map<String, BMCServiceDesk__Status__c>();
        for (BMCServiceDesk__Status__c status : [SELECT Id, Name, BMCServiceDesk__state__c FROM BMCServiceDesk__Status__c WHERE Name IN :newStatuses]) {
            serviceDeskStatusByName.put(status.Name, status);
        }
        
        for (BMCServiceDesk__Change_Request__c inc: records){
            string oldStatus;
            string newStatus;
            if (Trigger.isUpdate) { // only old reference with update, not insert!
                BMCServiceDesk__Change_Request__c oldInc = (BMCServiceDesk__Change_Request__c) Trigger.oldMap.get(inc.ID);
                BMCServiceDesk__Change_Request__c newInc = (BMCServiceDesk__Change_Request__c) Trigger.newMap.get(inc.ID);
                //Retrieve the old and new Status__c Field
                oldStatus= oldInc.CR_Status__c;
                newStatus = newInc.CR_Status__c;
            } else {
                oldStatus= 'empty';
                newStatus = Inc.CR_Status__c;
            }
            if (oldStatus <> newStatus && serviceDeskStatusByName.containsKey(newStatus)) {
                BMCServiceDesk__Status__c status = serviceDeskStatusByName.get(newStatus);
                inc.BMCServiceDesk__FKStatus__c = status.Id;
                inc.BMCServiceDesk__State__c = status.BMCServiceDesk__state__c;
            }
        }        
    }

    public static void updateChangeRequestStatus(List<BMCServiceDesk__Change_Request__c> records) {
        List<String> newStatuses = new List<String>();
        for (BMCServiceDesk__Change_Request__c inc: records) {
            newStatuses.add(Inc.BMCServiceDesk__FKStatus__c);
        }
        Map<String, BMCServiceDesk__Status__c> serviceDeskStatusByName = new Map<String, BMCServiceDesk__Status__c>();
        for (BMCServiceDesk__Status__c status : [SELECT Id, Name, BMCServiceDesk__state__c FROM BMCServiceDesk__Status__c WHERE Name IN :newStatuses]) {
            serviceDeskStatusByName.put(status.Name, status);
        }
    
        for (BMCServiceDesk__Change_Request__c inc: records){
            string oldStatus;
            string newStatus;
            if (Trigger.isUpdate) { // only old reference with update, not insert!
                BMCServiceDesk__Change_Request__c oldInc = (BMCServiceDesk__Change_Request__c) Trigger.oldMap.get(inc.ID);
                BMCServiceDesk__Change_Request__c newInc = (BMCServiceDesk__Change_Request__c) Trigger.newMap.get(inc.ID);
                //Retrieve the old and new BMCServiceDesk__FKStatus__c Field
                oldStatus= oldInc.BMCServiceDesk__FKStatus__c;
                newStatus = newInc.BMCServiceDesk__FKStatus__c;
            }
            else {
                oldStatus= 'empty';
                newStatus = Inc.BMCServiceDesk__FKStatus__c;
            }
            if (oldStatus <> newStatus && serviceDeskStatusByName.containsKey(newStatus)) {
                BMCServiceDesk__Status__c status = serviceDeskStatusByName.get(newStatus);
                inc.CR_Status__c = status.Name;
            }
        }
    }
}
