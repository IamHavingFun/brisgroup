trigger Lock_Order_On_Cancel on Order__c (after update) 
{
  for(Order__c o: trigger.new){ 
     Order__c oldOrd = trigger.oldMap.get(o.Id);
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