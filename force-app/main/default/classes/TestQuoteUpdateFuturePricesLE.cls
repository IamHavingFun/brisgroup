/* 
 * Author : Steve Mason
 * Since : Oct 2019
 * Email : smason@bristan.com
 */

@IsTest
private class TestQuoteUpdateFuturePricesLE {

    private static String PRODUCT_JBASC ='J BAS C';
    private static String PRODUCT_PMBASC = 'PM BAS C';
    private static String CURRENCY_ISO_CODE_GBP = ' GBP';

    @IsTest
    static void QuoteUpdateFuturePricesUnitTest() {
        List<Product2> product = new List<Product2>();
        List<Future_Quote_Price__c> fqp = new List<Future_Quote_Price__c>(); 
        List<QuoteLineItem> Qli = new List<QuoteLineItem>();
        //Set up test data
        Account account = DataFactory.createAccount('TestAccount');
        insert account;
        //Getting standard PriceBook information
        String standardPriceBookId = Test.getStandardPricebookId();
        
        Opportunity opp = TestUtilityDataFactory.createOpportunity('Project', 'ProOpp', standardPriceBookId);
        opp.AccountId = account.Id;
        insert opp;
        
        String specialPriceRecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'Special Price' AND SObjectType = 'Quote'][0].Id;
        //Quote Data
        Quote q = new Quote(
                Name = 'TestQuote',
                OpportunityId = opp.Id,
                RecordTypeId = specialPriceRecordTypeId,
                Pricebook2Id = standardPriceBookId,
                Discount_Perc__c = 10,
                Expiration_Date__c = Date.today().addDays(60));
        insert q;
        
        // Inserting Product Data 
        product.add(new Product2(Name = PRODUCT_JBASC, ProductCode = PRODUCT_JBASC, Site__c = '01', IsActive = true));
        product.add(new Product2(Name = PRODUCT_PMBASC, ProductCode = PRODUCT_PMBASC, Site__c = '01', IsActive = true));
        insert product;

        //Inserting Products into StandardPricebook       
        List<PriceBookEntry> pbe = new List<PriceBookEntry>();
        pbe.add(new PriceBookEntry(Product2Id = product[0].id, PriceBook2Id = standardPriceBookId, UnitPrice = 100, IsActive = true, CurrencyIsoCode = CURRENCY_ISO_CODE_GBP));
        pbe.add(new PriceBookEntry(Product2Id = product[1].id, PriceBook2Id = standardPriceBookId, UnitPrice = 150, IsActive = true, CurrencyIsoCode = CURRENCY_ISO_CODE_GBP));
        insert pbe;
        // Inserting Future Price
        fqp.add(new Future_Quote_Price__c(Product_Code__c = PRODUCT_JBASC, Site__c = '01', Price__c = 123.45, Account_Number__c = '0222'));
        insert fqp;

        //creating QuoteLineItems  
        QuoteLineItem qp = new QuoteLineItem(Quoteid = q.id,unitPrice = 105.00,PriceBookEntryId= pbe[0].id,IFS_Price__c=0,Quantity=10);
        Qli.add(qp);
        QuoteLineItem qp2 = new QuoteLineItem(Quoteid = q.id,unitPrice = 104.00,PriceBookEntryId= pbe[1].id,IFS_Price__c=0,Quantity=10);
        Qli.add(qp2);
        insert Qli;         

        Integer lines = QuoteUpdateFuturePricesLE.getLineCount(q.Id);
        System.assertEquals(2, lines, 'Lines count does not match');
    }

    @IsTest
    static void createListTest() {
        List<Product2> product = new List<Product2>();
        List<Future_Quote_Price__c> fqp = new List<Future_Quote_Price__c>(); 
        List<QuoteLineItem> Qli = new List<QuoteLineItem>();
        //Set up test data
        Account account = DataFactory.createAccount('TestAccount');
        insert account;
        //Getting standard PriceBook information
        String standardPriceBookId = Test.getStandardPricebookId();
        
        Opportunity opp = TestUtilityDataFactory.createOpportunity('Project', 'ProOpp', standardPriceBookId);
        opp.AccountId = account.Id;
        insert opp;
        
        String specialPriceRecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'Special Price' AND SObjectType = 'Quote'][0].Id;
        //Quote Data
        Quote q = new Quote(
                Name = 'TestQuote',
                OpportunityId = opp.Id,
                RecordTypeId = specialPriceRecordTypeId,
                Pricebook2Id = standardPriceBookId,
                Discount_Perc__c = 10,
                Expiration_Date__c = Date.today().addDays(60));
        insert q;
        
        // Inserting Product Data 
        product.add(new Product2(Name=PRODUCT_JBASC,ProductCode=PRODUCT_JBASC,Site__c = '01', IsActive=true));
        product.add(new Product2(Name=PRODUCT_PMBASC,ProductCode=PRODUCT_PMBASC,Site__c = '01', IsActive=true));
        insert product;

        //Inserting Products into StandardPricebook       
        List<PriceBookEntry> pbe = new List<PriceBookEntry>();
        pbe.add(new PriceBookEntry(Product2Id = product[0].id, PriceBook2Id = standardPriceBookId, UnitPrice = 100, IsActive= true, CurrencyIsoCode = CURRENCY_ISO_CODE_GBP));
        pbe.add(new PriceBookEntry(Product2Id = product[1].id, PriceBook2Id = standardPriceBookId, UnitPrice = 150, IsActive= true, CurrencyIsoCode = CURRENCY_ISO_CODE_GBP));
        insert pbe;
        // Inserting Future Price
        fqp.add(new Future_Quote_Price__c(Product_Code__c = PRODUCT_JBASC, Site__c = '01', Price__c = 123.45, Account_Number__c = '0222'));
        insert fqp;

        //creating QuoteLineItems  
        QuoteLineItem qp = new QuoteLineItem(Quoteid = q.id,unitPrice = 105.00,PriceBookEntryId= pbe[0].id,IFS_Price__c=0,Quantity=10);
        Qli.add(qp);
        QuoteLineItem qp2 = new QuoteLineItem(Quoteid = q.id,unitPrice = 104.00,PriceBookEntryId= pbe[1].id,IFS_Price__c=0,Quantity=10);
        Qli.add(qp2);
        insert Qli;         

        Boolean q1 = QuoteUpdateFuturePricesLE.createList(q.Id);
        System.assert(q1, 'List was not created');
    }}