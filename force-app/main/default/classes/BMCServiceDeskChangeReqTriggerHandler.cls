/**
 * @author PolSource
 */
public with sharing class BMCServiceDeskChangeReqTriggerHandler {

    private BMCServiceDeskChangeReqTriggerHandler() {}

    /**
     * @param records `List<BMCServiceDesk__Change_Request__c>`
     */
    public static void updateStatusAndStates(List<BMCServiceDesk__Change_Request__c> records) {
        // List with all statuses coming from the list of records
        List<String> newStatuses = new List<String>();
        for (BMCServiceDesk__Change_Request__c inc: records) {
            newStatuses.add(Inc.CR_Status__c);
        }
        // Map used to return the Service Desk record based on their status name
        Map<String, BMCServiceDesk__Status__c> serviceDeskStatusByName = new Map<String, BMCServiceDesk__Status__c>();
        // query only those records whose status is present on the list
        for (BMCServiceDesk__Status__c status : [SELECT Id, Name, BMCServiceDesk__state__c FROM BMCServiceDesk__Status__c WHERE Name IN :newStatuses]) {
            serviceDeskStatusByName.put(status.Name, status);
        }
        
        for (BMCServiceDesk__Change_Request__c inc: records){
            String oldStatus;
            String newStatus;
            if (Trigger.isUpdate) { // only old reference with update, not insert!
                BMCServiceDesk__Change_Request__c oldInc = (BMCServiceDesk__Change_Request__c) Trigger.oldMap.get(inc.ID);
                BMCServiceDesk__Change_Request__c newInc = (BMCServiceDesk__Change_Request__c) Trigger.newMap.get(inc.ID);
                //Retrieve the old and new Status__c Field
                oldStatus= oldInc.CR_Status__c;
                newStatus = newInc.CR_Status__c;
            } else {
                // If it is a new record, set old value to EMPTY
                oldStatus= 'empty';
                newStatus = Inc.CR_Status__c;
            }
            // update Status and State fields when the record's status has been updated to a new value
            if (oldStatus <> newStatus && serviceDeskStatusByName.containsKey(newStatus)) {
                // get Service Desk Status record based on its name
                BMCServiceDesk__Status__c status = serviceDeskStatusByName.get(newStatus);
                inc.BMCServiceDesk__FKStatus__c = status.Id;
                inc.BMCServiceDesk__State__c = status.BMCServiceDesk__state__c;
            }
        }        
    }

    /**
     * @param records 
     */
    public static void updateChangeRequestStatus(List<BMCServiceDesk__Change_Request__c> records) {
        // create a list of all status values coming from the list of records
        List<String> newStatuses = new List<String>();
        for (BMCServiceDesk__Change_Request__c inc: records) {
            newStatuses.add(Inc.BMCServiceDesk__FKStatus__c);
        }
        // holds a map that returns the status record based on their names
        Map<String, BMCServiceDesk__Status__c> serviceDeskStatusByName = new Map<String, BMCServiceDesk__Status__c>();
        for (BMCServiceDesk__Status__c status : [SELECT Id, Name, BMCServiceDesk__state__c FROM BMCServiceDesk__Status__c WHERE Name IN :newStatuses]) {
            serviceDeskStatusByName.put(status.Name, status);
        }
    
        for (BMCServiceDesk__Change_Request__c inc: records) {
            string oldStatus;
            string newStatus;
            // only old reference with update, not insert!
            if (Trigger.isUpdate) {
                // get Change request old record
                BMCServiceDesk__Change_Request__c oldInc = (BMCServiceDesk__Change_Request__c) Trigger.oldMap.get(inc.ID);
                // get Change request new record
                BMCServiceDesk__Change_Request__c newInc = (BMCServiceDesk__Change_Request__c) Trigger.newMap.get(inc.ID);
                //Retrieve the old and new BMCServiceDesk__FKStatus__c Field
                oldStatus= oldInc.BMCServiceDesk__FKStatus__c;
                newStatus = newInc.BMCServiceDesk__FKStatus__c;
            } else {
                // If it is a new record, set old value to EMPTY
                oldStatus= 'empty';
                newStatus = Inc.BMCServiceDesk__FKStatus__c;
            }
            // update CR_Status field when the record's status has been updated to a new value
            if (oldStatus <> newStatus && serviceDeskStatusByName.containsKey(newStatus)) {
                BMCServiceDesk__Status__c status = serviceDeskStatusByName.get(newStatus);
                inc.CR_Status__c = status.Name;
            }
        }
    }
}