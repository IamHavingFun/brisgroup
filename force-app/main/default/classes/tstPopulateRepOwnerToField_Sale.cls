/**
 * @description test for the 'Populate Rep_Owner_Lookup__c Field' trigger (Sale__c)
 * @author 
 * @since 
 */
@IsTest
private class tstPopulateRepOwnerToField_Sale {

    @IsTest
    static void testBeforeInsert() {

        User usercontext = TestUtilityDataFactory.insertSystemUser('System Administrator', 'agn');
        // create dummy Sales Summary
        Test.startTest();
        system.runAs(usercontext){
            Sale__c o = new Sale__c(
                Month__c = '01', 
                Year__c = '2012',
                Target__c = 500,
                External_Unique_Id__c = '000000000000000000',
                OwnerId = usercontext.Id);
            insert o;

            Account acc = new Account(Name='TestAcc');
            insert acc;
        }
        Test.stopTest();

        // get the custom "Assigned To" field value
        Sale__c saleRecord = [SELECT OwnerId, Rep_Owner_Lookup__c FROM Sale__c WHERE External_Unique_Id__c = '000000000000000000' LIMIT 1];

        System.assertEquals(saleRecord.OwnerId, saleRecord.Rep_Owner_Lookup__c, 'Owner values does not match');
    }

    @IsTest
    static void testBeforeUpdate() {
        User usercontext = TestUtilityDataFactory.insertSystemUser('System Administrator', 'agn');
        // create dummy Sales Summary
        Test.startTest();
        system.runAs(usercontext){
            Sale__c o = new Sale__c(
                Month__c = '01', 
                Year__c = '2012',
                Target__c = 500,
                External_Unique_Id__c = '000000000000000000',
                OwnerId = usercontext.Id);
            insert o;

            Account acc = new Account(
                Name = 'TestAcc'
            );
            insert acc;

            o.Account__c = acc.Id;
            update o;
        }
        Test.stopTest();
        String accountOwnerId = [SELECT OwnerId FROM Account WHERE Name = 'TestAcc' LIMIT 1][0].OwnerId;
        String salesOwnerId = [SELECT Rep_Owner_Lookup__c FROM Sale__c WHERE External_Unique_Id__c = '000000000000000000' LIMIT 1][0].Rep_Owner_Lookup__c;
        System.assertEquals(accountOwnerId, salesOwnerId, 'Owner values does not match');
    }
}