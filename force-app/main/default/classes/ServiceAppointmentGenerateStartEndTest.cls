@isTest(SeeAllData=true)
private class ServiceAppointmentGenerateStartEndTest {
  static testMethod void validateRecords() {
    ServiceAppointmentGenerateStartEnd s = new ServiceAppointmentGenerateStartEnd();
 
    Test.startTest();
      s.startPoint();
    Test.stopTest();
  }
}