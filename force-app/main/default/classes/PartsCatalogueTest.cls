/**
 * @author 
 * @since 
 */
@IsTest
public class PartsCatalogueTest {

    public static Account newacc;
    public static Contact ct;
    public static Case cs;
    public static EmailTemplate newEm;
    public static Product2 newprod;
    public static Product_Revision__c newpRev;
    public static Catalogue_Junction__c newCat;
    public static Spares_Revision__c newsp;
    public static Delivery_Term__c newdt;

    static {
        newacc = TestDataCreation.CreateAccount('Test');
        
        ct = TestDataCreation.createContact('Paul', 'Harvie', newacc.id);
        
        cs = TestDataCreation.CreateCase('Test Case', newacc.id, ct.id);
        
        newdt = TestDataCreation.CreateDeliveryTermPST();
        
        
        //EmailTemplate newEm = TestDataCreation.CreateEmailTemplate('Test Templ','++++++++ Paul Harvie and Steve Fouracre are brilliant Salesforce guys');
        for (EmailTemplate eachtmpl :[Select Name, Id, HtmlValue From EmailTemplate]){
            if (eachtmpl.HtmlValue != null){ 
                    newEm = eachtmpl;
                    break;
            }
        }

        system.debug('####### newEm =' + newEm);
        TestDataCreation.CreateAppConfig('SendLinksEmailId', newEm.id);

        newprod = TestDataCreation.CreateProduct('A Product');
        newpRev = TestDataCreation.CreateProductRevision('Updated Prod', '1234', 'R1', newprod.id);
        newsp = TestDataCreation.CreateSparesRevision('Spare Prod', '98765', 'R1', newprod.id); 
        newCat = TestDataCreation.CreateCatalogueJunction(newpRev.id, newsp.id);
    }

    @IsTest
    static void PartsCatalogueTest1() {
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            system.assert(pc.displayAddToCollection, 'Display Add to Collection must be TRUE');
            
            pc.assignFnd();
            system.assert(pc.fnd, 'Part Catalog find error');
        Test.stopTest();
    }

    @IsTest
    static void PartsCatalogueTest2() {
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=');
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            system.assert(!pc.displayAddToCollection, 'Display Add to Collection must be FALSE');
        Test.stopTest();
    }
    
    @IsTest
    static void addToCollectionTest() {
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.addMasterProductID = newprod.id;
            pc.addMasterProductRevNumber = 'R1';
            pc.addMasterProdCode = '';
            pc.addMasterSpareRev = 'Spare Prod';
            pc.addMasterProdRevId = newpRev.id;
            pc.addProductID = newprod.id;
            pc.spareRevisionSelected = true;
            pc.addToCollection();
            system.assertEquals(pc.allProductsCollections[0].selectedName, false, 'Selected Name property must be FALSE');
            system.assertEquals(pc.allProductsCollections[0].thisProdRevNumber, 'R1', 'ProdRevNumber does not match');
            system.assertEquals(pc.allProductsCollections[0].thismasterSpareRev, 'Spare Prod', 'SpareRev does not match');
        Test.stopTest();
    }

    @IsTest
    static void sendEmailTest1() {
        system.debug('####### sendEmailTest ');
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.addMasterProductID = newprod.id;
            pc.addMasterProductRevNumber = 'R1';
            pc.addMasterProdCode = '';
            pc.addMasterSpareRev = 'Spare Prod';
            pc.addMasterProdRevId = newpRev.id;
            pc.addProductID = newprod.id;
            pc.spareRevisionSelected = true;
            pc.addToCollection();

            pc.allProductsCollections[0].selectedName = true;           
            pc.sendEmail();
            String msg = ApexPages.getMessages().get(0).getDetail();
            System.assertEquals(msg, 'No products/documents selected, no email sent.', 'Email must not be sent');
        Test.stopTest();
    }

    @IsTest
    static void sendEmailTest2(){
        system.debug('####### sendEmailTest2 ');        
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.addMasterProductID = newprod.id;
            pc.addMasterProductRevNumber = 'R1';
            pc.addMasterProdCode = '';
            pc.addMasterSpareRev = 'Spare Prod';
            pc.addMasterProdRevId = newpRev.id;
            pc.addProductID = newprod.id;
            pc.spareRevisionSelected = true;
            
            //ensure that bdy variable is populated
            pc.addToCollection();
            pc.allProductsCollections[0].selectedName = true;           
            pc.allProductsCollections[0].selectedDrawing = true;
            pc.sendEmail();
            
            system.assertEquals(pc.allProductsCollections[0].selectedName, true);
            system.assertEquals(pc.allProductsCollections[0].thisProdRevNumber, 'R1');
            system.assertEquals(pc.allProductsCollections[0].thismasterSpareRev, 'Spare Prod');

            pc.allProductsCollections[0].selectedDrawing = true;
            pc.sendEmail();

            pc.allProductsCollections[0].selectedFitting = true;
            pc.allProductsCollections[0].selectedTech = true;
            pc.allProductsCollections[0].selectedProdData = true;
            pc.allProductsCollections[0].selectedWebImage = true;
            pc.sendEmail();

            pc.allProductsCollections[0].thisPD.Product_Web_Image__c = null;
            pc.allProductsCollections[0].selectedWebImage = true;
            pc.sendEmail();
        Test.stopTest();
    }

