public with sharing class EventTriggerHandler {
    public EventTriggerHandler() {}

    public static void tgrPopulateAssignedToField_Event(List<Event> records){

        Map<Id, String> ownerMap = new Map<Id, String>();
        Map<Id, String> managerMap = new Map<Id, String>();
        Map<Id, Id> contactMap = new Map<Id, Id>(); 
        Map<Id, String> accountMap = new Map<Id, String>();     
        Id AccountID;
        
    //  Get owner name from user using OwnerID    
        for (Event e : records)
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
            for (Event e : records)
            {
                e.Assigned_To__c  = ownerMap.get(e.OwnerId);
            }
        }  
    //  Get ManagerName__c from user using OwnerID
        for (Event e : records)
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
            for (Event e : records)
            {
                e.ManagerName__c  = managerMap.get(e.OwnerId);
            }
        }  
    //  Get AccountID from contact using WhoID
        for (Event e : records)
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
            for (Event e : records)
            {
                AccountID = contactMap.get(e.WhoID);
            }
        }
    //  Get Customer_Type__c from account using AccountID
        for (Event e : records)
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
            for (Event e : records)
            {
                e.Customer_Type__c = accountMap.get(AccountID);
            }
        }   
    //  Get Division__c from user using OwnerID
        for (Event e : records)
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
            for (Event e : records)
            {
                e.Division__c  = managerMap.get(e.OwnerId);
            }
        }     

    }


    public static void updateClosedDate(List<Event> records){

        for(event evt :records) { 
            datetime myDateTime = datetime.now();
            if (evt.Status__c == 'Closed' && evt.Closed_Date__c == null)
            {
              evt.Closed_Date__c = myDateTime;
            }
            if (evt.Status__c == 'Cancelled' && evt.Closed_Date__c == null)
            {
              evt.Closed_Date__c = myDateTime;
            }
        } //End of For

    }


    public static void upDateCustomDates(List<Event> records){

        for(event evt :records) { 
            evt.Start_Date__c=evt.StartDateTime; //Updating custom start date
            evt.End_Date__c=evt.EndDateTime;  //Updating custom end date  
        }

    }


    public static void updateEventAddress(List<Event> records){

        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
    
        //Map to store Id prefix and the corresponding sObject Name
        Map<String,String> keyPrefixMap = new Map<String,String>{};
        
        Set<String> keyPrefixSet = gd.keySet();
        //Iterating through set of Objects in the environment to get their keyPrefix,Name and putting them in the keyPrefixMap    
        for(String sObj : keyPrefixSet){
        
           Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
                  
           //getting the Name of the SObject
           String tempName = r.getName(); 
           
           //getting the keyPrefix of the sObject
           String tempPrefix = r.getKeyPrefix();
           
           System.debug('Processing Object['+tempName + '] with Prefix ['+ tempPrefix+']');
           //adding the sObject keyPrefix and its corresponding sObject Name to the Map
           keyPrefixMap.put(tempPrefix,tempName);
        }
        
        
        //List to store all contact ids 
        List<Id> EvtCon = new List<Id>();
        
        for(Event e: records)
        {
            if(e.WhoId!=null){
                String ePrefix = e.WhoId;
                ePrefix = ePrefix.subString(0,3);
                if(keyPrefixMap.get(ePrefix) == 'Contact')
                {
                    EvtCon.add(e.whoId);
                }
            }
        }
        system.debug('********** EvtCon : ' + EvtCon);
        List<Event> eventlist=[SELECT id,Address_Line_1__c,Address_Line_2__c,Country__c,County__c,Postcode__c,Town__c,Whoid FROM Event WHERE id IN : records];
        system.debug('********** eventlist : ' + eventlist);
        List<contact> con = new List<contact>();
        if(!EvtCon.isEmpty()){
            con = [SELECT Id, Name,Account_Address_Line_1__c,Account_Address_Line_2__c,Account_Country__c,Account_County__c,Account_Postcode__c ,Account_Town__c FROM Contact WHERE ID IN:EvtCon];        system.debug('****************Contact : ' + con);
        }
       
        
        /* Following block of code iterates through list of records in records , checks for the particular contact in contact list 
           and also checks for the Address fields on event are blank or not, if address is left blank it updates it with the related contact address. */
           
        for(Event e1 : records)
        {
            for(Contact c : con)
            {
                if(e1.whoId == c.id && (e1.Address_Line_1__c == null && e1.Address_Line_2__c==null && e1.Country__c==null && e1.Town__c==null &&e1.Postcode__c ==null &&e1.County__c == null ))
                {
                    e1.Address_Line_1__c = c.Account_Address_Line_1__c;
                    e1.Address_Line_2__c = c.Account_Address_Line_2__c;
                    e1.Country__c = c.Account_Country__c;
                    e1.County_State__c = c.Account_County__c;
                    e1.Postcode__c = c.Account_Postcode__c;
                    e1.Town__c = c.Account_Town__c;
                  
                 }
      
             }
        }  

    }

}