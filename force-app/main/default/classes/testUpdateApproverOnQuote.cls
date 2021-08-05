/*
 * This class contains the data that is necessary to test OpportunityUpdatePrice and QuoteUpdatePrice classes.
 * Author : Bhushan Adhikari
 * since  : June 2012
 * E-Mail : badhikari@innoveer.com
 */

@IsTest
private class testUpdateApproverOnQuote {

    @TestSetup
    static void makeData() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
       
        //Creating three users for testing
        User usr = new User(Alias = 'stdu', Email = 'standarduser@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
                            'Test', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
                            'America/Los_Angeles', UserName = 'stndusr@test.com',Division__c='Heritage');
        insert usr;
        User usr1 = new User(Alias = 'stdu1', Email = 'standarduser1@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
                            'Test1', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
                            'America/Los_Angeles', UserName = 'stndusr1@test.com',Division__c='' );
        insert usr1;
        User usr2 = new User(Alias = 'stdu2', Email = 'standarduser2@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
                            'Test2', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
                            'America/Los_Angeles', UserName = 'stndusr2@test.com',Division__c='Retail');

        insert usr2;
        
        User usr3 = new User(Alias = 'stdu3', Email = 'standarduser3@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
                            'Test3', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
                            'America/Los_Angeles', UserName = 'stndusr3@test.com',Division__c='Retail', Approver_1__c = usr.id, Approver_2__c = usr1.id , Approver_3__c = usr2.id);
        insert usr3;

        TestUtilityDataFactory.assignUserToPermissionSet(usr3.Id, 'Create_Quotes');
    }

    @IsTest
    static void myUnitTest() {
        User usr3 = [SELECT Id, Approver_1__c, Approver_2__c, Approver_3__c FROM User WHERE Alias = 'stdu3'];
        Test.startTest();
        System.runAs(usr3) {
            Opportunity opp = new Opportunity(
                Name = 'Wills',
                OwnerId = usr3.id, 
                Division__c = 'Heritage',
                CloseDate = Date.today(),
                StageName = 'Initiating', 
                Postcode__c = '780001', 
                Address_Line_1__c = 'Buckinghamshire',
                Customer_Order_Number__c = 'Test', 
                Estimated_Start_Date__c = Date.today(), 
                Estimated_Completion__c = Date.today().addDays(60)
            );
            insert opp; //Inserted Opportunity
           
            //Quote Data
            Schema.DescribeSObjectresult resultQuote = Quote.SObjectType.getDescribe();
            Map<string, Schema.RecordTypeInfo> qutRecTypeId = resultQuote.getRecordTypeInfosByName();
            Id Claimback = qutRecTypeId.get('Claimback Quotation').getRecordTypeId();
            List<Quote> QList = new List<Quote>();
            for(integer i = 0; i < 10 ; i++ ) {
                Quote q = new Quote(
                    Name= 'TestQuote',
                    OpportunityId = opp.id, 
                    RecordTypeId = Claimback,
                    Status = 'Draft', 
                    Expiration_Date__c = Date.today().addDays(60)
                );
                QList.add(q);
            }
    
            insert QList;
        }
        Test.stopTest();


        List<Quote> qy =[SELECT Id,Approver_1__c,Approver_2__c,Approver_3__c FROM Quote];
        System.assertEquals(qy[0].Approver_1__c,usr3.Approver_1__c); // Asserting 
        System.assertEquals(qy[0].Approver_2__c,usr3.Approver_2__c); // Asserting 
        System.assertEquals(qy[0].Approver_3__c,usr3.Approver_3__c); // Asserting 
    }
}