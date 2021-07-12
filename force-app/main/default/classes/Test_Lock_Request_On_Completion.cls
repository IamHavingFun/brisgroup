@isTest(SeeAllData = True)
private class Test_Lock_Request_On_Completion {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
    Profile serviceuser = [Select Name, Id From Profile where Name = 'System Administrator' limit 1 ]; 
    system.debug('#### serviceuser =' + serviceuser);
  
    User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : serviceuser.id limit 1];

    System.runAs(thisuser)
    {

      Account_Request__c o = new Account_Request__c(Name='Test Business');
      insert o;
      system.debug('#### Req =' + o);
          
      o.Locked__c = true;
      o.Status__c = 'Completed';
         
      update o;
    }
    }
}