/** This trigger is for updating the Opportunity Stage to 'Closed Won' once any related Quote gets approved.
 * Author-Hema Kulkarni
 * Email-hkulkarni@innoveer.com
 * Since-June 2012
**/
trigger UpdateOppField on Quote(After Update) 
{   //Declarations

Final String OpportunityTyp1='Opportunity';
schema.describesobjectresult result = Opportunity.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> recTypeId = result.getrecordtypeinfosbyname();
        Id OpprecordType = recTypeId.get(OpportunityTyp1).getrecordtypeid();
        schema.describesobjectresult result1 = Opportunity.sobjecttype.getdescribe();
        

   Set<id> oppIds=new Set<id>();
   Map<Id,opportunity> oppMap=new Map<Id,opportunity>();  
   Set<string> OppSet = new Set<string>();
   List<opportunity> updateTheseOpps = new List<opportunity>();
  

   for(Quote q:trigger.new) 
   {
      oppIds.add(q.OpportunityId);// Adding opportunity ids to set of Ids
   }

   for(opportunity opp :[SELECT Id,Name,StageName,Opportunity.RecordTypeId FROM Opportunity WHERE Id in:oppIds])
   {
      oppMap.put(opp.id,opp); // Adding opportunity to map
   }

   for(Quote q1 :trigger.new)
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
   
} // End Of trigger