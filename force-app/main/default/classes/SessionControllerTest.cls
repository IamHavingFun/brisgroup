/* Test class to test SessionController class
 * Author : Steve Mason
 * Since : Jun 2021
 * Email : smason@bristan.com
 */
@IsTest(SeeAllData=true)
private class SessionControllerTest {

    static testMethod void SessionControllerUnitTest() {
        //Set up test data  
        TestUtilityClass.setUpData();
        //Getting order information
        Order__c ordr = TestUtilityClass.ord;
        Income_Card_Payment__c icp = TestUtilityClass.icp;
        
        User u = SessionController.getUserDetails();
        system.assertNotEquals(null, u);
        String url = SessionController.makePaymentURL(ordr.Id);
        system.assertNotEquals(null, url);
        url = SessionController.deferredPaymentURL(ordr.Id);
        system.assertNotEquals(null, url);
        url = SessionController.refundURL(icp.Id);
        system.assertNotEquals(null, url);
        url = SessionController.releaseURL(icp.Id);
        system.assertNotEquals(null, url);
    }
}