/**
 * @author PolSource
 */
public with sharing class QuoteTriggerHandler {

    private QuoteTriggerHandler() {}


    public static void updateApprovers(List<Quote> records){

        Try{
            Map<Id,User> UserMap = new Map<Id,User>([SELECT Id,Name,Division__c, Approver_1__c, Approver_2__c, Approver_3__c FROM User]); //Creating map of user ids and user record
            system.debug('********************USER : ' + UserMap);
            set<id> Qts = new set<id>();
            map<id,id> oppOwnerMap=new map<id,id>();
            for(Quote qt: records){
                Qts.add(qt.OpportunityId);
            }
            for(Opportunity o:[SELECT ID, ownerid FROM Opportunity WHERE ID IN:Qts ])
            {
                oppOwnerMap.put(o.Id, o.ownerid);
            }
          
            if(!oppOwnerMap.isEmpty()){
                for(Quote qt1: records){

                //Updating the Approvers field on Quote wrt Users/Owner field
                system.debug('********************OWNER : ' + UserMap.get(oppOwnerMap.get(qt1.OpportunityId)));
                if(UserMap.get(oppOwnerMap.get(qt1.OpportunityId)).Approver_1__c!= Null)
                {
                    qt1.Approver_1__c = UserMap.get(oppOwnerMap.get(qt1.OpportunityId)).Approver_1__c;
                }
                
                //Updating the Approvers field on Quote wrt Users/Owner field
                if(UserMap.get(oppOwnerMap.get(qt1.OpportunityId)).Approver_2__c!= Null)
                {
                    qt1.Approver_2__c = UserMap.get(oppOwnerMap.get(qt1.OpportunityId)).Approver_2__c;
                }
                
                //Updating the Approvers field on Quote wrt Users/Owner field
                if(UserMap.get(oppOwnerMap.get(qt1.OpportunityId)).Approver_3__c!= Null)
                {
                    qt1.Approver_3__c = UserMap.get(oppOwnerMap.get(qt1.OpportunityId)).Approver_3__c;
                }
                system.debug('**************** Quote : ' +qt1);
                }
            } 
          
        }Catch(Exception e){
        System.debug('**************************exception in trigger on quotes:'+e);
        }

    }


    public static void updateOppField(List<Quote> records){

        Final String OpportunityTyp1='Opportunity';
        schema.describesobjectresult result = Opportunity.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> recTypeId = result.getrecordtypeinfosbyname();
        Id OpprecordType = recTypeId.get(OpportunityTyp1).getrecordtypeid();
        schema.describesobjectresult result1 = Opportunity.sobjecttype.getdescribe();
        
        Set<id> oppIds=new Set<id>();
        Map<Id,opportunity> oppMap=new Map<Id,opportunity>();  
        Set<string> OppSet = new Set<string>();
        List<opportunity> updateTheseOpps = new List<opportunity>();
  
        for(Quote q:records) 
        {
            oppIds.add(q.OpportunityId);// Adding opportunity ids to set of Ids
        }

        for(opportunity opp :[SELECT Id,Name,StageName,Opportunity.RecordTypeId FROM Opportunity WHERE Id in:oppIds])
        {
            oppMap.put(opp.id,opp); // Adding opportunity to map
        }

        for(Quote q1 :records)
        {
            if(oppMap.containsKey(q1.opportunityid) && q1.Status=='Won') //Checking Map of Opportunity if it contains the opportunity Id and Status of Quote
            {     
                opportunity opp1 =  oppmap.get(q1.opportunityid); //Getting  the opportunity to be updated into a variable
                if(opp1.RecordTypeId==OpprecordType)
                {
                    system.debug('*********************Inside Oppty If');
                    opp1.StageName='Order - Won'; //Update the stage of Opportunity
                    if(!OppSet.contains(q1.opportunityid)) //If the list of Opportunity is not containing the opportunityid 
                    {            
                        OppSet.add(q1.opportunityid); // Add it to the list of opportunity
                        updateTheseOpps.add(opp1); // Add to the list of Opportunity which needs to be updated
                    }               
                } // End of Inner if
            } // End of outer if
        } // End of For loop

        if(!updateTheseOpps.isEmpty())// If list of updating opportunity is not empty
        {
            try {
                update updateTheseOpps; // Updating opportinity
            }
            Catch(Exception e){}
        }
    }


}