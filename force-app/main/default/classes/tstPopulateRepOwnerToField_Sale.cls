@isTest
// test for the 'Populate Rep_Owner_Lookup__c Field' trigger (Sale__c)
private class tstPopulateRepOwnerToField_Sale {

    @IsTest
    static void test() {

        Profile prof = [SELECT Id FROM Profile WHERE Name LIKE '%administrator%' LIMIT 1];
        System.debug('#K#' + prof);
        User user = new User();
        user.FirstName = 'test1';
        user.LastName = 'test2';
        user.ProfileId = prof.Id;
        user.Username = 'test@test.com.x1234.x1234';
        user.Email = 'test@test.com';
        user.Alias = 'standtx';
        user.EmailEncodingKey='UTF-8';
        user.LanguageLocaleKey='en_US';
        user.LocaleSidKey='en_US';
        user.TimeZoneSidKey='America/Los_Angeles';
        insert user;



        // create dummy Sales Summary
        Test.startTest();
        system.runAs(user){
            Sale__c o = new Sale__c(Month__c = '01', Year__c = '2012',Target__c=500,
                                            External_Unique_Id__c = 'ZzZzZzZzZz',
                                            OwnerId = user.Id);
            insert o;

            Account acc = new Account(Name='TestAcc');
            insert acc;

            o.Account__c = acc.Id;
            update o;
        }
        Test.stopTest();

        // get the custom "Assigned To" field value
        String owner = [SELECT OwnerId FROM Sale__c WHERE
                External_Unique_Id__c = 'ZzZzZzZzZz' LIMIT 1].OwnerId;

        System.debug('#K#1 ' + owner);
        System.debug('#K#2 ' + user.Id);

        // test "Assigned To"
        //System.assertEquals(strType_o,'Steve Mason');


    }
}