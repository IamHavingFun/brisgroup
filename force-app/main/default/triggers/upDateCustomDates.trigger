/**This is a simple trigger which will update the custom date fields by standard date fields as we the standard date fields are available in formula to 
 * run the report 'Call Report Completed on time'
 * Author-Hema Kulkarni
 * Email-hkulkarni@innoveer.com    
 * Since May 2012
**/
trigger upDateCustomDates on Event (before insert,before update) {
   for(event evt :trigger.new) { 
   evt.Start_Date__c=evt.StartDateTime; //Updating custom start date
   evt.End_Date__c=evt.EndDateTime;  //Updating custom end date
      
  } //End of For


} // End of Trigger