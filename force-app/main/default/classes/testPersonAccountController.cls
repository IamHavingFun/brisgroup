/**
 * @author 
 * @since 
 */
@IsTest(SeeAllData = true)
private class testPersonAccountController {

     @IsTest
     static void testLeadPersonAccount() {          
          //add additional filters as appropriate
          // Instantiate a new controller with all parameters in the page 
          Account testAccount2 = new Account(
               Data_Source__pc = 'Other',
               Data_Source_Other__pc = 'Other'
          );    
          Apexpages.StandardController stdController2 = new Apexpages.StandardController(testAccount2); 
          PersonAccountController controller2 = new PersonAccountController(stdController2); 
          
          RecordType recType = [SELECT Id FROM recordType WHERE ispersontype = TRUE AND sobjectType = 'account' AND Name = 'Lead Person Account' LIMIT 1];
          //Insert your Test Data
          controller2.salutation = 'Mr';
          controller2.fname = 'Bob';
          controller2.lname = 'Hoskins';
          controller2.mphone = '07969258019';
          controller2.hphone = '01827464415';
          testAccount2.RecordTypeId = recType.Id;
          PageReference pr = controller2.save();
          testAccount2 = [SELECT Id FROM Account WHERE LastName = 'Hoskins'];
          System.assertEquals('/' + testAccount2.Id, pr.getUrl(), 'URL Malformed');
     }

     @IsTest
     static void testPersonAccount(){
          //replace with your VF page name
          PageReference pageRef3 = Page.Account_VF_New;
          Test.setCurrentPage(pageRef3);
          //add additional filters as appropriate
    
          // Instantiate a new controller with all parameters in the page 
          Account testAccount3 = new Account(
              Data_Source__c = 'Other'
           );  
          Apexpages.StandardController stdController3 = new Apexpages.StandardController(testAccount3); 
          PersonAccountController controller3 = new PersonAccountController(stdController3);          
          controller3.salutation = 'Mr';
          controller3.fname = 'Bob';
          controller3.lname = 'Hoskins';
          controller3.mphone = '07969258019';
          controller3.hphone = '01827464415';

          RecordType recType = [SELECT Id FROM recordType WHERE ispersontype = TRUE AND sobjectType = 'account' AND Name = 'Person Account' LIMIT 1];
          //Insert your Test Data
          testAccount3.RecordTypeId = recType.Id;
          PageReference pageReference = controller3.save();
          testAccount3 = [SELECT Id FROM Account WHERE LastName = 'Hoskins'];
          System.assertEquals('/' + testAccount3.Id, pageReference.getUrl(), 'URL Malformed');
     }

     @IsTest
     static void testIndirectAccount() {
          PageReference pageRef5 = Page.Account_VF_New; //replace with your VF page name
          Test.setCurrentPage(pageRef5);
          //add additional filters as appropriate

          // Instantiate a new controller with all parameters in the page 
          Account testAccount5 = new Account(
               Name = 'IndirectAccount',
               Data_Source__c = 'Other'
          );  
          Apexpages.StandardController stdController5 = new Apexpages.StandardController(testAccount5); 
          PersonAccountController controller5 = new PersonAccountController(stdController5);

          RecordType recType = [SELECT Id FROM RecordType WHERE IsPersonType = FALSE AND SObjectType = 'account' AND Name = 'Indirect' LIMIT 1];
          //Insert your Test Data
          testAccount5.RecordTypeId = recType.Id;
          PageReference pageReference = controller5.save(); 
          testAccount5 = [SELECT Id FROM Account WHERE Name = 'IndirectAccount'];
          System.assertEquals('/' + testAccount5.Id, pageReference.getUrl(), 'URL Malformed');
     }

     @IsTest
     static void testError() {
          Account testAccount9 = new Account(
               Data_Source__c = 'Other'
           );
           PageReference pageRefError = Page.Account_VF_New; 
           Test.setCurrentPage(pageRefError);
           ApexPages.StandardController stdController9 = new ApexPages.StandardController(testAccount9); 
           PersonAccountController controller9 = new PersonAccountController(stdController9);    
           PageReference pr = controller9.save();
           System.assert(pr == null, 'Page Reference must be null');

     }
}