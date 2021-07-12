/** This is a test class for the trigger which updates the custom dates by standard dates of event.
 *  Author-Hema Kulkarni
 *  Email-hkulkarni@innoveer.com
 *  Since-Jun 2012
**/
@istest
private class testupdateCustomDates{
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
 Event evnt=[Select id, End_Date__c,Start_Date__c, EndDateTime,StartDateTime from event where id =:evt.id];
 system.assertEquals(evnt.EndDateTime,evnt.End_Date__c);
 system.assertEquals(evnt.StartDateTime,evnt.Start_Date__c);
 
}
  
} //End of test class