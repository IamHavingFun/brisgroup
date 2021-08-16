public with sharing class SaleTriggerHandler {
    public SaleTriggerHandler() {}


    public static void tgrPopulateRepOwnerField_Sale(List<Sale__c> records){

        Map<Id, Id> ownerMap = new Map<Id, Id>();
    
    //  Get account owner 
        for (Sale__c o : records)
        {
            ownerMap.put(o.Account__c, null);
        }
        
        String check = '0';
        for (Sale__c o : records)
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
            for (Sale__c o : records)
            {
                o.Rep_Owner_Lookup__c = ownerMap.get(o.Account__c);
            }
        }
        else
        {
            for (Sale__c o : records)
            {
                o.Rep_Owner_Lookup__c = o.OwnerId;
            }
        }

    }
}