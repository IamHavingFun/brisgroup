/**This is test class for the trigger 'sendEmailtoCreatorTest'
*  Author-Steve Mason
*  Email-smason@bristan.com
**/
@isTest
private class sendEmailtoCreatorTest{

    static testMethod void shouldSendEmail() {

        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : p.id limit 1];
        // User usr = new User(Alias = 'stdu', Email = 'standarduser@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
        //                     'Test', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
        //                     'America/Los_Angeles', UserName = 'stndusr@test.com',Division__c='');
        // INSERT usr; 
        
        Integer emailBefore = Limits.getEmailInvocations();
        system.runas(thisuser) {
          Task l = new Task(Subject = 'Test',Status = 'New',OwnerId = thisuser.id, Notify_Assignee__c = true);

          Test.startTest();
          insert l;
          l.Status = 'Completed';
          update l;
          System.assertNotEquals(emailBefore, Limits.getEmailInvocations());
          Test.stopTest();
        }

        
    }


    static testMethod void shouldNotSendEmail() {
            
      Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
      User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : p.id limit 1];

      // User usr = new User(Alias = 'stdu', Email = 'standarduser@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
      //                     'Test', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
      //                     'America/Los_Angeles', UserName = 'stndusr@test.com',Division__c='');
      // INSERT usr; 
      
      Integer emailBefore = Limits.getEmailInvocations();
      system.runas(thisuser) {
        Task l = new Task(Subject = 'Test',Status = 'New',OwnerId = thisuser.id, Notify_Assignee__c = false);

        Test.startTest();
        insert l;
        l.Status = 'Completed';
        update l;
        System.assertEquals(emailBefore, Limits.getEmailInvocations());
        Test.stopTest();
      }

      
  }
}