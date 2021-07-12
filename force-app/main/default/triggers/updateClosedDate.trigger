/**This trigger will set the Closed_Date__c field when the status is set to closed
 * Author-Steve Mason
 * Email-smason@bristan.com
 * Since March 2013
**/
trigger updateClosedDate on Event (before insert,before update) {
   for(event evt :trigger.new) { 
     datetime myDateTime = datetime.now();
     if (evt.Status__c == 'Closed' && evt.Closed_Date__c == null)
     {
       evt.Closed_Date__c = myDateTime;
     }
     if (evt.Status__c == 'Cancelled' && evt.Closed_Date__c == null)
     {
       evt.Closed_Date__c = myDateTime;
     }
  } //End of For
} // End of Trigger