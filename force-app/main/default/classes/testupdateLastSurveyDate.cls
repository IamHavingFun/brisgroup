/** This is a test class for the trigger updateLastSurveyDate.
 *  Author-Steve Mason
 *  Email-smason@bristan.com
 *  Since-July 2014
**/
@istest
private class testupdateLastSurveyDate{
static testmethod void testupdateLastSurveyDate(){
// Create a Profile object and populate it with the id of the System Administrator.
      Profile p = [select id from profile where name = 'System Administrator'];      
      /* 
      Create a test user so that user id of any existing user does not have to be hardcoded for
      the task owner.
      */
      User testUser = new User(alias = 'abc', email = 'testupdateLastSurveyDate@yaoo.com', EmailEncodingKey = 'UTF-8', 
               LastName = 'Bristan', FirstName= 'Bristan', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', 
               ProfileId = p.Id, TimeZoneSidKey = 'America/Los_Angeles', UserName = 'testuser@yorvik.com'
               );               
      // Insert the test user into Salesforce.         
      INSERT testUser;
      user testuser2 = [select id from user where email = 'testupdateLastSurveyDate@yaoo.com'];
      Id recordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'Account' AND DeveloperName = 'PersonAccount' LIMIT 1].Id;
      Account a = new Account(firstname='Bob',lastname='Bob',RecordTypeId=recordTypeId);
      INSERT a;
      Contact c = new Contact(lastname='smith');
      INSERT c;
      contact c2 = [select id, Last_Survey_Date_del__c from contact where lastname = 'smith'];
      case cs=new Case(Subject='Test',Case_Channel__c='Phone',Status='New', ContactId=c2.Id, OwnerId = testUser2.id);
      INSERT cs;
      case cs2 = [select id, Survey_Sent__c from case where subject = 'Test'];
      system.assertEquals(c2.Last_Survey_Date_del__c,null);
      cs2.Survey_Sent__c = true;
      UPDATE cs2;
      contact c3 = [select id, Last_Survey_Date_del__c from contact where lastname = 'smith'];
      system.assertNotEquals(c3.Last_Survey_Date_del__c,null);
      contact c4 = [select id, Last_Indirect_Survey_Date__c from contact where lastname = 'smith'];
      case cs3 = [select id, Indirect_Survey_Sent__c from case where subject = 'Test'];
      system.assertEquals(c4.Last_Indirect_Survey_Date__c,null);
      cs3.Indirect_Survey_Sent__c = true;
      UPDATE cs3;
      contact c5 = [select id, Last_Indirect_Survey_Date__c from contact where lastname = 'smith'];
      system.assertNotEquals(c5.Last_Indirect_Survey_Date__c,null);
      
      contact c6 = [select id, Last_Survey_Date_del__c from contact where lastname = 'smith'];
      system.assertNotEquals(c6.Last_Survey_Date_del__c,null);
      contact c7 = [select id, Last_Bristancare_Survey_Date__c from contact where lastname = 'smith'];
      case cs4 = [select id, Bristancare_Survey_Sent__c from case where subject = 'Test'];
      system.assertEquals(c7.Last_Bristancare_Survey_Date__c,null);
      cs4.Bristancare_Survey_Sent__c = true;
      UPDATE cs4;
      contact c8 = [select id, Last_Bristancare_Survey_Date__c from contact where lastname = 'smith'];
      system.assertNotEquals(c8.Last_Bristancare_Survey_Date__c,null);
      
      contact con = [select id, Last_Survey_Date_del__c from contact where lastname = 'Bob'];     
      case cas=new Case(Subject='Test2',Case_Channel__c='Phone',Status='New', ContactId=con.Id, OwnerId = testUser2.id);
      INSERT cas;
      case cas2 = [select id, Survey_Sent__c from case where subject = 'Test2'];
      system.assertEquals(con.Last_Survey_Date_del__c,null);
      cas2.Survey_Sent__c = true;
      UPDATE cas2;
      contact con3 = [select id, Last_Survey_Date_del__c from contact where lastname = 'Bob'];
      system.assertNotEquals(con3.Last_Survey_Date_del__c,null);
      contact con4 = [select id, Last_Indirect_Survey_Date__c from contact where lastname = 'Bob'];
      case cas3 = [select id, Indirect_Survey_Sent__c from case where subject = 'Test2'];
      system.assertEquals(con4.Last_Indirect_Survey_Date__c,null);
      cas3.Indirect_Survey_Sent__c = true;
      UPDATE cas3;
      contact con5 = [select id, Last_Indirect_Survey_Date__c from contact where lastname = 'Bob'];
      system.assertNotEquals(con5.Last_Indirect_Survey_Date__c,null);
      
      contact con6 = [select id, Last_Survey_Date_del__c from contact where lastname = 'Bob'];
      system.assertNotEquals(con6.Last_Survey_Date_del__c,null);
      contact con7 = [select id, Last_Bristancare_Survey_Date__c from contact where lastname = 'Bob'];
      case cas4 = [select id, Bristancare_Survey_Sent__c from case where subject = 'Test2'];
      system.assertEquals(con7.Last_Bristancare_Survey_Date__c,null);
      cas4.Bristancare_Survey_Sent__c = true;
      UPDATE cas4;
      contact con8 = [select id, Last_Bristancare_Survey_Date__c from contact where lastname = 'Bob'];
      system.assertNotEquals(con8.Last_Bristancare_Survey_Date__c,null);
      }
} //End of test class