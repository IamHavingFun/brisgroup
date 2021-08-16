public with sharing class AccountRequestTriggerHandler {
    public AccountRequestTriggerHandler() {}

    public static void lockRequestOnCompletion(List<Account_Request__c> oldRecords, List<Account_Request__c> newRecords){

        for(Account_Request__c o : newRecords){ 
            for(Account_Request__c oldOrd : oldRecords){
                if(o.Id == oldOrd.Id){

                    if(o.Locked__c == true && oldOrd.Locked__c <> true)
                    {
                        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                        req1.setComments('Submitting request for approval.');
                        req1.setObjectId(o.id);
                        Approval.ProcessResult result = Approval.process(req1); 
                        System.assert(result.isSuccess());        
                    }
                }
            }    
        }
    }
}