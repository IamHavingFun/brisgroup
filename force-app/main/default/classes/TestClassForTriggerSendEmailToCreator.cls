/*
Test class for the trigger - 'sendEmailToCreator'.
*/
@IsTest
private class TestClassForTriggerSendEmailToCreator {
   
    @IsTest
    static void testMethodForMAilSend() {
        Integer emailInvocationBeforeTrigger = Limits.getEmailInvocations();
        Test.startTest();
        /* 
         Create a test user so that user id of any existing user does not have to be hardcoded for
        the task owner.
        */
       User taskOwner = TestUtilityDataFactory.insertSystemUser('System Administrator', 'agt');

        Account a = new Account(name = 'Account 1', Address_Line_1__c='NM', County__c='Durham', Postcode__c='400703');
        insert a;
      

        Contact c = new Contact(lastname='smith');
        insert c;
      
        Opportunity opp = new Opportunity(
            name = 'Opportunity 1', 
            stagename = 'Prospecting', 
            closedate = Date.today() + 5,
            Address_Line_1__c = 'NM',
            County__c = 'Durham',
            Postcode__c = '400703',
            Customer_Order_Number__c = 'Test', 
            Estimated_Start_Date__c = Date.today(), 
            Estimated_Completion__c = date.today().addDays(60)
        );
        insert opp;

        Task t = new Task(
            subject = 'Send Email',
            Notify_Assignee__c = true, 
            activitydate = Date.today(), 
            whatid = a.id, 
            description = 'test', 
            priority = 'Normal', 
            status = 'Not Started', 
            ownerid = taskOwner.id
        );
        insert t;
        t.status = 'Completed';
        update t;
        System.assertNotEquals(emailInvocationBeforeTrigger, Limits.getEmailInvocations(), 'Email was not sent'); 
        Test.stopTest();        
    }
}