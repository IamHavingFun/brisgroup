@isTest(SeeAllData=true)
private class serviceReportSendEmailTest {

  static testMethod void CheckValidRecord() {
    // Create Account
    Id accrt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Indirect' AND SobjectType = 'Account' LIMIT 1].Id;
    Account acc = new Account(Name='Test Account',RecordTypeId=accrt);
    insert acc;
    // Create Contact
    Contact con = new Contact(FirstName='Face',LastName='Hugger',email='facehugger@alien.com',MobilePhone='07485285285');
    insert con;
    // Create Case
    Id csrt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Bristan_General' AND SobjectType = 'Case' LIMIT 1].Id;
    Case cs = new Case(Subject='Test Case',RecordTypeId=csrt,AccountId=acc.Id,ContactId=con.Id);
    insert cs;
    // Create Work Order
    WorkType wt = new WorkType(CurrencyIsoCode='GBP',DurationType='Minutes',EstimatedDuration=35,FSL__Due_Date_Offset__c=4320,Name='Standard');
    insert wt;
    WorkOrder wo = new WorkOrder(CaseId=cs.Id,WorkTypeId=wt.Id,Job_Postcode__c='B79 8JZ');
    insert wo;
    // Create Service Appointment
    Id sart = [SELECT Id FROM RecordType WHERE DeveloperName = 'Standard' AND SobjectType = 'ServiceAppointment' LIMIT 1].Id;
    Date d = System.today();
    DateTime dts = datetime.newInstance(d, Time.newInstance(08,00,00,00));
    DateTime dte = dts.addHours(1);
    ServiceAppointment sa = new ServiceAppointment(ParentRecordId=wo.Id,Status='None',ContactId=con.Id,EarliestStartTime=dts,SchedStartTime=dte,DueDate=dts,SchedEndTime=dte,Email_Service_Report__c=true);
    insert sa;
    // Create content version
    ContentVersion contentVersion = new ContentVersion(
      Title = 'Penguins',
      PathOnClient = 'Penguins.jpg',
      VersionData = Blob.valueOf('Test Content'),
      IsMajorVersion = true
    );
    insert contentVersion;   
    List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument where Title = 'Penguins'];
    //create ContentDocumentLink  record
    ContentDocumentLink cdl = New ContentDocumentLink();
    cdl.LinkedEntityId = sa.id;
    cdl.ContentDocumentId = documents[0].Id;
    cdl.shareType = 'V';
    insert cdl;
    // Create service report
    ServiceReport sr = new ServiceReport();
    //sr.ContentVersionDocumentId = documents[0].Id;
    sr.DocumentBody = Blob.valueOf('Test Content') ;
    sr.DocumentContentType ='application/pdf';
    sr.DocumentName='Test';
    sr.ParentId = sa.Id;
    insert sr;
  }
  
}