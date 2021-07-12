@isTest
public class TestDataCreationTest {

    static testMethod void Test1() {
        test.StartTest();
        
        Account a = TestDataCreation.CreateAccount('xxxTESTxxxTESTxxx');
        System.assertNotEquals(a, null);
        
        Contact c = TestDataCreation.createContact('Homer','Simpson',a.Id);
        System.assertNotEquals(c, null);
        
        Case cs = TestDataCreation.CreateCase('Test Subject',a.Id,c.Id);
        System.assertNotEquals(cs, null);
        
        Application_Config__c ac = TestDataCreation.CreateAppConfig('Temp','Temp');
        System.assertNotEquals(ac, null);
        
        Product2 p = TestDataCreation.CreateProduct('Test Product');
        System.assertNotEquals(p, null);
        
        Product_Revision__c pr = TestDataCreation.CreateProductRevision('1','Test Revision','1',p.Id);
        System.assertNotEquals(pr, null);
        
        Spares_Revision__c sr = TestDataCreation.CreateSparesRevision('1','Test Revision','1',p.Id);
        System.assertNotEquals(sr, null);
        
        Catalogue_Junction__c cj = TestDataCreation.CreateCatalogueJunction(pr.Id,sr.Id);
        System.assertNotEquals(cj, null);
        
        Delivery_Term__c dtp = TestDataCreation.CreateDeliveryTermPST();
        System.assertNotEquals(dtp, null);
        
        Delivery_Term__c dt = TestDataCreation.CreateDeliveryTerm();
        System.assertNotEquals(dt, null);
        
        test.StopTest(); 
    }
}