/** This is a test class for the trigger which updates the closed date of event.
 *  Author-Steve Mason
 *  Email-smason@bristan.com
 *  Since-Jun 2012
**/
@istest
private class testupdateClosedDateEvent{
static testmethod void testUpdateCustomDates(){
// Create a Profile object and populate it with the id of the System Administrator.
      Profile p = [select id from profile where name = 'System Administrator'];      
      /* 
      Create a test user so that user id of any existing user does not have to be hardcoded for
      the task owner.
      */
      User taskOwner = new User(alias = 'abc', email = 'testuser@yahoo.com', EmailEncodingKey = 'UTF-8', 
               LastName = 'Innoveer', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', 
               ProfileId = p.Id, TimeZoneSidKey = 'America/Los_Angeles', UserName = 'testuser@yorvik.com'
               );               
      // Insert the test user into Salesforce.         
      INSERT taskOwner;
      Contact c = new Contact(lastname='smith');
      INSERT c;
      //c = [select id, name from contact where id = :c.id];
 Event evt=new Event(subject='Call',StartDateTime=Date.today(),EndDateTime=Date.today(), CurrencyIsoCode='GBP', ownerid = taskOwner.id,whoid=c.id);
 INSERT evt;
 Event evnt=[Select id, Status__c, End_Date__c,Start_Date__c, EndDateTime,StartDateTime from event where id =:evt.id];
 Event evt2=new Event(subject='Call',StartDateTime=Date.today(),EndDateTime=Date.today(), CurrencyIsoCode='GBP', ownerid = taskOwner.id,whoid=c.id);
 INSERT evt2;
 Event evnt2=[Select id, Status__c, End_Date__c,Start_Date__c, EndDateTime,StartDateTime from event where id =:evt2.id];
 evnt.Status__c = 'Closed';
 update evnt;
 evnt2.Status__c = 'Cancelled';
 update evnt2;
 system.assertEquals(evnt.EndDateTime,evnt.End_Date__c);
 system.assertEquals(evnt.StartDateTime,evnt.Start_Date__c);
 system.assertEquals(evnt2.EndDateTime,evnt2.End_Date__c);
 system.assertEquals(evnt2.StartDateTime,evnt2.Start_Date__c);
 
}
  
} //End of test class