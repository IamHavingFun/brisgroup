trigger IncidentUpdateApprovers on BMCServiceDesk__Incident__c (before insert) {

    Id owner;

    for(BMCServiceDesk__Incident__c i: trigger.new)
    {
        // Get owner ID from Incident record
        owner = i.BMCServiceDesk__FKClient__c;
        // Get user record    
        Map<id,user> UsrMap = new Map<id,user>([SELECT id,RF_Manager__c, RF_Delegated_Approver__c FROM user WHERE Id=:owner LIMIT 1]);
        // Update RF Manager field on Incident if not blank
        if(UsrMap.get(owner).RF_Manager__c!=Null)
        {
            i.RF_Manager__c=UsrMap.get(owner).RF_Manager__c;
        }
        // Update RF Delegate field on Incident if not blank
        if(UsrMap.get(owner).RF_Delegated_Approver__c!=Null)
        {
            i.RF_Delegated_Approver__c=UsrMap.get(owner).RF_Delegated_Approver__c;
        }    
    }    
}