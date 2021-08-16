public with sharing class OpportunityApprovalHistoryController {
    public String opportunityId{get;set;}
    public List<ProcessInstanceHistory> getApprovalSteps() {
      if (opportunityId!= null) {
        Opportunity opp= [Select Id, (Select TargetObjectId, SystemModstamp, StepStatus, RemindersSent, ProcessInstanceId, OriginalActorId, IsPending, IsDeleted, Id, CreatedDate, CreatedById, Comments, ActorId, Actor.Name From ProcessSteps order by SystemModstamp desc) from Opportunity where Id = :opportunityID];
        return opp.ProcessSteps;
      }
      return new List<ProcessInstanceHistory> ();
    }  
    
}