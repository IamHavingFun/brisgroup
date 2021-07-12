@isTest(SeeAllData = True)
private class Lock_Order_On_CancelTest {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
    Profile serviceuser = [Select Name, Id From Profile where Name = 'System Administrator' limit 1 ]; 
    system.debug('#### serviceuser =' + serviceuser);
  
    User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : serviceuser.id limit 1];

    System.runAs(thisuser)
    {
      Account newacc = TestDataCreation.CreateAccount('Test');
      Contact ct = TestDataCreation.createContact('Paul', 'Harvie', newacc.id);
      Case cs = TestDataCreation.CreateCase('Test Case', newacc.id, ct.id);
      Delivery_Term__c newdt = TestDataCreation.CreateDeliveryTermPST(); 
      Order__c ord = new Order__c(Case_Account__c = newacc.id, Case__c = cs.id, Delivery_Term__c = newdt.id);
      insert ord;
      system.debug('#### ord =' + ord);
          
      ord.Locked__c = true;
      ord.Status__c = 'Cancelled';
         
      update ord;
    }
    }
}