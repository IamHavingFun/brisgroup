/* This is test class for the trigger which updates the Opportunity stage when a quote gets approved.
Author-Hema Kulkarni
Email-hkulkarni@innoveer.com*/

@isTest(SeeAllData = True)
private class testOpptyUpdateQuote{

    static testmethod void testOpptyUpdateQuote1()
    {

        TestUtilityClass.setUpData();

        Test.startTest();

        list<Quote> qu=new list<Quote>();
        Opportunity opty1 = TestUtilityClass.opp; // Creating opportunity record

        schema.describesobjectresult resultQuote = Quote.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> qutRecTypeId = resultQuote.getrecordtypeinfosbyname();
        Id recordType = qutRecTypeId.get('Special Price').getrecordtypeid();

        //creating test Quote
       for(Integer x=0; x<200;x++)//testing quotes with bulk update
       {
         Quote q=new Quote();
         //Bulk Testing
         q.Status='Draft';
         q.Name='Test Quote';
         q.OpportunityId=opty1.Id;
         q.Expiration_Date__c = date.today().addDays(60);
         q.RecordTypeId = recordType;
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

        Test.stopTest();

       System.assertEquals('Order - Won', opty1.StageName );
   }
}