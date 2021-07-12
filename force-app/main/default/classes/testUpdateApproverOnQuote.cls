/*
 * This class contains the data that is necessary to test OpportunityUpdatePrice and QuoteUpdatePrice classes.
 * Author : Bhushan Adhikari
 * since  : June 2012
 * E-Mail : badhikari@innoveer.com
 */

@isTest
private class testUpdateApproverOnQuote{

    static testMethod void myUnitTest() {
       
        
        list<user> userList=new list<user>();//List of users
        
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
        Opportunity opp = new Opportunity(Name = 'Wills',OwnerId = usr3.id, Division__c = 'Heritage',CloseDate=date.today(),StageName = 'Initiating', Postcode__c = '780001', Address_Line_1__c='Buckinghamshire',Customer_Order_Number__c='Test', Estimated_Start_Date__c = date.today(), Estimated_Completion__c = date.today().addDays(60));
        INSERT opp; //Inserted Opportunity
       
       //Quote Data
        schema.describesobjectresult resultQuote = Quote.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> qutRecTypeId = resultQuote.getrecordtypeinfosbyname();
        Id Claimback = qutRecTypeId.get('Claimback Quotation').getrecordtypeid();
        List<Quote> QList = new List<Quote>();
        for(integer i = 0; i < 10 ; i++ )
        {
            Quote q = new Quote(Name= 'TestQuote',opportunityId = opp.id, RecordTypeId = ClaimBack,Status = 'Draft', Expiration_Date__c = date.today().addDays(60) );
            QList.add(q);
        }
        try{
            insert QList;
         }
        catch(Exception e){
            system.debug(e);
        }
        List<Quote> qy =[SELECT Id,Approver_1__c,Approver_2__c,Approver_3__c FROM Quote WHERE Id IN : QList];
        //System.assertEquals(qy[0].Approver_1__c,usr3.Approver_1__c); // Asserting 
        //System.assertEquals(qy[0].Approver_2__c,usr3.Approver_2__c); // Asserting 
        //System.assertEquals(qy[0].Approver_3__c,usr3.Approver_3__c); // Asserting 
    }
}