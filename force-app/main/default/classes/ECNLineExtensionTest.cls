/**
 * @author Polsource
 */
@IsTest
public class ECNLineExtensionTest {
  
    @IsTest
    static void Test1() {
        List<SelectOption> shortPartOptions = new List<SelectOption>();
        /**** CREATE TEST DATA ****/
        // Create Sales Group
        Sales_Group__c sg = TestUtilityDataFactory.createSalesGroup('Test', '000000', '000000');
        insert sg;
        // Create Supplier
        Supplier__c sup = TestUtilityDataFactory.createSupplier('Test', '000000', '000000');
        insert sup;        
        
        // Create PAS Product record
        Product__c prod = TestUtilityDataFactory.createProduct();
        prod.Product_Code__c = 'Test Product';
        insert prod;

        String productId = prod.Id;
        system.debug('*****PRODUCT ID: ' + productId);

        // Create ECN
        ECN__c ecn = TestUtilityDataFactory.createECN(prod.Id, 'Discontinuation', 'TEST ECN', 'New');
        ecn.Area_to_Change__c = 'Discontinuation';      
        ecn.Effective_Date__c = date.today();
        ecn.Value_of_Obsolete_Stock__c = 10;
        ecn.Quantity_of_Obsolete_Stock__c = 10;
        ecn.Last_Sales_Date__c = date.today();
        insert ecn;

        String ECNId = ecn.Id;      
        system.debug('*****ECN ID: ' + ECNId);
        /**** END CREATE TEST DATA ****/

        Test.startTest();
        // Create ECN Line linked to ECN
        ECN_Line__c newline = new ECN_Line__c(ECN__c = ECNId);
        // Test constructor for new ECN line
        PageReference pr = new PageReference('/apex/ECNLine');
        Test.setcurrentPage(pr);  
        ApexPages.StandardController ctrl = new ApexPages.StandardController(newline);
        ECNLineExtension ext = new ECNLineExtension(ctrl);
        // Get picklist options for text field
        newline.Field_to_Change__c = 'Short Part Description';
        shortPartOptions = ext.getOptions();      
        // Get picklist options for boolean field
        newline.Field_to_Change__c = 'Sales Part Active?';
        ext.getOptions();
        // Set new value
        newline.Picklist_Value__c = 'true';
        ext.setNewValue();
        // Test successful save
        ext.save();
        // Test non matching areas - Discontinuation (other)
        newline.Area_to_Change__c = 'Purchasing';  
        ext.save();
        
        // Test constructor for existing ECN line
        pr = new PageReference('/apex/ECNLine');
        Test.setcurrentPage(pr);  
        ctrl = new ApexPages.StandardController(newline);
        ext = new ECNLineExtension(ctrl);
        
        // Test save with invalid supersede code
        newline = new ECN_Line__c(ECN__c=ECNId);
        pr = new PageReference('/apex/ECNLine');
        Test.setcurrentPage(pr);  
        ctrl = new ApexPages.StandardController(newline);
        ext = new ECNLineExtension(ctrl);
        newline.Field_to_Change__c = 'Supersede Code';
        newline.New_Value__c = 'ABC'; // this is an invalid part code
        ext.save();
        
        // Test non matching areas - Originator
        ecn = new ECN__c();
        ecn.Product__c = prod.Id;
        ecn.Type__c = 'Change';
        ecn.Notes__c = 'TEST ECN';
        ecn.Area_to_Change__c = 'Originator';
        ecn.Status__c = 'New';
        ecn.Effective_Date__c = date.today();
        INSERT ecn;
        ecn = [SELECT Id, Area_to_Change__c, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Change' LIMIT 1];
        ECNId = ecn.Id; 
        newline = new ECN_Line__c(ECN__c=ECNId);
        pr = new PageReference('/apex/ECNLine');
        Test.setcurrentPage(pr);  
        ctrl = new ApexPages.StandardController(newline);
        ext = new ECNLineExtension(ctrl);
        newline.Area_to_Change__c = 'Purchasing';
        ext.save();
        
        // Test non matching areas - Purchasing
        ecn = new ECN__c();
        ecn.Product__c = prod.Id;
        ecn.Type__c = 'Purchasing/Supplier Change';
        ecn.Notes__c = 'TEST ECN';
        ecn.Area_to_Change__c = 'Purchasing';
        ecn.Status__c = 'New';
        ecn.Effective_Date__c = date.today();
        INSERT ecn;
        ecn = [SELECT Id, Area_to_Change__c, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Purchasing/Supplier Change' LIMIT 1];
        ECNId = ecn.Id; 
        newline = new ECN_Line__c(ECN__c=ECNId);
        pr = new PageReference('/apex/ECNLine');
        Test.setcurrentPage(pr);  
        ctrl = new ApexPages.StandardController(newline);
        ext = new ECNLineExtension(ctrl);
        newline.Area_to_Change__c = 'Originator';
        ext.save();
        
        // Test non matching areas - Technical
        ecn = new ECN__c();
        ecn.Product__c = prod.Id;
        ecn.Type__c = 'Change';
        ecn.Notes__c = 'TEST ECN';
        ecn.Area_to_Change__c = 'Technical';
        ecn.Status__c = 'New';
        ecn.Effective_Date__c = date.today();
        INSERT ecn;
        ecn = [SELECT Id, Area_to_Change__c, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Change' and Area_to_Change__c = 'Technical' LIMIT 1];
        ECNId = ecn.Id; 
        newline = new ECN_Line__c(ECN__c=ECNId);
        pr = new PageReference('/apex/ECNLine');
        Test.setcurrentPage(pr);  
        ctrl = new ApexPages.StandardController(newline);
        ext = new ECNLineExtension(ctrl);
        newline.Area_to_Change__c = 'Purchasing';
        ext.save();
        
        // Test incorrect ECN status
        ecn = new ECN__c();
        ecn.Product__c = prod.Id;
        ecn.Type__c = 'Change';
        ecn.Notes__c = 'TEST ECN';
        ecn.Area_to_Change__c = 'Sales';
        ecn.Status__c = 'Awaiting Technical Check';
        ecn.Effective_Date__c = date.today();
        INSERT ecn;
        ecn = [SELECT Id, Area_to_Change__c, Product__c, Type__c, Status__c from ECN__c where Type__c = 'Change' and Area_to_Change__c = 'Sales' LIMIT 1];
        ECNId = ecn.Id; 
        newline = new ECN_Line__c(ECN__c=ECNId);
        pr = new PageReference('/apex/ECNLine');
        Test.setcurrentPage(pr);  
        ctrl = new ApexPages.StandardController(newline);
        ext = new ECNLineExtension(ctrl);
        ext.save();
        
        // Get picklist options for picklist field
        newline.Field_to_Change__c = 'Sales Price Group';
        ext.getOptions();

        Test.stopTest();
        System.assert(!shortPartOptions.isEmpty(), 'Options must be returned for Short Part Description');
  }  
}