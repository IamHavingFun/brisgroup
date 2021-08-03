/*
 * This class contains the data that is necessary to test OpportunityUpdatePrice, QuoteUpdatePrice, OrderUpdatePrice and CorrUpdatePrice classes.
 * Author : Bhushan Adhikari
 * since  : June 2012
 * E-Mail : badhikari@innoveer.com
 */
//(SeeAllData = True)
@IsTest
public class TestUtilityClass {
    public static Account acc;
    public static Contact con;
    public static Opportunity opp;
    public static Opportunity opp2;
    public static Opportunity proj;
    public static Order__c ord;
    public static Staff_Sale__c ss;
    public static Staff_Sale__c ss2;
    public static Staff_Sale__c ss3;
    public static Staff_Sale__c ss4;
    public static Order__c ord2;
    public static Order__c ord3;
    public static Case cs;
    public static Case cs2;
    public static Delivery_Term__c dt;
    public static Product2 prod;
    public static List<Product2> products = new List<Product2>();
    public static List<Product_Clone__c> productClones = new List<Product_Clone__c>();
    public static Quote q;
    public static Quote q2;
    public static List<QuoteLineItem> qli = new List<QuoteLineItem>();
    public static List<OpportunityLineItem> oli = new List<OpportunityLineItem>();
    public static List<Order_Line__c> Orli = new List<Order_Line__c>();
    public static List<Staff_Sale_Line__c> ssli = new List<Staff_Sale_Line__c>();
    public static Correspondence__c corr;
    public static List<Price_Enquiry_Line__c> correspondences = new List<Price_Enquiry_Line__c>();
    public static Income_Card_Payment__c icp;
    public static Pricebook2 pb;
    public static BMCServiceDesk__BMC_BaseElement__c bs;
    public static BMCServiceDesk__Impact__c impact;
    public static BMCServiceDesk__Urgency__c urg;
    public static BMCServiceDesk__Status__c status;
    public static BMCServiceDesk__Priority__c priority;

