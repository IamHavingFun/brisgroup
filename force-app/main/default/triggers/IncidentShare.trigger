trigger IncidentShare on BMCServiceDesk__Incident__c (after insert) {

    Id owner;
    Id managerID;
    Id delegateID;
    boolean complete = false;

    for(BMCServiceDesk__Incident__c i: trigger.new)
    {
        // Get owner ID from Incident record
        owner = i.BMCServiceDesk__FKClient__c;
        managerID = i.RF_Manager__c;
        delegateID = i.RF_Delegated_Approver__c;

        // Create a new list of sharing objects for Job
        List<BMCServiceDesk__Incident__Share> jobShrs  = new List<BMCServiceDesk__Incident__Share>();

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
        Database.SaveResult[] lsr = Database.insert(jobShrs,false);
     
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
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                                               &&  err.getMessage().contains('AccessLevel'))){
                    // Throw an error when the error is not related to trivial access level.
                    trigger.newMap.get(jobShrs[x].ParentId).
                      addError(
                       'Unable to grant sharing access due to following exception: '
                       + err.getMessage());
                }
            }
            x++;
        } 
    }
}