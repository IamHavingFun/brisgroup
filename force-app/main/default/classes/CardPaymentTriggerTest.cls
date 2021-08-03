@isTest(SeeAllData = True)
private class CardPaymentTriggerTest {

    static testMethod void shouldSetPaymentIsFromConsoleView() {
        
        Profile serviceuser = [Select Name, Id From Profile where Name = 'System Administrator' limit 1 ]; //Service Back Office User 
        User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : serviceuser.id limit 1];
           
        System.runAs(thisuser)
        {
            TestUtilityClass.setUpData();
            
            Account newacc = TestUtilityClass.acc;
            Contact ct = TestUtilityClass.con;      
            Order__c ord = [Select id From Order__c limit 1];
 
            system.debug('#### ord =' + ord);
       
            Income_Card_Payment__c inc = new Income_Card_Payment__c(
                Immediate_Amount__c = 100,
                Contact__c = ct.Id,
                Payment_Status__c = 'Authorised',
                Card_Type__c  = '',
                Authorisation_Date__c  = Date.today(),
                Transaction_Type__c  = 'Sale',
                Order__c = ord.Id
            );

            Test.startTest();
            insert inc;
            Test.stopTest();

            Income_Card_Payment__c incAfterUpdate = [
                SELECT Id, Payment_Is_From_Console_View__c
                FROM  Income_Card_Payment__c
                WHERE Id = :inc.Id
            ];

            System.assertEquals(true, incAfterUpdate.Payment_Is_From_Console_View__c);
        }
      
    }


    static testMethod void shouldSetPaymentIsFromConsoleViewAsFalse() {

        Profile standardUser = [Select Name, Id From Profile where Name = 'System Admin No Password Expiry' limit 1 ]; //User not covered by trigger
        User standardPlatformUser = [select id, name from User where IsActive = TRUE AND  Profileid = : standardUser.id limit 1];

        
        TestUtilityClass.setUpData();
        Account newacc = TestUtilityClass.acc;
        Contact ct = TestUtilityClass.con;
        Order__c ord = [Select id From Order__c limit 1];      
        
        Income_Card_Payment__c inc = new Income_Card_Payment__c(
            Immediate_Amount__c = 100,
            Contact__c = ct.Id,
            Payment_Status__c = 'Authorised',
            Card_Type__c  = '',
            Authorisation_Date__c  = Date.today(),
            Transaction_Type__c  = 'Sale',
            Order__c = ord.Id
        );

        System.runAs(standardPlatformUser)
        {
            Test.startTest();
            insert inc;
            Test.stopTest();

            Income_Card_Payment__c incAfterUpdate = [
                SELECT Id, Payment_Is_From_Console_View__c
                FROM  Income_Card_Payment__c
                WHERE Id = :inc.Id
            ];

            System.assertEquals(false, incAfterUpdate.Payment_Is_From_Console_View__c);

        }

    }
     
}