/*
 * This trigger updates the Approvers on Quote  form its Opportunity Owner user record.
 * Author : Bhushan Adhikari
 * since  : June 2012
 * E-Mail : badhikari@innoveer.com
 */
trigger updateApprovers on Quote (before insert, before update) {

  Try
  {
          Map<Id,User> UserMap = new Map<Id,User>([SELECT Id,Name,Division__c, Approver_1__c, Approver_2__c, Approver_3__c FROM User]); //Creating map of user ids and user record
          system.debug('********************USER : ' + UserMap);
          set<id> Qts = new set<id>();
          map<id,id> oppOwnerMap=new map<id,id>();
          for(Quote qt: trigger.new){
              Qts.add(qt.OpportunityId);
          }
          for(Opportunity o:[SELECT ID, ownerid FROM Opportunity WHERE ID IN:Qts ])
          {
            oppOwnerMap.put(o.Id, o.ownerid);
          }
          
          if(!oppOwnerMap.isEmpty())
          {
            for(Quote qt1: trigger.new){
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