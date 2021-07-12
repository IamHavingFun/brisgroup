@isTest
public class CarrierApprovalTriggerTest {

  public static Carrier_Approval_System__c ca;

  static testMethod void Test1() {
    ca = new Carrier_Approval_System__c();
    RecordType recordTypeCA = [SELECT Id from RecordType WHERE DeveloperName = 'New' LIMIT 1];
    String recCA = recordTypeCA.Id;
    ca.RecordTypeId = recCA;
    ca.Status__c = 'New';
    ca.Service__c = 'Next Day';
    ca.Type__c = 'Personal';
    insert ca;
  }
}