@isTest
// test for the 'Populate Rep_Owner_Lookup__c Field' trigger (Sale__c)
private class tstPopulateRepOwnerToField_Sale {
    static testMethod void test() {
        // create dummy Sales Summary
        Sale__c o = new Sale__c(Month__c = '01', Year__c = '2012',Target__c=500,
                                        External_Unique_Id__c = 'ZzZzZzZzZz', 
                                        OwnerId = '005D00000023Sse'); 
                            
        Test.startTest();
        insert o;
        Account acc = new Account(Name='TestAcc');
        insert acc;        
        o.Account__c = acc.Id;
        update o;      
        Test.stopTest();       

    }
}