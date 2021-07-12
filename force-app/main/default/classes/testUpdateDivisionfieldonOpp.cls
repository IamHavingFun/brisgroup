/**This is test class for the trigger 'UpdateDivisionfieldonOpp'
*  Author-Amrin Pattekari
*  Since-May 2012
*  Email-apattekari@innoveer.com
*/


@isTest
private class testUpdateDivisionfieldonOpp{

    static testMethod void myUnitTest() {
        
        // TO DO: implement unit test
        
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
        list<Opportunity> oppinsert = new list<Opportunity>(); //List of leads
        
        for(integer i = 0 ; i<200 ; i++) //For loop for creating leads to bulk check where 'Division' field on lead is not empty
        { 
            Opportunity opp = new Opportunity(Name = 'Wills',OwnerId = usr.id, Division__c = ' Heritage',CloseDate=date.today(),StageName = 'Initiating', Postcode__c = '780001', Address_Line_1__c='Buckinghamshire', Customer_Order_Number__c='Test Order', Estimated_Start_Date__c = date.today(), Estimated_Completion__c = date.today().addDays(60));
            oppinsert.add(opp);
        }
        INSERT oppinsert; //Inserted Opportunity
        
        list<Opportunity> opplist=[SELECT Id,OwnerId,Name, Division__c,StageName,CloseDate,Postcode__c,Address_Line_1__c
                             FROM Opportunity 
                             WHERE Name =: 'Wills']; //Retrieving list of opportunities with last name 'Wills'
                             
        System.assertEquals(oppList[0].Division__c,usr.Division__c);// Asserting 'Division' field values
        
        list<Opportunity> oppinsert1 = new list<Opportunity>(); //List of opportunities
        for(integer i = 0 ; i<200 ; i++)  //For loop for creating opportunities to bulk check where  'Division' field on opportunity is empty
        {
            Opportunity opp1 = new Opportunity(Name = 'James', OwnerId =usr2.id, Division__c = '',CloseDate=date.today(),StageName = 'Initiating', Postcode__c = '780001', Address_Line_1__c='Buckinghamshire',Customer_Order_Number__c='Test Order', Estimated_Start_Date__c = date.today(), Estimated_Completion__c = date.today().addDays(60));
            oppinsert1.add(opp1);
        }
        INSERT oppinsert1; //Inserted Opportunities
      
        list<Opportunity> opplist1=[SELECT Id,OwnerId,Name, Division__c 
                              FROM Opportunity 
                              WHERE Name =: 'James'];
        System.assertEquals(oppList1[0]. Division__c,usr2.Division__c); // Asserting 'Division' field values
        
        list<Opportunity> oppinsert2 = new list<Opportunity>(); //List of opportunities
        for(integer i = 0 ; i<200 ; i++)  //For loop for creating opportunities to bulk check where  'Division' field on opportunity is empty
        {
            Opportunity opp2 = new Opportunity(Name = 'Jerry', OwnerId =usr1.id, Division__c = '',CloseDate=date.today(),StageName = 'Initiating', Postcode__c = '780001', Address_Line_1__c='Buckinghamshire',Customer_Order_Number__c='Test Order', Estimated_Start_Date__c = date.today(), Estimated_Completion__c = date.today().addDays(60));
            oppinsert2.add(opp2);
        }
        INSERT oppinsert2; //Inserted Opportunities
        
        list<Opportunity> opplist2=[SELECT Id,OwnerId,Name, Division__c 
                              FROM Opportunity 
                              WHERE Id IN: oppinsert2];
        System.assertEquals(oppList2[0]. Division__c,Null); // Asserting 'Division' field values
        
        list<Opportunity> oppinsert3 = new list<Opportunity>(); //List of opportunities
        for(integer i = 0 ; i<200 ; i++)  //For loop for creating opportunities to bulk check where  'Division' field on opportunity is empty
        {
            Opportunity opp3 = new Opportunity(Name = 'Test'+i , OwnerId =usr3.id, Division__c = 'Retail',CloseDate=date.today(),StageName = 'Initiating', Postcode__c = '780001', Address_Line_1__c='Buckinghamshire',Customer_Order_Number__c='Test Order', Estimated_Start_Date__c = date.today(), Estimated_Completion__c = date.today().addDays(60) );
            oppinsert3.add(opp3);
        }
        INSERT oppinsert3; //Inserted Opportunities
        list<Opportunity> opplist3=[SELECT Id,OwnerId,Name, Division__c ,Approver_1__c,Approver_2__c,Approver_3__c
                              FROM Opportunity 
                              WHERE Id IN: oppinsert3];
        System.assertEquals(oppList3[0].Approver_1__c,usr3.Approver_1__c); // Asserting 
        System.assertEquals(oppList3[0].Approver_2__c,usr3.Approver_2__c); // Asserting 
        System.assertEquals(oppList3[0].Approver_3__c,usr3.Approver_3__c); // Asserting 
    }
}