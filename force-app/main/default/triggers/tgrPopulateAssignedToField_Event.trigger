// This trigger populates the read-only field "Assigned To" on events,
// Along with ManagerName and Customer Type
// It's needed because
// 1) the Owner field can't be used in 
//    formula fields--really! See http://tinyurl.com/ActivityDate
// ManagerName is required for reporting setup and Customer Type is
// required for a report (can't be accessed through the report)

trigger tgrPopulateAssignedToField_Event on Event (before insert, before update) { 
    Map<Id, String> ownerMap = new Map<Id, String>();
    Map<Id, String> managerMap = new Map<Id, String>();
    Map<Id, Id> contactMap = new Map<Id, Id>(); 
    Map<Id, String> accountMap = new Map<Id, String>();     
    Id AccountID;
    
//  Get owner name from user using OwnerID    
    for (Event e : Trigger.new)
    {
        ownerMap.put(e.OwnerId, null);
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
        for (Event e : Trigger.new)
        {
            e.Assigned_To__c  = ownerMap.get(e.OwnerId);
        }
    }  
//  Get ManagerName__c from user using OwnerID
    for (Event e : Trigger.new)
    {
        managerMap.put(e.OwnerId, null);
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
        for (Event e : Trigger.new)
        {
            e.ManagerName__c  = managerMap.get(e.OwnerId);
        }
    }  
//  Get AccountID from contact using WhoID
    for (Event e : Trigger.new)
    {
        contactMap.put(e.WhoId, null);
    }

    if (contactMap.size() > 0)
    {
        for (Contact[] contacts : [SELECT Id, AccountID FROM Contact WHERE Id IN :contactMap.keySet()])
        {
            for (Integer i=0; i<contacts.size(); i++)
            {
                contactMap.put(contacts[i].Id, contacts[i].AccountID);
            }
        }
        for (Event e : Trigger.new)
        {
            AccountID = contactMap.get(e.WhoID);
        }
    }
//  Get Customer_Type__c from account using AccountID
    for (Event e : Trigger.new)
    {
        accountMap.put(AccountID, null);
    }

    if (accountMap.size() > 0)
    {
        for (Account[] Accounts : [SELECT Id, Type FROM Account WHERE Id IN :accountMap.keySet()])
        {
            for (Integer i=0; i<accounts.size(); i++)
            {
                accountMap.put(accounts[i].Id, accounts[i].Type);
            }
        }
        for (Event e : Trigger.new)
        {
            e.Customer_Type__c = accountMap.get(AccountID);
        }
    }   
//  Get Division__c from user using OwnerID
    for (Event e : Trigger.new)
    {
        managerMap.put(e.OwnerId, null);
    }

    if (managerMap.size() > 0)
    {
        for (User[] users : [SELECT Id, Division__c FROM User WHERE Id IN :managerMap.keySet()])
        {
            for (Integer i=0; i<users.size(); i++)
            {
                managerMap.put(users[i].Id, users[i].Division__c);
            }
        }
        for (Event e : Trigger.new)
        {
            e.Division__c  = managerMap.get(e.OwnerId);
        }
    }     
}