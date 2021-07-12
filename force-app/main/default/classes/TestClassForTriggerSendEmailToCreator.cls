/*
Test class for the trigger - 'sendEmailToCreator'.
*/
@isTest
private class TestClassForTriggerSendEmailToCreator 
{     
   public static testmethod void testMethodForMAilSend()
   {
      Test.startTest();
      
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
      insert taskOwner;

      Account a = new Account(name = 'Account 1',Address_Line_1__c='NM',County__c='Durham',Postcode__c='400703');
      INSERT a;
      

    Contact c = new Contact(lastname='smith');
      INSERT c;
      //c = [select id, name from contact where id = :c.id];
      
      Opportunity opp = new Opportunity(name = 'Opportunity 1', stagename = 'Prospecting', closedate = Date.today() + 5,Address_Line_1__c='NM',County__c='Durham',Postcode__c='400703',Customer_Order_Number__c='Test', Estimated_Start_Date__c = date.today(), Estimated_Completion__c = date.today().addDays(60));
     INSERT opp;
      //opp = [select id, name from opportunity where id = :opp.id];

      Task t = new Task(subject = 'Send Email',Notify_Assignee__c=true, activitydate = Date.today(), whatid = a.id, /*whoid = c.id, */description = 'test', priority = 'Normal', status = 'Not Started', ownerid = taskOwner.id);
     INSERT t;
      Task t1= [select id, status from task where id = :t.id];
      t1.status = 'Completed';
      update t1;

      

      Test.stopTest();
   }
}