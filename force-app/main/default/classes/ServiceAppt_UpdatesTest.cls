@isTest(SeeAllData=true)
private class ServiceAppt_UpdatesTest {

  static testMethod void CheckValidRecord() {
    // Create Case
    Id csrt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Bristan_General' AND SobjectType = 'Case' LIMIT 1].Id;
    Case cs = new Case(Subject='Test Case',RecordTypeId=csrt);
    insert cs;
    // Create Work Order
    WorkType wt = new WorkType(CurrencyIsoCode='GBP',DurationType='Minutes',EstimatedDuration=35,FSL__Due_Date_Offset__c=4320,Name='Standard');
    insert wt;
    WorkOrder wo = new WorkOrder(CaseId=cs.Id,WorkTypeId=wt.Id,Job_Postcode__c='B79 8JZ');
    insert wo;
    // Create Contact
    Contact con = new Contact(FirstName='Face',LastName='Hugger',email='facehugger@alien.com',MobilePhone='07485285285');
    insert con;
    // Create Service Appointment
    Id sart = [SELECT Id FROM RecordType WHERE DeveloperName = 'Standard' AND SobjectType = 'ServiceAppointment' LIMIT 1].Id;
    Date d = System.today();
    DateTime dts = datetime.newInstance(d, Time.newInstance(08,00,00,00));
    DateTime dte = dts.addHours(1);
    ServiceAppointment sa = new ServiceAppointment(ParentRecordId=wo.Id,Status='None',ContactId=con.Id,EarliestStartTime=dts,SchedStartTime=dte,DueDate=dts,SchedEndTime=dte);
    insert sa;
    // Fetch updated records
    ServiceAppointment sanew = [select Id, Contact_Email__c, Contact_Mobile__c, Contact_First_Name__c, Division__c, Case_Subject__c, Case_Number__c from ServiceAppointment where Id = :sa.Id LIMIT 1];
    Case csnew = [select Id, CaseNumber from Case where Id = :cs.Id LIMIT 1];
    // Check values
    System.assertEquals('facehugger@alien.com', sanew.Contact_Email__c);
    System.assertEquals('07485285285', sanew.Contact_Mobile__c);
    System.assertEquals('Face', sanew.Contact_First_Name__c);        
    System.assertEquals('Bristan', sanew.Division__c);        
    System.assertEquals('Test Case', sanew.Case_Subject__c);        
    System.assertEquals(csnew.CaseNumber, sanew.Case_Number__c);                    
  }
  
  static testMethod void CheckValidRecordNoCase() {
    // Create Work Order
    WorkType wt = new WorkType(CurrencyIsoCode='GBP',DurationType='Minutes',EstimatedDuration=35,FSL__Due_Date_Offset__c=4320,Name='Standard');
    insert wt;
    WorkOrder wo = new WorkOrder(WorkTypeId=wt.Id,Job_Postcode__c='B79 8JZ');
    insert wo;
    // Create Contact
    Contact con = new Contact(FirstName='Face',LastName='Hugger',email='facehugger@alien.com',MobilePhone='07485285285');
    insert con;
    // Create Service Appointment
    Id sart = [SELECT Id FROM RecordType WHERE DeveloperName = 'Standard' AND SobjectType = 'ServiceAppointment' LIMIT 1].Id;
    Date d = System.today();
    DateTime dts = datetime.newInstance(d, Time.newInstance(08,00,00,00));
    DateTime dte = dts.addHours(1);
    ServiceAppointment sa = new ServiceAppointment(ParentRecordId=wo.Id,Status='None',ContactId=con.Id,EarliestStartTime=dts,SchedStartTime=dte,DueDate=dts,SchedEndTime=dte);
    insert sa;
    // Fetch updated records
    ServiceAppointment sanew = [select Id, Contact_Email__c, Contact_Mobile__c, Contact_First_Name__c, Division__c, Case_Subject__c, Case_Number__c from ServiceAppointment where Id = :sa.Id LIMIT 1];
    // Check values
    System.assertEquals('facehugger@alien.com', sanew.Contact_Email__c);
    System.assertEquals('07485285285', sanew.Contact_Mobile__c);
    System.assertEquals('Face', sanew.Contact_First_Name__c);        
    System.assertEquals(null, sanew.Division__c);        
    System.assertEquals(null, sanew.Case_Subject__c);        
    System.assertEquals(null, sanew.Case_Number__c);                    
  }  

}