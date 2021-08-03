/**
 * 
 * @author PolSource
 */
@IsTest
public with sharing class ECNTriggerTest {

    @TestSetup 
    static void initData() {
        //  Create PAS User
        User contextUser = TestUtilityDataFactory.insertSystemUser('Standard User', 'temp');
        //  Assign user to Permission Set
        TestUtilityDataFactory.assignUserToPermissionSet(contextUser.Id, 'NPW_Originator');
    }
    
    @IsTest
    static void insertNewECNRecord() {
        
        //  Create Sales Group
        Sales_Group__c sg = TestUtilityDataFactory.createSalesGroup('Test', '000000', '000000');
        insert sg;
        //  Create Supplier
        Supplier__c sup = TestUtilityDataFactory.createSupplier('Test', '000000', '000000');
        insert sup;
        //  Create Product
        Product__c prod = TestUtilityDataFactory.createProduct();
        insert prod;        
        //  Get context user
        User contextUser = [SELECT Id FROM User WHERE Alias = 'temp'];
        //  Create ECN
        ECN__c ecn = TestUtilityDataFactory.createECN(prod.Id, 'Discontinuation', 'Initial Notes', 'New');
        Test.startTest();
        System.runAs(contextUser){
            insert ecn;
        }
        Test.stopTest();
        prod = [SELECT Status__c FROM Product__c WHERE Id = :prod.Id];
        System.assertEquals('Complete', prod.Status__c, 'Status must be : \'Complete\'');
    }

    @IsTest
    static void updateECNRecord() {
        //  Create Sales Group
        Sales_Group__c sg = TestUtilityDataFactory.createSalesGroup('Test', 'SG_KEY', '000000');
        insert sg;
        //  Create Supplier
        Supplier__c sup = TestUtilityDataFactory.createSupplier('Test', 'SP_KEY', '000000');
        insert sup;
        //  Create Product
        Product__c prod = TestUtilityDataFactory.createProduct();
        insert prod;        
        //  Get context user
        User contextUser = [SELECT Id FROM User WHERE Alias = 'temp'];
        //  Create ECN
        ECN__c ecn = TestUtilityDataFactory.createECN(prod.Id, 'Discontinuation', 'Initial Notes', 'New');
        insert ecn;
        // 
        List<ECN_Line__c> lines = new List<ECN_Line__c>();
        ECN_Line__c longPartLine = new ECN_Line__c(ECN__c = ecn.Id, Field_to_Change__c = 'Long Part Description', New_Value__c='New');
        lines.add(longPartLine);
        ECN_Line__c shortPartLine = new ECN_Line__c(ECN__c = ecn.Id, Field_to_Change__c = 'Short Part Description', New_Value__c = 'New');
        lines.add(shortPartLine);
        ECN_Line__c leadTimeLine = new ECN_Line__c(ECN__c = ecn.Id, Field_to_Change__c = 'Lead Time (Days)', New_Value__c = '99');
        lines.add(leadTimeLine);
        ECN_Line__c salesGroupLine = new ECN_Line__c(ECN__c = ecn.Id, Field_to_Change__c = 'Sales Group', New_Value__c = 'SG_KEY');
        lines.add(salesGroupLine);
        ECN_Line__c supplierLine = new ECN_Line__c(ECN__c = ecn.Id, Field_to_Change__c = 'Supplier', New_Value__c = 'SP_KEY');
        lines.add(supplierLine);
        // 
        insert lines;

        Test.startTest();
        System.runAs(contextUser){
            ecn.Status__c = 'Completed';
            update ecn;
        }
        Test.stopTest();

        prod = [SELECT Status__c, Supplier__c, Sales_Group__c, Lead_Time__c, Long_Part_Description__c, Short_Part_Description__c FROM Product__c WHERE Id = :prod.Id];
        System.assertEquals('Complete', prod.Status__c, 'Product status must been have marked as \'Complete\'');
        System.assertEquals(sup.Id, prod.Supplier__c, 'Supplier Id must have been set based on its Key');
        System.assertEquals(sg.Id, prod.Sales_Group__c, 'Sales Group Id must have been set based on its Key');
        System.assertEquals(99, prod.Lead_Time__c, 'Lead time must match');
        System.assertEquals('New', prod.Long_Part_Description__c, 'Long Part description must match');
        System.assertEquals('New', prod.Short_Part_Description__c, 'Long Part description must match');
    }
    
}