    public static void setUpData() {

        acc = DataFactory.createAccount('Test Account1');
        insert acc;

        con = DataFactory.createContact('Steve','Mason', acc);
        insert con;

        //Getting standard PriceBook information
        Pricebook2 pb = [SELECT Id,Name FROM Pricebook2 WHERE Name = :'Standard Price Book' LIMIT 1];
        cs = DataFactory.createCase('Test Case');
        insert cs;

        cs2 = DataFactory.createCase('Test Case2');
        cs2.RecordTypeId = DataFactory.getCaseRecordTypeId('Heritage');
        insert cs2;

        // Staff Sale Data
        ss = new Staff_Sale__c(
                Division__c = 'Bristan',
                Sales_Type__c = 'Friends and Family',
                Delivery_Method__c = 'Collection',
                Status__c = 'New');
        insert ss;

        ss2 = new Staff_Sale__c(
                Division__c = 'Heritage',
                Sales_Type__c = 'Staff Sales',
                Delivery_Method__c = 'Collection',
                Status__c = 'New');
        insert ss2;

        ss3 = new Staff_Sale__c(
                Division__c = 'Bristan',
                Sales_Type__c = 'Staff Sales',
                Delivery_Method__c = 'Collection',
                Status__c = 'New');
        insert ss3;

        ss4 = new Staff_Sale__c(Division__c = 'Bristan',
                Sales_Type__c = 'Staff Sales',
                Delivery_Method__c = 'Collection');
        insert ss4;

        // Order Data
        dt = [SELECT Id,Name FROM Delivery_Term__c WHERE Name = :'PST' LIMIT 1];

        ord = DataFactory.createOrder(acc, dt, cs);
        ord.Ship_Via__c = 'AM';
        ord.Order_Type__c = 'SC';
        ord.Discount__c = '0%';
        insert ord;

        ord2 = DataFactory.createOrder(acc, dt, cs);
        ord2.Ship_Via__c = 'AM';
        ord2.Order_Type__c = 'SC';
        ord2.Discount__c = '0%';
        insert ord2;

        ord3 = DataFactory.createOrder(acc, dt, cs);
        insert ord3;

        // Income Card Payment
        icp = new Income_Card_Payment__c(Order__c = ord.Id);
        insert icp;

        // Correspondence Data
        corr = new Correspondence__c(
                RecordTypeId = DataFactory.getCorrespondenceRecordTypeId('Price Enquiry'),
                Contact__c = con.Id, Currency__c = 'GBP');
        insert corr;

        //Project Data
        proj = DataFactory.createProject('TestProj', acc, pb);
        insert proj;

        //Opportunity Data
         opp = DataFactory.createOpportunity('TestOpp', acc, proj, pb);
        insert opp;

        opp2 = DataFactory.createOpportunity('TestOpp2', acc, proj, pb);
        opp2.Customer_Order_Number__c = 'Test Order 2';
        insert opp2;

        System.debug('AccountID : ' + acc.Id);
        System.debug('ContactID : ' + con.Id);
        System.debug('CaseID : ' + cs.Id);
        System.debug('CaseID2 : ' + cs2.Id);
        System.debug('OrderID : ' + ord.Id);
        System.debug('OrderID2 : ' + ord2.Id);
        System.debug('CorrespondenceID : ' + corr.Id);
        System.debug('ProjectID : ' + proj.Id);
        System.debug('OpportunityID : ' + opp.Id);
        System.debug('Opportunity2ID : ' + opp2.Id);

        //Quote Data

        q = new Quote(
                Name = 'TestQuote',
                OpportunityId = opp.Id,
                RecordTypeId = DataFactory.getQuoteRecordTypeId('Special Price'),
                Pricebook2Id = pb.Id,
                Discount_Perc__c = 10,
                Expiration_Date__c = Date.today().addDays(60));
       insert q;

        q2 = new Quote(
                Name = 'TestQuote2',
                OpportunityId = opp.Id,
                RecordTypeId = DataFactory.getQuoteRecordTypeId('Special Price'),
                Pricebook2Id = pb.Id,
                Discount_Perc__c = 10,
                Expiration_Date__c = Date.today().addDays(60));

        insert q2;

        // Inserting Product Data 
        products.add(new Product2(Name = 'HY PUMP70', ProductCode = 'HY PUMP70', Site__c = '01', IsActive = true));
        products.add(new Product2(Name = 'HY PUMP50', ProductCode = 'HY PUMP50', Site__c = '02', IsActive = true));
        products.add(new Product2(Name = 'HY PUMP100', ProductCode = 'HY PUMP100', Site__c = '03', IsActive = true));
        products.add(new Product2(Name = 'HY PUMP71', ProductCode = 'HY PUMP71', Site__c = '04', IsActive = true));

        try {
            insert products;
        } catch (DmlException e) {
            System.debug(e);
        }

        // Inserting Product Clone Data 
        productClones.add(new Product_Clone__c(Name = 'HY PUMP7012', Site_and_Product_Code__c = '01_HY PUMP7012', Product_Code__c = 'HY PUMP7012', Site__c = '01',
                Product_Active__c = true));
        productClones.add(new Product_Clone__c(Name = 'HY PUMP7013', Site_and_Product_Code__c = '04_HY PUMP7013', Product_Code__c = 'HY PUMP7013', Site__c = '04',
                Product_Active__c = true));
        productClones.add(new Product_Clone__c(Name = 'HY PUMP7014', Site_and_Product_Code__c = '01_HY PUMP7014', Product_Code__c = 'HY PUMP7014', Site__c = '01',
                Product_Active__c = true, Package_Part__c = true, Package_Part_Components__c = 'RS SHCVO C~1;RS BF C~1;RS BAS C~1'));
        productClones.add(new Product_Clone__c(Name = 'HY PUMP7015', Site_and_Product_Code__c = '04_HY PUMP7015', Product_Code__c = 'HY PUMP7015', Site__c = '04',
                Product_Active__c = true, Package_Part__c = true, Package_Part_Components__c = 'RS SHCVO C~1;RS BF C~1;RS BAS C~1'));
        try {
            insert productClones;
        } catch (DmlException e) {
            System.debug('PRODUCT CLONE INSERT FAILED!');
            System.debug(e);
        }

        //Inserting Products into StandardPricebook       
        List<PricebookEntry> pbe = new List<PricebookEntry>();
        pbe.add(new PricebookEntry(Product2Id = products[0].Id, Pricebook2Id = pb.Id, UnitPrice = 100, IsActive = true, CurrencyIsoCode = 'GBP'));
        pbe.add(new PricebookEntry(Product2Id = products[1].Id, Pricebook2Id = pb.Id, UnitPrice = 150, IsActive = true, CurrencyIsoCode = 'GBP'));
        pbe.add(new PricebookEntry(Product2Id = products[2].Id, Pricebook2Id = pb.Id, UnitPrice = 160, IsActive = true, CurrencyIsoCode = 'GBP'));
        pbe.add(new PricebookEntry(Product2Id = products[3].Id, Pricebook2Id = pb.Id, UnitPrice = 140, IsActive = true, CurrencyIsoCode = 'GBP'));
        try {
            insert pbe;
        } catch (Exception e) {
            System.debug(e);
        }

        System.debug('OPPID :' + opp.Id);

        //Inserting Staff Sale Line
        System.debug('SS ID :' + ss.Id);
        Staff_Sale_Line__c ssl = new Staff_Sale_Line__c(Staff_Sale__c = ss.Id, Product__c = productClones[0].Id, Quantity__c = 10);
        Staff_Sale_Line__c ssl2 = new Staff_Sale_Line__c(Staff_Sale__c = ss2.Id, Product__c = productClones[1].Id, Quantity__c = 10);
        Staff_Sale_Line__c ssl3 = new Staff_Sale_Line__c(Staff_Sale__c = ss.Id, Product__c = productClones[2].Id, Quantity__c = 10);
        Staff_Sale_Line__c ssl4 = new Staff_Sale_Line__c(Staff_Sale__c = ss2.Id, Product__c = productClones[3].Id, Quantity__c = 10);

        ssli.add(ssl);
        ssli.add(ssl2);
        ssli.add(ssl3);
        ssli.add(ssl4);
        insert ssli;

        //Inserting 4 orderLineItems 
        for (Integer i = 0; i < 1; i++) {
            //System.debug('OrdID :' + ord.Id);
            Order_Line__c op = new Order_Line__c(Order__c = ord.Id, Product__c = products[0].Id, Quantity__c = 10);
            Orli.add(op);
        }
//        for (Integer i = 0; i < 1; i++) {
//            System.debug('OrdID :' + ord2.Id);
//            Order_Line__c op = new Order_Line__c(Order__c = ord2.Id, Product__c = products[3].Id, Quantity__c = 10);
//            Orli.add(op);
//        }
        for (Integer i = 0; i < 1; i++) {
            //System.debug('OrdID :' + ord.Id);
            Order_Line__c op = new Order_Line__c(Order__c = ord.Id, Product__c = products[0].Id, Quantity__c = 10);
            Orli.add(op);
        }
        for (Integer i = 0; i < 1; i++) {
            //System.debug('OrdID :' + ord.Id);
            Order_Line__c op = new Order_Line__c(Order__c = ord.Id, Product__c = products[0].Id, Quantity__c = 10);
            Orli.add(op);
        }

        insert Orli;

        //Inserting 4 Price_Enquiry_Line__c
        for (Integer i = 0; i < 1; i++) {
            //System.debug('CorrespondenceID :' + corr.Id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.Id, Product__c = products[0].Id);
            correspondences.add(cp);
        }
        for (Integer i = 0; i < 1; i++) {
            //System.debug('CorrespondenceID :' + corr.Id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.Id, Product__c = products[0].Id);
            correspondences.add(cp);
        }
        for (Integer i = 0; i < 1; i++) {
            //System.debug('CorrespondenceID :' + corr.Id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.Id, Product__c = products[0].Id);
            correspondences.add(cp);
        }
        for (Integer i = 0; i < 1; i++) {
            //System.debug('CorrespondenceID :' + corr.Id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.Id, Product__c = products[0].Id);
            correspondences.add(cp);
        }

        insert correspondences;

        //Inserting 200 opportunityLineItems 
        for (Integer i = 0; i < 50; i++) {
            //System.debug('OPPID :' + opp.Id);
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.Id, UnitPrice = 105.00, PricebookEntryId = pbe[0].Id, IFS_Price__c = 0.0, Quantity = 10);
            oli.add(op);
        }
        for (Integer i = 0; i < 50; i++) {
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.Id, UnitPrice = 105.00, PricebookEntryId = pbe[1].Id, IFS_Price__c = 0.0, Quantity = 10);
            oli.add(op);
        }
        for (Integer i = 0; i < 50; i++) {
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.Id, UnitPrice = 105.00, PricebookEntryId = pbe[2].Id, IFS_Price__c = 0.0, Quantity = 10);
            oli.add(op);
        }
        for (Integer i = 0; i < 50; i++) {
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.Id, UnitPrice = 105.00, PricebookEntryId = pbe[3].Id, IFS_Price__c = 0.0, Quantity = 10);
            oli.add(op);
        }

        insert oli;

        //creating List of 200 QuoteLineItems  
        for (Integer i = 0; i < 50; i++) {
            QuoteLineItem qp = new QuoteLineItem(QuoteId = q.Id, UnitPrice = 105.00, PricebookEntryId = pbe[0].Id, IFS_Price__c = 10, Quantity = 10);
            qli.add(qp);
        }
        for (Integer i = 0; i < 50; i++) {
            QuoteLineItem qp = new QuoteLineItem(QuoteId = q.Id, UnitPrice = 104.00, PricebookEntryId = pbe[1].Id, IFS_Price__c = 10, Quantity = 10);
            qli.add(qp);
        }
        for (Integer i = 0; i < 50; i++) {
            QuoteLineItem qp = new QuoteLineItem(QuoteId = q.Id, UnitPrice = 106.00, PricebookEntryId = pbe[2].Id, IFS_Price__c = 10, Quantity = 10);
            qli.add(qp);
        }
        for (Integer i = 0; i < 50; i++) {
            QuoteLineItem qp = new QuoteLineItem(QuoteId = q2.Id, UnitPrice = 107.00, PricebookEntryId = pbe[3].Id, IFS_Price__c = 10, Quantity = 10);
            qli.add(qp);
        }
        insert qli;
    
    
        // Income Card Payment Data
        
        icp = DataFactory.createICP(100, con, ord);
        insert icp;

        // Base Element Data

        bs = DataFactory.createBS('Generic Service');
        insert bs;

        // Impact Data

        impact = DataFactory.createImpact('4. LOW: Single User affected', false);
        insert impact;

        // Urgency Data
        
        urg = DataFactory.createUrgency('URG_Test', false);
        insert urg;

        // Status Data
        
        status = DataFactory.createStatus('OPENED', false, true);
        insert status;

        status = DataFactory.createStatus('WAITING FOR CUSTOMER', false, true);
        insert status;

        // Priority Data

        priority = DataFactory.createPriority('1', impact, urg);
        insert priority;
    
    }

}