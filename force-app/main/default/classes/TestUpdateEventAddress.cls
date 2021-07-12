/*
 * This class contains unit tests for validating the behavior of Apex trigger "updateEventAddress".
 * Author - Bhushan Adhikari
 * Since - May 2012
 * E-mail - badhikari@innoveer.com
 */
@isTest
private class TestUpdateEventAddress {
  //testmethod to check Event address is filled in with realted contact address , if address on that event is not filled.

   static testMethod void testEventAddress() {
        //getting the recordtypeIds       
        schema.describesobjectresult result = Account.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> recTypeId = result.getrecordtypeinfosbyname();
        Id DirectAccountId = recTypeId.get('Direct').getrecordtypeid();
        schema.describesobjectresult result1 = Event.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> recTypeId1 = result1.getrecordtypeinfosbyname();
        Id EvebtRecTypeId = recTypeId1.get('Event').getrecordtypeid();
        
        // Creating test account record
        Account acc = new Account(Name = 'Test Account1',
                    Address_Line_1__c = '7th street Lane',
                    Address_Line_2__c = 'Wing C',
                    Countrynew__c = 'UK',
                    County__c = 'Middlesex',
                    Town__c = 'George Town',
                    PostCode__c = '45613',
                    RecordTypeId = DirectAccountId );
        try{            
            insert acc;
        }
        catch(Exception e){
            system.debug(e);
        }
        
        //Creating test Contact data
        Contact con = new Contact(Salutation = 'Mr.',FirstName = 'Test', LastName = 'Contact1',AccountId = acc.id);
        try{
            insert con;
        }
        catch(Exception e){
            system.debug(e);
        }
        
        //Creating List of 20 events with blank address and having contact
        List<Event> events =  new List<Event>();
        for(Integer i=0; i<20;i++){
            Event e = new Event(whoId = con.id, subject = 'Call', RecordTypeId = EvebtRecTypeId, StartDateTime = date.today(), EndDateTime = date.today());
            events.add(e);
        }
        
        Test.startTest();
        
        //DML Operation that causes trigger to execute.
        insert events;
       
        Test.stopTest();
        Contact c = [SELECT Id, 
                        Name, 
                        Account_Address_Line_1__c,
                        Account_Address_Line_2__c,
                        Account_Country__c,
                        Account_County__c,
                        Account_Town__c,
                        Account_PostCode__c 
                        FROM CONTACT WHERE Id =: con.id];
        
        //As above events were inserted with blank addresses , iterating through list of list of same events inserted above and asserting that the event address and its related contact address is the same
        for(event evt : [SELECT id,Address_Line_1__c,Address_Line_2__c,Country__c,County_State__c,Postcode__c,Town__c,WhoId FROM Event WHERE id IN:events]){
            system.assertEquals(evt.Address_Line_1__c, c.Account_Address_Line_1__c);
            system.assertEquals(evt.Address_Line_2__c, c.Account_Address_Line_2__c);
            system.assertEquals(evt.Town__c, c.Account_Town__c);
            system.assertEquals(evt.Country__c, c.Account_Country__c);
            system.assertEquals(evt.County_State__c, c.Account_County__c);
            system.assertEquals(evt.PostCode__c, c.Account_PostCode__c);
        }
    }//End of test method
    
    
}//End of Class