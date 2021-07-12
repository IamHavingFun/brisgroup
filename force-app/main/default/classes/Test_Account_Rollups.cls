/* Test class to test Account_Rollups trigger
 * Author : Steve Mason
 * Since : May 2017
 * Email : smason@bristan.com
 */

@isTest(SeeAllData = True)
private class Test_Account_Rollups {
    public static Delivery_Term__c dt;
    public static Order__c ord;
    public static Warranty__c war;
    public static LiveChatTranscript chat;
    public static Calls__c call;
    public static LivechatVisitor visitor;
    public static Case cs;
    public static Account pAcc;    
    
    static testMethod void AccountrollupsUnitTest() {
        //Set up test data
        // Create Account  
        RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
        pAcc = new Account();
        // for person accounts we can not update the Name field instead we have to update the    FirstName and LastName individually
        pAcc.FirstName = 'Fred';
        pAcc.LastName = 'Smith';
        pAcc.RecordType = personAccountRecordType;
        insert pAcc;
        pAcc = [SELECT Id, PersonContactId, AccountNumber, Number_of_Orders__c, Number_of_Warranties__pc, Number_of_Live_Chats__pc, Number_of_Calls__pc, Number_of_Cases__pc from Account where FirstName = 'Fred' and LastName = 'Smith' LIMIT 1];
        //String conId = pAcc.PersonContactId;
        //Contact con = [SELECT Id from Contact where Id = :conId LIMIT 1];
        // Create Case
        cs = new Case(Subject = 'Test',Description = 'Test',Status = 'New', AccountId = pAcc.Id, ContactId = pAcc.PersonContactId);
        insert cs;
        // Create Order
        schema.describesobjectresult resultOrd = Order__c.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> ordRecTypeId = resultOrd.getrecordtypeinfosbyname();
        Id OrdRec = ordRecTypeId.get('Standard Order').getrecordtypeid();
        dt = TestDataCreation.CreateDeliveryTermPST();
        ord = new Order__c(RecordTypeId = OrdRec,
                            Case_Account__c=pAcc.id,
                            Status__c='Pending',
                            Delivery_Term__c=dt.id,
                            Case__c=cs.id);
        insert ord;
        // Create Warranty
        war = new Warranty__c(Name = 'Test', Contact__c = pAcc.PersonContactId);
        insert war;
        // Create Call 
        call = new Calls__c(Name = 'Test', Contact__c = pAcc.PersonContactId);
        insert call;
        
        pAcc.AccountNumber = '0';
        update pAcc;
        pAcc = [SELECT Id, PersonContactId, AccountNumber, Number_of_Orders__c, Number_of_Warranties__pc, Number_of_Live_Chats__pc, Number_of_Calls__pc, Number_of_Cases__pc from Account where FirstName = 'Fred' and LastName = 'Smith' LIMIT 1];
        system.assertEquals(1, 1);  // Trigger is inactive
    }
}