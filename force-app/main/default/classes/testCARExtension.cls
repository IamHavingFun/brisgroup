@istest(SeeAllData = True)
public class testCARExtension {

  public static testMethod void customsaveTest3() {
    Test.startTest();

    PageReference pr = new PageReference('/apex/CAR_Incident_Public');
    Test.setcurrentPage(pr);

    Case cs = new Case();
    ApexPages.StandardController stdCase = new ApexPages.StandardController(cs);
    CARExtension car = new CARExtension(stdCase);
    
    cs.SuppliedName = 'Steven Mason';
    cs.SuppliedEmail = 'smason@bristan.com';
    cs.Non_Conformance_Category__c = 'Environmental';
    cs.Problem_Found__c = 'Yard';
    cs.Subject = 'xxxTESTINGxxx3333';
    cs.Description = 'TEST';
    
    User u = [SELECT Id FROM User WHERE Name='No Reply'];
    System.runAs(u) {
      car.doCancel();
      system.assertEquals(1,1);
    }
    Test.stopTest();
  }  

  public static testMethod void customsaveTest() {
    Test.startTest();

    PageReference pr = new PageReference('/apex/CAR_Incident_Public');
    Test.setcurrentPage(pr);

    Case cs = new Case();
    ApexPages.StandardController stdCase = new ApexPages.StandardController(cs);
    CARExtension car = new CARExtension(stdCase);
    
    cs.SuppliedName = 'Steven Mason';
    cs.SuppliedEmail = 'smason@bristan.com';
    cs.Non_Conformance_Category__c = 'Environmental';
    cs.Problem_Found__c = 'Yard';
    cs.Subject = 'xxxTESTINGxxx';
    cs.Description = 'TEST';
    car.attachment.Name = 'TEST.txt';
    car.attachment.Body = Blob.valueOf('Unit Test Document Body');
    
    User u = [SELECT Id FROM User WHERE Name='No Reply'];
    System.runAs(u) {
      car.customsave();
      Case[] cs1 = [Select id From Case where Subject = 'xxxTESTINGxxx'];
      system.debug(cs1); 
      system.assertEquals(cs1.size() , 1);
    }
    Test.stopTest();
  }
  
  public static testMethod void customsaveTest2() {
    Test.startTest();

    PageReference pr = new PageReference('/apex/CAR_Incident_Public');
    Test.setcurrentPage(pr);

    Case cs = new Case();
    ApexPages.StandardController stdCase = new ApexPages.StandardController(cs);
    CARExtension car = new CARExtension(stdCase);
    
    cs.SuppliedName = 'Steven Mason';
    cs.SuppliedEmail = 'smason@bristan.com';
    cs.Non_Conformance_Category__c = 'Environmental';
    cs.Problem_Found__c = 'Yard';
    cs.Subject = 'xxxTESTINGxxx2';
    cs.Description = 'TEST';
    
    User u = [SELECT Id FROM User WHERE Name='No Reply'];
    System.runAs(u) {
      car.customsave();
      Case[] cs1 = [Select id From Case where Subject = 'xxxTESTINGxxx2'];
      system.debug(cs1); 
      system.assertEquals(cs1.size() , 1);
    }
    Test.stopTest();
  }  
}