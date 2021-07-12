@isTest(SeeAllData = True)
private class CardPaymentTriggerTest {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
        Profile serviceuser = [Select Name, Id From Profile where Name = 'System Administrator' limit 1 ]; //Service Back Office User
        
        
        //serviceuser.Name = 'Service Back Office UsertEST';
        //serviceuser.
        
        
        system.debug('#### serviceuser =' + serviceuser);
    
        User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : serviceuser.id limit 1];
        
        // User u2 = new User(Alias = 'newTTTT', Email='newuser@testorg.com', 
        // EmailEncodingKey='UTF-8', LastName='Testingqq', LanguageLocaleKey='en_US', 
        // LocaleSidKey='en_US', ProfileId = serviceuser.Id, 
       //  TimeZoneSidKey='America/Los_Angeles', UserName='newuserTTTT@testorg.com');
        
        
              
        
         System.runAs(thisuser)
        {
            
            Account newacc = new Account(Name = 'test name' );
            insert newacc;
            
            Contact ct = new Contact(LastName = 'Paul', FirstName = 'have', AccountID = newacc.id, MailingStreet = 'Test Street', MailingCity = 'Test City',
             MailingState = 'Test State', MailingPostalCode = 'AAA AAA', MailingCountry = 'United Kingdom', Birthdate = date.newInstance(1988, 04, 06), Email = 'Test.User@User.com');
                
            insert ct;   
            
            //Order__c ord = new Order__c(Delivery_Term__c  );
            Order__c ord = [Select id From Order__c limit 1];
            
            
            system.debug('#### ord =' + ord);
            
            
            Income_Card_Payment__c inc = new Income_Card_Payment__c(Immediate_Amount__c = 100, Contact__c = ct.id, 
             Payment_Status__c = 'Authorised', Card_Type__c  = '', Authorisation_Date__c  = Date.today(), Transaction_Type__c  = 'Sale'
             , Order__c = ord.id );
             
            insert inc;
            
        }
        
        
        
    }
    
    
    
    
    
}