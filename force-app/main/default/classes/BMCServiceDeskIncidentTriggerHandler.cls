/**
 * @author PolSource
 */
public with sharing class BMCServiceDeskIncidentTriggerHandler {

    private BMCServiceDeskIncidentTriggerHandler() {}

    /**
     * @param records 
     */
    public static void updateServiceDeskStatus(List<BMCServiceDesk__Incident__c> records) {
        List<String> newStatuses = new List<String>();
        for (BMCServiceDesk__Incident__c inc: records) {
            newStatuses.add(inc.IN_Status__c);
        }
        Map<String, BMCServiceDesk__Status__c> serviceDeskStatusByName = new Map<String, BMCServiceDesk__Status__c>();
        for (BMCServiceDesk__Status__c status : [SELECT Id, Name, BMCServiceDesk__state__c FROM BMCServiceDesk__Status__c WHERE Name IN :newStatuses]) {
            serviceDeskStatusByName.put(status.Name, status);
        }
        
        for (BMCServiceDesk__Incident__c inc: records){
            string oldStatus;
            string newStatus;
            if (Trigger.isUpdate) { // only old reference with update, not insert!
                BMCServiceDesk__Incident__c oldInc = (BMCServiceDesk__Incident__c) Trigger.oldMap.get(inc.ID);
                BMCServiceDesk__Incident__c newInc = (BMCServiceDesk__Incident__c) Trigger.newMap.get(inc.ID);
                //Retrieve the old and new Status__c Field
                oldStatus= oldInc.IN_Status__c;
                newStatus = newInc.IN_Status__c;
            }
            else {
                oldStatus= 'empty';
                newStatus = Inc.IN_Status__c;
            }
            if (oldStatus <> newStatus && serviceDeskStatusByName.containsKey(newStatus)) {
                BMCServiceDesk__Status__c status = serviceDeskStatusByName.get(newStatus);
                inc.BMCServiceDesk__FKStatus__c = status.Id;
                inc.BMCServiceDesk__state__c = status.BMCServiceDesk__state__c;
            }
        }        
    }

    /**
     * @param records 
     */
    public static void updateIncidentStatus(List<BMCServiceDesk__Incident__c> records) {
        List<String> newStatuses = new List<String>();
        for (BMCServiceDesk__Incident__c inc: records) {
            newStatuses.add(Inc.BMCServiceDesk__FKStatus__c);
        }
        Map<String, BMCServiceDesk__Status__c> serviceDeskStatusByName = new Map<String, BMCServiceDesk__Status__c>();
        for (BMCServiceDesk__Status__c status : [SELECT Id, Name, BMCServiceDesk__state__c FROM BMCServiceDesk__Status__c WHERE Name IN :newStatuses]) {
            serviceDeskStatusByName.put(status.Name, status);
        }
            
        for (BMCServiceDesk__Incident__c inc: records){
            string oldStatus;
            string newStatus;
            if (Trigger.isUpdate) { // only old reference with update, not insert!
                BMCServiceDesk__Incident__c oldInc = (BMCServiceDesk__Incident__c) Trigger.oldMap.get(inc.ID);
                BMCServiceDesk__Incident__c newInc = (BMCServiceDesk__Incident__c) Trigger.newMap.get(inc.ID);
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
                inc.IN_Status__c = status.Name;
            }
        }
    }

    /**
     * @param records 
     */
    public static void createIncidentShareRecords(List<BMCServiceDesk__Incident__c> records) {
        Id managerID;
        Id delegateID;
    
        // Create a new list of sharing objects for Job
        List<BMCServiceDesk__Incident__Share> jobShrs  = new List<BMCServiceDesk__Incident__Share>();
    
        for(BMCServiceDesk__Incident__c i: records)
        {
            managerID = i.RF_Manager__c;
            delegateID = i.RF_Delegated_Approver__c;
    
            // Create new sharing object for the custom object Job.
            BMCServiceDesk__Incident__Share incShr  = new BMCServiceDesk__Incident__Share();
            BMCServiceDesk__Incident__Share incShrd  = new BMCServiceDesk__Incident__Share();        
            // Set the ID of record being shared.
            incShr.ParentId = i.Id;
            incShrd.ParentId = i.Id;        
            // Set the ID of user or group being granted access.
            incShr.UserOrGroupId = managerId;
            incShrd.UserOrGroupId = delegateId;        
            // Set the access level.
            incShr.AccessLevel = 'Edit';
            incShrd.AccessLevel = 'Edit';        
            // Set rowCause to 'manual' for manual sharing.
            // This line can be omitted as 'manual' is the default value for sharing objects.
            incShr.RowCause = Schema.BMCServiceDesk__Incident__Share.RowCause.Manual;
            incShrd.RowCause = Schema.BMCServiceDesk__Incident__Share.RowCause.Manual;        
            // Insert the sharing record and capture the save result. 
            // The false parameter allows for partial processing if multiple records passed 
            // into the operation.
            jobShrs.add(incShr);
            jobShrs.add(incShrd);        
        }
        if (!jobShrs.isEmpty()) {
            // The optional allOrNone parameter specifies whether the operation allows partial success. 
            // we are setting its value to false so if a record fails, the remainder of the DML operation can still succeed.
            Database.SaveResult[] lsr = Database.insert(jobShrs, false);
         
            // Create counter
            Integer x=0;
                 
            // Process the save results
            for(Database.SaveResult sr : lsr){
                if(!sr.isSuccess()){
                    // Get the first save result error
                    Database.Error err = sr.getErrors()[0];
                    
                    // Check if the error is related to a trivial access level
                    // Access levels equal or more permissive than the object's default 
                    // access level are not allowed. 
                    // These sharing records are not required and thus an insert exception is 
                    // acceptable. 
                    if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  err.getMessage().contains('AccessLevel'))){
                        // Throw an error when the error is not related to trivial access level.
                        Trigger.newMap.get(jobShrs[x].ParentId).addError('Unable to grant sharing access due to following exception: ' + err.getMessage());
                    }
                }
                x++;
            }        
        }
    }

    /**
     * @param records 
     */
    public static void updateDelegateOnIncidents(List<BMCServiceDesk__Incident__c> records) {
        List<Id> ownerIds = new List<Id>();
        for (BMCServiceDesk__Incident__c i: records) {
            ownerIds.add(i.BMCServiceDesk__FKClient__c);
        }
    
        // Get user record    
        Map<Id, User> usrMap = new Map<Id, User>([SELECT Id, RF_Manager__c, RF_Delegated_Approver__c FROM user WHERE Id IN :ownerIds]);
    
        for(BMCServiceDesk__Incident__c i: records) {
            // Get owner ID from Incident record
            Id owner = i.BMCServiceDesk__FKClient__c;
            
            // Update RF Manager field on Incident if not blank
            if(usrMap.get(owner).RF_Manager__c!=Null)
            {
                i.RF_Manager__c = usrMap.get(owner).RF_Manager__c;
            }
            // Update RF Delegate field on Incident if not blank
            if(usrMap.get(owner).RF_Delegated_Approver__c!=Null)
            {
                i.RF_Delegated_Approver__c = usrMap.get(owner).RF_Delegated_Approver__c;
            }    
        }
    }
}
