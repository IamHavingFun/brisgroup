// This trigger populates the read-only field "Rep_Owner_Lookup__c" on Sales Summaries,
// It's needed to create a single field that holds either the account owner (sales summary) or the owner (target)
// For the joined report grouping for sales vs performance

trigger tgrPopulateRepOwnerField_Sale on Sale__c (before insert, before update) { 
    Map<Id, Id> ownerMap = new Map<Id, Id>();
    
//  Get account owner 
    for (Sale__c o : Trigger.new)
    {
        ownerMap.put(o.Account__c, null);
    }
    public string check;
    check = '0';
    for (Sale__c o : Trigger.new)
    {
        if (o.Account__c != null)
        {
            check = '1';
        }
    }    
        if (check == '1')
        {
            for (Account[] accounts : [SELECT Id, OwnerId FROM Account WHERE Id IN :ownerMap.keySet()])        
            {            
                for (Integer i=0; i<accounts.size(); i++)            
                {              
                    System.debug('*************************AccountId : ' +accounts[i].Id);
                    System.debug('*************************AccountId : ' +accounts[i].OwnerId);  
                    ownerMap.put(accounts[i].Id, accounts[i].OwnerId);            
                }        
            }
            for (Sale__c o : Trigger.new)
            {
                o.Rep_Owner_Lookup__c = ownerMap.get(o.Account__c);
            }
        }
        else
        {
            for (Sale__c o : Trigger.new)
            {
                o.Rep_Owner_Lookup__c = o.OwnerId;
            }
        }
 }