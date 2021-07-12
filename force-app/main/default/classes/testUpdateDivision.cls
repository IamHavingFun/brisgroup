/**This is test class for the trigger 'UpdateDivisionField'
*  Author-Hema Kulkarni
*  Since-May 2012
*  Email-hkulkarni@innoveer.com
**/
@isTest
private class testUpdateDivision{

    static testMethod void myUnitTest() {
        
        // TO DO: implement unit test
        
        list<user> userList=new list<user>();//List of users
        
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
       
        //Creating three users for testing
         User usr = new User(Alias = 'stdu', Email = 'standarduser@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
                            'Test', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
                            'America/Los_Angeles', UserName = 'stndusr@test.com',Division__c='');
                            
        User usr1 = new User(Alias = 'stdu1', Email = 'standarduser1@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
                            'Test1', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
                            'America/Los_Angeles', UserName = 'stndusr1@test.com',Division__c='Trade');
        
        User usr2 = new User(Alias = 'stdu2', Email = 'standarduser2@testuser.com', EmailEncodingKey = 'UTF-8', LastName = 
                            'Test2', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', ProfileId = p.Id, TimeZoneSidKey =
                            'America/Los_Angeles', UserName = 'stndusr2@test.com',Division__c='Heritage'); 
        //Adding users to list of users                 
        userList.add(usr);
        userList.add(usr1);
        userList.add(usr2); 
        
        INSERT   userList; //Inserted users
                
        list<Lead> leadinsert = new list<Lead>(); //List of leads
        
        for(integer i = 0 ; i<200 ; i++) //For loop for creating leads to bulk check where 'Division' field on lead is not empty
        { 
            Lead l = new Lead(LastName = 'Wills',Company = 'AMRO',Status = 'Open',OwnerId = usr.id, Division__c = '', LeadSource='a');
            leadinsert.add(l);
        }
        INSERT leadinsert; //Inserted Leads
        
        list<Lead> leadlist=[SELECT Id,OwnerId,LastName, Division__c 
                             FROM Lead 
                             WHERE LastName =: 'Wills']; //Retrieving list of leads with last name 'Wills'
                             
        System.assertEquals(null,leadList[0].Division__c);// Asserting 'Division' field values
        
        list<Lead> leadinsert1 = new list<Lead>(); //List of leads
        for(integer i = 0 ; i<200 ; i++)  //For loop for creating leads to bulk check where  'Division' field on lead is empty
        {
            Lead l1 = new Lead(LastName = 'James',Company = 'ABN',Status = 'Open',OwnerId =usr2.id, Division__c = '', LeadSource='a');
            leadinsert1.add(l1);
        }
        INSERT leadinsert1; //Inserted Leads
        
        list<Lead> leadlist1=[SELECT Id,OwnerId,LastName, Division__c 
                              FROM Lead 
                              WHERE LastName =: 'James'];
        System.assertEquals(usr2.Division__c,leadList1[0].Division__c);                      
       // System.assertEquals(leadList1[0].Division__c,usr2.Division__c); // Asserting 'Division' field values
    }
}