    @IsTest
    static void addToCaseTest(){
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.addMasterProductID = newprod.id;
            pc.addMasterProductRevNumber = 'R1';
            pc.addMasterProdCode = '';
            pc.addMasterSpareRev = 'Spare Prod';
            pc.addMasterProdRevId = newpRev.id;
            pc.addProductID = newprod.id;
            pc.spareRevisionSelected = true;
            pc.addToCollection();
            pc.allProductsCollections[0].selectedName = true;
            
            pc.addToCase();
            system.assertEquals([Select id From CaseComment where ParentId = :cs.id].size() , 1);
        Test.stopTest();
    }

    @IsTest
    static void addToAssetTest(){
        system.debug('####### addToAssetTest ' );
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.addMasterProductID = newprod.id;
            pc.addMasterProductRevNumber = 'R1';
            pc.addMasterProdCode = '';
            pc.addMasterSpareRev = 'Spare Prod';
            pc.addMasterProdRevId = newpRev.id;
            pc.addProductID = newprod.id;
            pc.addspareRevisionSelected = true;
            pc.addToCollection();


            pc.allProductsCollections[0].selectedName = true;
            pc.addToAsset();
            //-ve
            system.assertEquals([Select id From Product_Asset__c where Contact__c = :ct.id].size() , 0);

            //+ve
            pc.allProductsCollections[0].thisspareRevisionSelected = false;
            pc.addToAsset();      
            system.assertEquals([Select id From Product_Asset__c where Contact__c = :ct.id].size() , 1);
        Test.stopTest();
    }

    @IsTest
    static void addToOrderTest(){
        TestDataCreation.CreateDeliveryTerm();
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.addMasterProductID = newprod.id;
            pc.addMasterProductRevNumber = 'R1';
            pc.addMasterProdCode = 'RSD34';
            pc.addMasterSpareRev = 'Spare Prod';
            pc.addMasterProdRevId = newpRev.id;
            pc.addProductID = newprod.id;
            pc.spareRevisionSelected = true;
            pc.addToCollection();
            pc.allProductsCollections[0].selectedName = true;

            pc.addToOrder();
            Order__c[] ord = [Select id From Order__c where Case_Account__c = :newacc.id];
            
            system.assertEquals(ord.size() , 1);
        Test.stopTest();
    }

    @IsTest
    static void searchProdTest(){
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.searchTxt = '1234';
            pc.searchProd();
            system.assert(pc.fnd == true);
            
            pc.fnd = false;
            pc.getmainnodes();
            
            pc.nextProd();
        Test.stopTest();
    }

    @IsTest
    static void selectProdTest(){
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.prodID = newprod.id;
            pc.selectProd();
            system.assert(pc.SelectedProd != null);
            system.assert(pc.spareRevisionSelected == false);
            system.assert(pc.SelectedRev == null);
            system.assert(pc.prodRevision == null);
        Test.stopTest();
    }

    @IsTest
    static void selectProdRevisionTest(){
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.prodID = newprod.id;
            pc.prodRevID = newpRev.id;
            pc.selectProdRevision();
            system.assert(pc.prodRevision != null);
        Test.stopTest();
    }

    @IsTest
    static void selectRevsionTest(){
        Test.startTest();
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.revID = newsp.id;
            pc.prodRevID = newpRev.id;
            pc.selectRevsion();
            system.assert(pc.prodRevision != null);
            system.assert(pc.spareRevisionSelected == true);
        Test.stopTest();
    }

    @IsTest
    static void qtyCalloutTest(){
        Test.startTest();
            
            Application_Config__c QuantityRequestURL = new Application_Config__c(Name='QuantityRequestURL', Value__c = 'http://185.13.140.5:59080/fndext/soapgateway');
            Application_Config__c QuantityRequestUserName = new Application_Config__c(Name='QuantityRequestURL', Value__c = 'ifsconnect');
            Application_Config__c QuantityRequestPassword = new Application_Config__c(Name='QuantityRequestURL', Value__c = 'trafficj4m$');
            
            PageReference pr = new PageReference('/apex/PartsCatalogue?id=' + cs.id);
            Test.setcurrentPage(pr);
            PartsCatalogue pc = new PartsCatalogue();
            pc.revID = newsp.id;
            pc.prodRevID = newpRev.id;
            pc.selectRevsion();
            pc.SelectedProd = newprod;
            pc.qtyCallout();
            System.assert(!pc.displayRetrievingQuantity, '');
        Test.stopTest();
    }
  
}