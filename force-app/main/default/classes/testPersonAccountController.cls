@isTest(SeeAllData = true)
private class testPersonAccountController
{
    static testMethod void testContactSearch()
    {
      Account testAccount9 = new Account();
      PageReference pageRefError = Page.Account_VF_New; 
      Test.setCurrentPage(pageRefError);
      Apexpages.StandardController stdController9 = new Apexpages.StandardController(testAccount9); 
      PersonAccountController controller9 = new PersonAccountController(stdController9);    
      controller9.save();
    
      PageReference pageRef = Page.Account_VF_New; //replace with your VF page name
      Test.setCurrentPage(pageRef);
      //Add test data. For example, create a set of test Opportunities

      RecordType recType;      
      Account testAccount4 = new Account();  
      Apexpages.StandardController stdController4 = new Apexpages.StandardController(testAccount4); 
      PersonAccountController controller4 = new PersonAccountController(stdController4);          
      
      recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' limit 1];
     //Insert your Test Data
//     Account testAccount = new Account();
     testAccount4.RecordTypeId = RecType.Id;
     controller4.save();
      
      // Add parameters to page URL  
      pageRef = Page.Account_VF_New; //replace with your VF page name
      Test.setCurrentPage(pageRef);
      ApexPages.currentPage().getParameters().put('salutation', 'Mr');
      ApexPages.currentPage().getParameters().put('fname', 'Bob');
      ApexPages.currentPage().getParameters().put('lname', 'Hoskins');      
      ApexPages.currentPage().getParameters().put('mphone', '07969258019');     
      ApexPages.currentPage().getParameters().put('hphone', '01827464415');  
             
      //add additional filters as appropriate

      // Instantiate a new controller with all parameters in the page 
       Account testAccount = new Account();    
      Apexpages.StandardController stdController = new Apexpages.StandardController(testAccount); 
      PersonAccountController controller = new PersonAccountController(stdController);
      
     recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' limit 1];
     //Insert your Test Data
//     Account testAccount = new Account();
     testAccount.FirstName = ApexPages.currentPage().getParameters().get('fname');
     testAccount.LastName = ApexPages.currentPage().getParameters().get('lname');
     testAccount.Salutation = ApexPages.currentPage().getParameters().get('salutation'); 
     testAccount.PersonMobilePhone = ApexPages.currentPage().getParameters().get('mphone'); 
     testAccount.Mobile_2__c = ApexPages.currentPage().getParameters().get('mphone2'); 
     testAccount.PersonHomePhone = ApexPages.currentPage().getParameters().get('hphone'); 
     testAccount.RecordTypeId = RecType.Id;
     controller.save();     
//     Account test1 = controller.GetAccount();
     
      PageReference pageRef2 = Page.Account_VF_New; //replace with your VF page name
      Test.setCurrentPage(pageRef2);
      ApexPages.currentPage().getParameters().put('salutation', 'Mr');
      ApexPages.currentPage().getParameters().put('fname', 'Bob');
      ApexPages.currentPage().getParameters().put('lname', 'Hoskins');      
      ApexPages.currentPage().getParameters().put('PersonMobilePhone', '07969258019');     
      ApexPages.currentPage().getParameters().put('PersonHomePhone', '01827464415');  
      ApexPages.currentPage().getParameters().put('mphone', '');     
      ApexPages.currentPage().getParameters().put('hphone', '');  
        
      //add additional filters as appropriate

      // Instantiate a new controller with all parameters in the page 
       Account testAccount2 = new Account();    
       Apexpages.StandardController stdController2 = new Apexpages.StandardController(testAccount2); 
      PersonAccountController controller2 = new PersonAccountController(stdController2); 
      
     recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' limit 1];
     //Insert your Test Data
//     Account testAccount = new Account();
     testAccount2.FirstName = ApexPages.currentPage().getParameters().get('fname');
     testAccount2.LastName = ApexPages.currentPage().getParameters().get('lname');
     testAccount2.Salutation = ApexPages.currentPage().getParameters().get('salutation'); 
     testAccount2.RecordTypeId = RecType.Id;
     controller2.save();     
//     Account test2 = controller2.GetAccount();
     

     PageReference pageRef3 = Page.Account_VF_New; //replace with your VF page name
      Test.setCurrentPage(pageRef3);
      //add additional filters as appropriate

      // Instantiate a new controller with all parameters in the page 
       Account testAccount3 = new Account();  
       Apexpages.StandardController stdController3 = new Apexpages.StandardController(testAccount3); 
      PersonAccountController controller3 = new PersonAccountController(stdController3);          
      
      recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=false and sobjectType='account' and name='Indirect' limit 1];
     //Insert your Test Data
//     Account testAccount = new Account();
     testAccount3.Name = 'Test';
     testAccount3.RecordTypeId = RecType.Id;
     controller3.save();     
//     Account test3 = controller3.GetAccount();

    PageReference pageRef5 = Page.Account_VF_New; //replace with your VF page name
      Test.setCurrentPage(pageRef5);
      //add additional filters as appropriate

      // Instantiate a new controller with all parameters in the page 
       Account testAccount5 = new Account();  
       Apexpages.StandardController stdController5 = new Apexpages.StandardController(testAccount5); 
      PersonAccountController controller5 = new PersonAccountController(stdController5);          
      
      recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=false and sobjectType='account' and name='Indirect' limit 1];
     //Insert your Test Data
//     Account testAccount = new Account();
     testAccount5.RecordTypeId = RecType.Id;
     controller5.save();     

    }
}