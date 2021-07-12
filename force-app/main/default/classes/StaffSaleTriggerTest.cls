@isTest
public class StaffSaleTriggerTest {

  public static Staff_Sale__c ss;

  static testMethod void Test1() {
    ss = new Staff_Sale__c();
    RecordType recordTypeSS = [SELECT Id from RecordType WHERE DeveloperName = 'Staff_Sales' LIMIT 1];
    String recSS = recordTypeSS.Id;
    ss.RecordTypeId = recSS;
    ss.Status__c = 'New';
    ss.Division__c = 'Bristan';
    ss.Sales_Type__c = 'Staff Sales';
    insert ss;
  }
}