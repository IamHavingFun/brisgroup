/* 
 * Author : Steve Mason
 * Since : Nov 2014
 * Email : smason@bristan.com
 */

@isTest(SeeAllData = True)
private class TestQuoteUpdateFuturePrices {

    static testMethod void QuoteUpdateFuturePricesUnitTest() {

        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : p.id limit 1];

        //Set up test data  
        TestUtilityClass.setUpData();
        //Quote Data
        Quote q = TestUtilityClass.q;
  
        QuoteLineItem qli = ([
            SELECT Id, IFS_Price__c, UnitPrice
            FROM QuoteLineItem
            LIMIT 1
        ]);
        QuoteLineItem qli2;

        System.runAs(thisuser){
            Test.startTest();
            qli.UnitPrice = 50;
            update qli;
            QuoteUpdateFuturePrices qufp = new QuoteUpdateFuturePrices();
            qufp.createLists(q.Id);

            qli2 = ([
                SELECT Id, IFS_Price__c
                FROM QuoteLineItem
                WHERE Id = :qli.Id
            ]);

            Test.stopTest();
        }
        
        System.assertNotEquals(qli.IFS_Price__c, qli2.IFS_Price__c);

    }


    static testMethod void QuoteNotUpdateFuturePricesUnitTest() {

        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : p.id limit 1];

        //Set up test data  
        TestUtilityClass.setUpData();
        //Quote Data
        Quote q = TestUtilityClass.q;
  
        QuoteLineItem qli = ([
            SELECT Id, IFS_Price__c
            FROM QuoteLineItem
            LIMIT 1
        ]);
        System.runAs(thisuser){
            Test.startTest();
            QuoteUpdateFuturePrices qufp = new QuoteUpdateFuturePrices();
            Test.stopTest();
        }
        QuoteLineItem qli2 = ([
            SELECT Id, IFS_Price__c
            FROM QuoteLineItem
            WHERE Id = :qli.Id
        ]);

        System.assertEquals(qli.IFS_Price__c, qli2.IFS_Price__c);

    }
}