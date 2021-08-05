/**
 * @author 
 * @since 
 */
@IsTest(SeeAllData = true)
private class Lock_Order_On_CancelTest {

    @IsTest
    static void myUnitTest() {
        // TO DO: implement unit test
        ProcessInstance pi;
        Profile serviceuser = [SELECT Name, Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1 ]; 
        system.debug('#### serviceuser =' + serviceuser);
  
        User thisuser = [SELECT id, name FROM User WHERE IsActive = TRUE AND Profileid = :serviceuser.id LIMIT 1];

        System.runAs(thisuser) {
            Account newacc = TestDataCreation.CreateAccount('Test');
            Contact ct = TestDataCreation.createContact('Paul', 'Harvie', newacc.id);
            Case cs = TestDataCreation.CreateCase('Test Case', newacc.id, ct.id);
            Delivery_Term__c newdt = TestDataCreation.CreateDeliveryTermPST(); 
            Order__c ord = new Order__c(Case_Account__c = newacc.id, Case__c = cs.id, Delivery_Term__c = newdt.id);
            insert ord;
            system.debug('#### ord =' + ord);
          
            ord.Locked__c = true;
            ord.Status__c = 'Cancelled';
         
            update ord;

            pi = [SELECT Status FROM ProcessInstance WHERE TargetObjectId = :ord.Id];            
        }
        System.assertEquals('Approved', pi.Status, 'Approval Process Failed');
    }
    
}