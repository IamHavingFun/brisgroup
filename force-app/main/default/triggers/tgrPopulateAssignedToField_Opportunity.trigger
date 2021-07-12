// This trigger populates the read-only field "Assigned To" on events,
// Along with ManagerName=
// It's needed because
// 1) the Owner field can't be used in 
//    formula fields--really! See http://tinyurl.com/ActivityDate
// ManagerName is required for reporting setup

trigger tgrPopulateAssignedToField_Opportunity on Opportunity (before insert, before update) { 
    Map<Id, String> ownerMap = new Map<Id, String>();
    Map<Id, String> managerMap = new Map<Id, String>();
    
//  Get owner name from user using OwnerID    
    for (Opportunity o : Trigger.new)
    {
        ownerMap.put(o.OwnerId, null);
    }

    if (ownerMap.size() > 0)
    {
        for (User[] users : [SELECT Id, Name FROM User WHERE Id IN :ownerMap.keySet()])
        {
            for (Integer i=0; i<users.size(); i++)
            {
                ownerMap.put(users[i].Id, users[i].Name);
            }
        }
        for (Opportunity o : Trigger.new)
        {
            o.Assigned_To__c  = ownerMap.get(o.OwnerId);
        }
    }  
//  Get ManagerName__c from user using OwnerID
    for (Opportunity o : Trigger.new)
    {
        managerMap.put(o.OwnerId, null);
    }

    if (managerMap.size() > 0)
    {
        for (User[] users : [SELECT Id, ManagerName__c FROM User WHERE Id IN :managerMap.keySet()])
        {
            for (Integer i=0; i<users.size(); i++)
            {
                managerMap.put(users[i].Id, users[i].ManagerName__c);
            }
        }
        for (Opportunity o : Trigger.new)
        {
            o.ManagerName__c  = managerMap.get(o.OwnerId);
        }
    }  
}