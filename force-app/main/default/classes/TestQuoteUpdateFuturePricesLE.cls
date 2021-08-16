/* 
 * Author : Steve Mason
 * Since : Oct 2019
 * Email : smason@bristan.com
 */

@IsTest
private class TestQuoteUpdateFuturePricesLE {

    @IsTest
    static void QuoteUpdateFuturePricesUnitTest() {
          
        DataFactory.createQuoteWithQuoteLineItems('Test_Quote1'); 

        Quote q = ([
            SELECT Id
            FROM Quote
            LIMIT 1
            FOR UPDATE
        ]);

        Integer lines = QuoteUpdateFuturePricesLE.getLineCount(q.Id);
        System.assertEquals(2, lines, 'Lines count does not match');
    }

    @IsTest
    static void createListTest() {
        
        DataFactory.createQuoteWithQuoteLineItems('Test_Quote'); 

        Quote q = ([
            SELECT Id
            FROM Quote
            LIMIT 1
            FOR UPDATE
        ]);

        Boolean q1 = QuoteUpdateFuturePricesLE.createList(q.Id);
        System.assert(q1, 'List was not created');
    }}