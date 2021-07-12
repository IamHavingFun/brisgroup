/** This trigger is for updating the 'Division'custom field on 'Lead'record based upon on Lead Owner's 'Division'. 
*  For example-If Lead Owner's 'Division' is 'Trade' that the custom 'Division' field will have value 'Trade'.
*  It also sets the 3 Apporver fields by pulling the Approver infoemation from Owner record.
*  Author-Hema kulkarni
*  Since-May 2012
*  Email-hkulkarni@innoveer.com
**/
trigger UpdateDivisionfieldonOpp on Opportunity (before insert,before update ) {
  
Try
{     
      //Declaration 
      Map<id,user> UsrMap=new Map<id,user>([SELECT id,Name,Division__c,Approver_1__c,Approver_2__c,Approver_3__c
                           FROM user]); //Creating map of user ids and user record

       
     for(Opportunity Opp : Trigger.new) {  
     //If Lead owner's division is not specified than lead record's division will also blank.  
    if( Opp.Division__c==Null)
    {
      if(UsrMap.get(Opp.ownerid).Division__c==Null) { 
           Opp.Division__c='';
      }//End of if statement    
      else { //If Lead owner's division is specified than lead record's division will be updated by lead owner's 'Division'.  
       Opp.Division__c=UsrMap.get(Opp.ownerid).Division__c;
      }//End of else statement
     }
     
     //Updating the Approvers field on opportunity wrt Users field
      if(UsrMap.get(Opp.ownerid).Approver_1__c!=Null)
      {
        Opp.Approver_1__c=UsrMap.get(Opp.ownerid).Approver_1__c;
      }
      
      //Updating the Approvers field on opportunity wrt Users field
      if(UsrMap.get(Opp.ownerid).Approver_2__c!=Null)
      {
        Opp.Approver_2__c=UsrMap.get(Opp.ownerid).Approver_2__c;
      }
      
      //Updating the Approvers field on opportunity wrt Users field
      if(UsrMap.get(Opp.ownerid).Approver_3__c!=Null)
      {
        Opp.Approver_3__c=UsrMap.get(Opp.ownerid).Approver_3__c;
      }
   }  //End of for loop            

}Catch(Exception e){
 system.debug('************************************Exception in Trigger on opp:'+e);
}


}//End of trigger