// This trigger populates the 'Number of Orders' field on accounts,
// Custom roll up field for reporting

trigger Account_Rollups on Account (before insert, before update) { 
      for (Account o : Trigger.new)
      {    
          String accId = o.Id;
          String conId = o.PersonContactId;
          
          if(!Trigger.isInsert)
          {
              if(o.IsPersonAccount)
              {
                  integer count5 = database.countQuery('SELECT count() from Order__c where Case_Account__c = :accId');
                  o.Number_of_Orders__c = count5;
                  integer count = database.countQuery('SELECT count() from Warranty__c where Contact__c = :conId');
                  o.Number_of_Warranties__pc = count;
                  integer count2 = database.countQuery('SELECT count() from Case where ContactId = :conId');
                  o.Number_of_Cases__pc = count2;
                  integer count3 = database.countQuery('SELECT count() from Calls__c where Contact__c = :conId');
                  o.Number_of_Calls__pc = count3;
                  integer count4 = database.countQuery('SELECT count() from LiveChatTranscript where ContactId = :conId');
                  o.Number_of_Live_Chats__pc = count4;
              }
          }
      }
}