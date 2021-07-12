@isTest(SeeAllData=true)
public class WorkOrderExtensionTest {

    Private Static testmethod void TestWOController(){    
        // Create Case
        Id csrt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Bristan_General' AND SobjectType = 'Case' LIMIT 1].Id;
        Case cs = new Case(Subject='Test Case',RecordTypeId=csrt);
        insert cs;
    
        // Create Account
        Id accrt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Indirect' AND SobjectType = 'Account' LIMIT 1].Id;
        Account acc = new Account(Name='Face Huggers',email__c='facehugger@alien.com',RecordTypeId=accrt);
        insert acc;        
        
        // Create Contact
        Contact con = new Contact(FirstName='Face',LastName='Hugger',email='facehugger@alien.com',MobilePhone='07485285285',AccountId=acc.Id);
        insert con;
        
        // Set test page passing initial parameters.
        PageReference vf = Page.WorkOrder_VF;
        vf.getParameters().put('accId', acc.Id);
        vf.getParameters().put('conId', con.Id);
        vf.getParameters().put('caseId', cs.Id);
        test.setCurrentPage(vf);
 
        // Instantiate the standard controller
        WorkOrder wo = new WorkOrder();
        Apexpages.StandardController sc = new Apexpages.standardController(wo );
 
        // Instantiate the extension
        WorkOrderExtension ext = new WorkOrderExtension(sc);
    }
}