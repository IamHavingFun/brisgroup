/** This is a test class for the trigger updateClosedBy.
 *  Author-Steve Mason
 *  Email-smason@bristan.com
 *  Since-July 2014
**/
@isTest(SeeAllData = True)
private class testupdateClosedBy {
static testmethod void myUnitTest() {
// Create a Profile object and populate it with the id of the System Administrator.
      Profile p = [select id from profile where name = 'System Administrator'];      
      /* 
      Create a test user so that user id of any existing user does not have to be hardcoded for
      the task owner.
      */
      User testUser = new User(alias = 'abc', email = 'testupdateClosedBy@yahoo.com', EmailEncodingKey = 'UTF-8', 
               LastName = 'Bristan', FirstName= 'Bristan', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', 
               ProfileId = p.Id, TimeZoneSidKey = 'America/Los_Angeles', UserName = 'testuser@yorvik.com'
               );               
      // Insert the test user into Salesforce.         
      INSERT testUser;
      User testUser2 = [select Id, Name from User where email = 'testupdateClosedBy@yahoo.com'];
      Contact c = new Contact(lastname='smith');
      INSERT c;
      case cs=new Case(Subject='Test',Case_Channel__c='Phone',Status='New', ContactId=c.Id, OwnerId = testUser.id);
      INSERT cs;
      case csnew=[select Id, Status, Reason, Closed_By__c, Closed_by_SFID__c from case where Id = :cs.Id];
      system.assertEquals(null,csnew.Closed_By__c);
      system.assertEquals(null,csnew.Closed_by_SFID__c);     
      csnew.Status = 'Closed';
      csnew.Reason = 'Spam';
      UPDATE csnew;
      case cstest = [select Id, Closed_By__c, Closed_by_SFID__c from Case where Id = :csnew.Id];
//      system.assertEquals(testUser2.Name,cstest.Closed_By__c);
//      system.assertEquals(testUser2.Id,cstest.Closed_by_SFID__c);
      case cs2=new Case(Subject='Test',Reason='Spam',Case_Channel__c='Phone',Status='Closed', ContactId=c.Id, OwnerId = testUser.id);
      INSERT cs2;      
      case cs2test = [select Id, Closed_By__c, Closed_by_SFID__c from Case where Id = :cs2.Id];
//      system.assertEquals(testUser2.Name,testUser2.Name);
//      system.assertEquals(testUser2.Id,testUser2.Id);      
}
} //End of test class