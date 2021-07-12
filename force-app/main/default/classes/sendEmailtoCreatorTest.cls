/**This is test class for the trigger 'sendEmailtoCreatorTest'
*  Author-Steve Mason
*  Email-smason@bristan.com
**/
@isTest
private class sendEmailtoCreatorTest{

    static testMethod void myUnitTest() {
        
        list<user> userList=new list<user>();//List of users
        
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
       
        //Creating three users for testing
         User usr = new User(Alias = 'stdu', Email = 'standarduser@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
                            'Test', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
                            'America/Los_Angeles', UserName = 'stndusr@test.com',Division__c='');
        INSERT usr; 
                
        system.runas(usr) {
          Task l = new Task(Subject = 'Test',Status = 'New',OwnerId = usr.id, Notify_Assignee__c = true);
          insert l;
          l.Status = 'Completed';
          update l;
        }
    }
}