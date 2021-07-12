@isTest
private class testOpportunityApprovalHistoryController
{

    static testmethod void testOpportunityApprovalHistoryController1()
    {
        list<ProcessInstanceHistory> qu=new list<ProcessInstanceHistory>();
        Opportunity  opty1 = new Opportunity();
        opty1.Name='TestOpty1';
        opty1.Type='UK - UNITED KINGDOM';
        opty1.CloseDate=system.today();
        opty1.StageName='Closed Won';
        opty1.Amount=1123;
        opty1.Customer_Order_Number__c='Test';    
        opty1.Estimated_Start_Date__c = date.today();
        opty1.Estimated_Completion__c = date.today().addDays(60);    
        insert opty1;
        
       
//       for(Integer x=0; x<5;x++)
//       {
//         Approval q=new Approval();
//         //Bulk Testing
//         q.parentId=opty1.id;
//         q.status='Approved';
//         q.OwnerId=userinfo.getUserID();
         
         
//       }
     //  insert qu;
     
       
     
       opty1= [SELECT StageName FROM Opportunity  WHERE Id = :opty1.Id];

       System.assertEquals('Closed Won', opty1.StageName );
   
   OpportunityApprovalHistoryController a1= new OpportunityApprovalHistoryController();
   a1.OpportunityID=opty1.id;
   a1.getApprovalSteps();
   }
   
   
}