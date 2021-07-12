/* This is test class for the trigger which updates the Opportunity stage when a quote gets approved.
Author-Hema Kulkarni
Email-hkulkarni@innoveer.com*/

@isTest(SeeAllData = True)
private class testOpptyUpdateQuote{

    static testmethod void testOpptyUpdateQuote1()
    {
        list<Quote> qu=new list<Quote>();
        TestUtilityClass.setUpData();
        Opportunity opty1 = TestUtilityClass.opp; // Creating opportunity record
        
        //creating test Quote
       for(Integer x=0; x<200;x++)//testing quotes with bulk update
       {
         Quote q=new Quote();
         //Bulk Testing
         q.Status='Draft';
         q.Name='Test Quote';
         q.OpportunityId=opty1.Id;
         q.Expiration_Date__c = date.today().addDays(60);
         qu.add(q);
       }
     INSERT qu;//Inserting the quotes
     
       
       for(quote q : qu)
       {
          q.Status='Approved';//Setting the quotes status
         
       }
      UPDATE qu;//Updating Quotes 

       for(quote q : qu)
       {
          q.Status='Won';//Setting the quotes status
         
       }
      UPDATE qu;//Updating Quotes       
       opty1= [SELECT StageName FROM Opportunity  WHERE Id = :opty1.Id];

       System.assertEquals('Order - Won', opty1.StageName );
   }
}