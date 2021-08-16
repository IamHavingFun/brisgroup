/* 
 * Author : Steve Mason
 * Since : Nov 2014
 * Email : smason@bristan.com
 */

@isTest
private class TestQuoteUpdateFuturePrices {
 
    static testMethod void QuoteUpdateFuturePricesUnitTest() {

        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : p.id limit 1];
        DataFactory.createQuoteWithQuoteLineItems('TestQuote1'); 
        
        Quote q = ([
            SELECT Id
            FROM Quote
            LIMIT 1
            FOR UPDATE
        ]);
  
        QuoteLineItem qli1 = ([
            SELECT Id, IFS_Price__c, UnitPrice
            FROM QuoteLineItem
            LIMIT 1
        ]);
        QuoteLineItem qli2;
        
        Test.startTest();

        System.runAs(thisuser){

            qli1.UnitPrice = 50;
            update qli1;
            QuoteUpdateFuturePrices qufp = new QuoteUpdateFuturePrices();
            qufp.createLists(q.Id);

            qli2 = ([
                SELECT Id, IFS_Price__c
                FROM QuoteLineItem
                WHERE Id = :qli1.Id
            ]);

        }

        System.assertNotEquals(qli1.IFS_Price__c, qli2.IFS_Price__c);

        Test.stopTest();

    }


    static testMethod void QuoteNotUpdateFuturePricesUnitTest() {

        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User thisuser = [select id, name from User where IsActive = TRUE AND  Profileid = : p.id limit 1];
        DataFactory.createQuoteWithQuoteLineItems('TestQuote2'); 

        Quote q = ([
            SELECT Id
            FROM Quote
            LIMIT 1
            FOR UPDATE
        ]);
  
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