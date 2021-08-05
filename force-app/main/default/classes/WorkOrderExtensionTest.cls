/**
 * @author 
 * @since 
 */
@IsTest
public class WorkOrderExtensionTest {

    @IsTest
    private static void TestWOController(){    
        // Create Case
        Case cs = TestUtilityDataFactory.createCase('Bristan_General');
        insert cs;
    
        // Create Account
        Account acc = TestUtilityDataFactory.createBusinessAccount('Indirect'); 
        acc.Name = 'Face Huggers';
        acc.email__c = 'facehugger@alien.com';
        insert acc;
        
        // Create Contact
        Contact con = new Contact(FirstName='Face',LastName='Hugger',email='facehugger@alien.com',MobilePhone='07485285285',AccountId=acc.Id);
        insert con;
        
        // Set test page passing initial parameters.
        PageReference vf = Page.WorkOrder_VF;
        vf.getParameters().put('accId', acc.Id);
        vf.getParameters().put('conId', con.Id);
        vf.getParameters().put('caseId', cs.Id);
        Test.setCurrentPage(vf);
 
        // Instantiate the standard controller
        WorkOrder wo = new WorkOrder();
        Apexpages.StandardController sc = new Apexpages.StandardController(wo );
 
        // Instantiate the extension
        WorkOrderExtension ext = new WorkOrderExtension(sc);

        wo = (WorkOrder) ext.sc.getRecord();
        System.assertEquals(acc.Id, wo.AccountId, 'Account not set on Work Order record');
        System.assertEquals(con.Id, wo.ContactId, 'Contact not set on Work Order record');
        System.assertEquals(cs.Id, wo.CaseId, 'Case not set on Work Order record');
    }
}