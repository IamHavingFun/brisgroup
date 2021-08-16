public with sharing class OrderTriggerHandler {
    public OrderTriggerHandler() {}

    public static void lockOrderOnCancel(List<Order__c> oldRecords, List<Order__c> newRecords){

        for(Order__c o: newRecords){ 
            for(Order__c oldOrd : oldRecords){
                if(o.Id == oldOrd.Id){
                    if(o.Locked__c == true && oldOrd.Locked__c <> true)
                    {
                        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                        req1.setComments('Submitting request for approval.');
                        req1.setObjectId(o.id);
                        Approval.ProcessResult result = Approval.process(req1); 
                        System.debug('TEST:result: ' + result);
                        System.assert(result.isSuccess());        
                    }
                }
            }
            
        }

    }
}