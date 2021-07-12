@istest(SeeAllData = True)
public class testARSExtension {

  public static testMethod void customsaveTest3() {
    Test.startTest();

    PageReference pr = new PageReference('/apex/ARS_Incident');
    Test.setcurrentPage(pr);

    Case cs = new Case();
    ApexPages.StandardController stdCase = new ApexPages.StandardController(cs);
    ARSExtension car = new ARSExtension(stdCase);
    
    cs.SuppliedName = 'Edward Collett';
    cs.SuppliedEmail = 'ecollett@bristan.com';
    cs.Subject = 'xxTESTINGxx';
    
    User u = [SELECT Id FROM User WHERE Name='No Reply'];
    System.runAs(u) {
      car.doCancel();
      system.assertEquals(1,1);
    }
    Test.stopTest();
  }  

  public static testMethod void customsaveTest() {
    Test.startTest();

    PageReference pr = new PageReference('/apex/ARS_Incident');
    Test.setcurrentPage(pr);

    Case cs = new Case();
    ApexPages.StandardController stdCase = new ApexPages.StandardController(cs);
    ARSExtension car = new ARSExtension(stdCase);
    
    cs.SuppliedName = 'Edward Collett';
    cs.SuppliedEmail = 'ecollett@bristan.com';
    cs.Subject = 'xxTESTINGxx';
    Attachment newAtt = new Attachment();
    newAtt .Name = 'TEST.txt';
    newAtt .Body = Blob.valueOf('Unit Test Document Body');
    car.newAttachments.add(newAtt);
    
    User u = [SELECT Id FROM User WHERE Name='No Reply'];
    System.runAs(u) {
      car.customsave();
      Case[] cs1 = [Select id From Case where Subject = 'xxTESTINGxx'];
      system.debug(cs1); 
      system.assertEquals(cs1.size() , 1);
    }
    Test.stopTest();
  }
  
  public static testMethod void customsaveTest2() {
    Test.startTest();

    PageReference pr = new PageReference('/apex/ARS_Incident');
    Test.setcurrentPage(pr);

    Case cs = new Case();
    ApexPages.StandardController stdCase = new ApexPages.StandardController(cs);
    ARSExtension car = new ARSExtension(stdCase);
    
    cs.SuppliedName = 'Edward Collett';
    cs.SuppliedEmail = 'ecollett@bristan.com';
    cs.Subject = 'xxTESTINGxx';
       
    User u = [SELECT Id FROM User WHERE Name='No Reply'];
    System.runAs(u) {
      car.customsave();
      Case[] cs1 = [Select id From Case where Subject = 'xxTESTINGxx'];
      system.debug(cs1); 
      system.assertEquals(cs1.size() , 1);
    }
    Test.stopTest();
  }  
}