@isTest(SeeAllData = True)
private class IncidentShareTest {
    // Test for the manualShareRead method
    static testMethod void testManualShareRead()
    {
        Id managerID;
        Id delegateID;
        boolean complete = false;
        
        // Select users for the test.
        List<User> users = [SELECT Id, RF_Manager__c, RF_Delegated_Approver__c FROM User WHERE Id = '005D00000023kN3' LIMIT 1];
        Id User1Id = users[0].Id;
        // Get manager ID from user record
        managerID = users[0].RF_Manager__c;
        delegateID = users[0].RF_Delegated_Approver__c;        
        system.debug('**********USER ID: ' + User1Id); 
        system.debug('**********MANAGER ID: ' + managerID); 
        system.debug('**********DELEGATE ID: ' + delegateID);         
        
        // create new incident
        BMCServiceDesk__Incident__c i = new BMCServiceDesk__Incident__c();
        i.OwnerId = User1Id;
        i.BMCServiceDesk__FKClient__c = User1Id;
        insert i;
        system.debug('**********INCIDENT ID: ' + i.Id); 
        string newId = i.Id;
        i = [SELECT Id, RF_Manager__c, RF_Delegated_Approver__c from BMCServiceDesk__Incident__c where Id=:newId LIMIT 1];
        System.assertEquals(managerID, i.RF_Manager__c);
        System.assertEquals(delegateID, i.RF_Delegated_Approver__c);           
        
        // Create a new list of sharing objects for Job
        List<BMCServiceDesk__Incident__Share> jobShrs  = new List<BMCServiceDesk__Incident__Share>();
        // Insert manual share for user who is not record owner.
        BMCServiceDesk__Incident__Share incShr  = new BMCServiceDesk__Incident__Share();
        BMCServiceDesk__Incident__Share incShrd  = new BMCServiceDesk__Incident__Share();        
        // Set the ID of record being shared.
        incShr.ParentId = i.Id;
        incShrd.ParentId = i.Id;        
        // Set the ID of user or group being granted access.
        incShr.UserOrGroupId = managerId;
        incShrd.UserOrGroupId = delegateID;        
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
        
        // Process the save results.
        for(Database.SaveResult sr : lsr)
        {
            if(sr.isSuccess())
            {
                // Indicates success
                complete = true;
            }
            else 
            {
                // Get first save result error.
                Database.Error err2 = sr.getErrors()[0];
         
                // Check if the error is related to trival access level.
                // Access levels equal or more permissive than the object's default 
                // access level are not allowed. 
                // These sharing records are not required and thus an insert exception is acceptable. 
                if(err2.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  
                    err2.getMessage().contains('AccessLevel'))
                {
                    // Indicates success.
                    complete = true;
                }
                else
                {
                    // Indicates failure.
                    complete = false;
                }
            }
            System.assertEquals(complete, true);
        }
        
        // Query job sharing records.
        List<BMCServiceDesk__Incident__Share> iShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
            RowCause FROM BMCServiceDesk__Incident__Share WHERE ParentId = :i.Id];
  
        // Test for only one manual share on job.
        //System.assertEquals(iShrs.size(), 2, 'Set the object\'s sharing model to Private.');            
  
        // Test attributes of manual share.
        System.assertEquals(iShrs[0].AccessLevel, 'Edit');
        //System.assertEquals(iShrs[0].RowCause, 'Manual');
        //System.assertEquals(iShrs[0].UserOrGroupId, managerID);
        
        // Test invalid job Id.
        delete i;  
        // Insert manual share for deleted job id. 
        BMCServiceDesk__Incident__Share incShr2  = new BMCServiceDesk__Incident__Share();
        // Set the ID of record being shared.
        incShr2.ParentId = i.Id;
        // Set the ID of user or group being granted access.
        incShr2.UserOrGroupId = managerId;
        // Set the access level.
        incShr2.AccessLevel = 'Edit';
        // Set rowCause to 'manual' for manual sharing.
        // This line can be omitted as 'manual' is the default value for sharing objects.
        incShr2.RowCause = Schema.BMCServiceDesk__Incident__Share.RowCause.Manual;
        // Insert the sharing record and capture the save result. 
        // The false parameter allows for partial processing if multiple records passed 
        // into the operation.
        Database.SaveResult sr2 = Database.insert(incShr2,false);
        // Process the save results.
        if(sr2.isSuccess())
        {
            // Indicates success
            complete = true;
        }
        else 
        {
            // Get first save result error.
            Database.Error err2 = sr2.getErrors()[0];
         
            // Check if the error is related to trival access level.
            // Access levels equal or more permissive than the object's default 
            // access level are not allowed. 
            // These sharing records are not required and thus an insert exception is acceptable. 
            if(err2.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  
                err2.getMessage().contains('AccessLevel'))
            {
                // Indicates success.
                complete = true;
            }
            else
            {
                // Indicates failure.
                complete = false;
            }
        }
        System.assertEquals(complete, false);
    }
}