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
    public static List<Product2> product = new List<Product2>();
    public static List<Product_Clone__c> productC = new List<Product_Clone__c>();
    public static Quote q;
    public static Quote q2;
    public static List<QuoteLineItem> Qli = new List<QuoteLineItem>();
    public static List<OpportunityLineItem> Oli = new List<OpportunityLineItem>();
    public static List<Order_Line__c> Orli = new List<Order_Line__c>();
    public static List<Staff_Sale_Line__c> ssli = new List<Staff_Sale_Line__c>();
    public static Correspondence__c corr;
    public static List<Price_Enquiry_Line__c> corrli = new List<Price_Enquiry_Line__c>();
    public static Income_Card_Payment__c icp;
    public static void setUpData() {
        //Account Data
        schema.DescribeSObjectResult resultAcc = Account.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> accRecTypeId = resultAcc.getRecordTypeInfosByName();
        Id Direct = accRecTypeId.get('Indirect').getRecordTypeId();
        acc = new Account(Name = 'Test Account1',
                Address_Line_1__c = '7th street Lane',
                Address_Line_2__c = 'Wing C',
                Countrynew__c = 'UK',
                County__c = 'Middlesex',
                Town__c = 'George Town',
                Postcode__c = '45613',
                RecordTypeId = Direct,
                AccountNumber = '0222/00000',
                Status1__c = 'Active');
        try {
            insert acc;
        } catch (Exception e) {
            System.debug(e);
        }
        con = new Contact(FirstName = 'Steve',
                LastName = 'Mason',
                AccountId = acc.Id);
        try {
            insert con;
        } catch (Exception e) {
            System.debug(e);
        }
        //Getting standard PriceBook information
        Pricebook2 pb = [SELECT Id,Name FROM Pricebook2 WHERE Name = :'Standard Price Book' LIMIT 1];

        //Case Data
        schema.DescribeSObjectResult resultCase = Case.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> caseRecTypeId = resultCase.getRecordTypeInfosByName();
        Id CaseRec = caseRecTypeId.get('Bristan General').getRecordTypeId();
        cs = new Case(Case_Channel__c = 'Phone',
                Status = 'New',
                Subject = 'Test Case',
                RecordTypeId = CaseRec);

        insert cs;

        CaseRec = caseRecTypeId.get('Heritage').getRecordTypeId();
        cs2 = new Case(Case_Channel__c = 'Phone',
                Status = 'New',
                Subject = 'Test Case2',
                RecordTypeId = CaseRec);

        insert cs2;

        System.debug('CaseID : ' + cs.Id);

        // Staff Sale Data
        ss = new Staff_Sale__c(Division__c = 'Bristan',
                Sales_Type__c = 'Friends and Family',
                Delivery_Method__c = 'Collection',
                Status__c = 'New');

        insert ss;

        ss2 = new Staff_Sale__c(Division__c = 'Heritage',
                Sales_Type__c = 'Staff Sales',
                Delivery_Method__c = 'Collection',
                Status__c = 'New');

        insert ss2;

        ss3 = new Staff_Sale__c(Division__c = 'Bristan',
                Sales_Type__c = 'Staff Sales',
                Delivery_Method__c = 'Collection',
                Status__c = 'New');

        insert ss3;

        ss4 = new Staff_Sale__c(Division__c = 'Bristan',
                Sales_Type__c = 'Staff Sales',
                Delivery_Method__c = 'Collection');

        insert ss4;

        // Order Data
        schema.DescribeSObjectResult resultOrd = Order__c.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> ordRecTypeId = resultOrd.getRecordTypeInfosByName();
        Id OrdRec = ordRecTypeId.get('Standard Order').getRecordTypeId();
        dt = [SELECT Id,Name FROM Delivery_Term__c WHERE Name = :'PST' LIMIT 1];
        ord = new Order__c(RecordTypeId = OrdRec,
                Case_Account__c = acc.Id,
                Status__c = 'Pending',
                Delivery_Term__c = dt.Id,
                Case__c = cs.Id,
                Ship_Via__c = 'AM',
                Order_Type__c = 'SC',
                Discount__c = '0%',
                Export_Order__c = true);

        insert ord;

        System.debug('OrderID : ' + ord.Id);

        ord2 = new Order__c(RecordTypeId = OrdRec,
                Case_Account__c = acc.Id,
                Status__c = 'Pending',
                Delivery_Term__c = dt.Id,
                Case__c = cs2.Id,
                Ship_Via__c = 'AM',
                Order_Type__c = 'SC',
                Discount__c = '0%',
                Export_Order__c = true);

        insert ord2;

        ord3 = new Order__c(RecordTypeId = OrdRec,
                Case_Account__c = acc.Id,
                Status__c = 'Pending',
                Delivery_Term__c = dt.Id,
                Case__c = cs.Id,
                Export_Order__c = true);

        insert ord3;

        System.debug('OrderID : ' + ord.Id);

        // Income Card Payment
        icp = new Income_Card_Payment__c(Order__c = ord.Id);
        insert icp;

        // Correspondence Data
        schema.DescribeSObjectResult resultCorr = Correspondence__c.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> corrRecTypeId = resultCorr.getRecordTypeInfosByName();
        Id CorrRec = corrRecTypeId.get('Price Enquiry').getRecordTypeId();
        corr = new Correspondence__c(RecordTypeId = CorrRec,
                Contact__c = con.Id, Currency__c = 'GBP');

        insert corr;

        System.debug('CorrespondenceID : ' + corr.Id);

        //Project Data
        schema.DescribeSObjectResult resultProj = Opportunity.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> projRecTypeId = resultProj.getRecordTypeInfosByName();
        Id ProjRec = projRecTypeId.get('Project').getRecordTypeId();
        proj = new Opportunity(Name = 'TestProj',
                RecordTypeId = ProjRec,
                AccountId = acc.Id,
                CloseDate = System.today(),
                StageName = 'New Project',
                Pricebook2Id = pb.Id,
                Customer_Order_Number__c = 'Test Order',
                Division__c = 'Group',
                LeadSource = 'Glenigan',
                Estimated_Start_Date__c = Date.today(),
                Estimated_Completion__c = Date.today().addDays(60),
                Initiated_By__c = 'Bristan');

        insert proj;

        System.debug('ProjectID : ' + proj.Id);

        //Opportunity Data
        schema.DescribeSObjectResult resultOpp = Opportunity.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> oppRecTypeId = resultOpp.getRecordTypeInfosByName();
        Id OppRec = oppRecTypeId.get('Opportunity').getRecordTypeId();
        opp = new Opportunity(Name = 'TestOpp',
                RecordTypeId = OppRec,
                AccountId = acc.Id,
                CloseDate = System.today(),
                StageName = 'New Project',
                Pricebook2Id = pb.Id,
                Project__c = proj.Id,
                Customer_Order_Number__c = 'Test Order',
                Division__c = 'Group',
                LeadSource = 'Glenigan',
                Estimated_Start_Date__c = Date.today(),
                Estimated_Completion__c = Date.today().addDays(60),
                Initiated_By__c = 'Bristan');

        insert opp;

        System.debug('OpportunityID : ' + opp.Id);

        //Opportunity2 Data
        opp2 = new Opportunity(Name = 'TestOpp2',
                RecordTypeId = OppRec,
                AccountId = acc.Id,
                CloseDate = System.today(),
                StageName = 'New Project',
                Pricebook2Id = pb.Id,
                Project__c = proj.Id,
                Customer_Order_Number__c = 'Test Order 2',
                Division__c = 'Group',
                LeadSource = 'Glenigan',
                Estimated_Start_Date__c = Date.today(),
                Estimated_Completion__c = Date.today().addDays(60),
                Initiated_By__c = 'Bristan');

        insert opp2;

        System.debug('Opportunity2ID : ' + opp2.Id);

        //Quote Data
        schema.DescribeSObjectResult resultQuote = Quote.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> qutRecTypeId = resultQuote.getRecordTypeInfosByName();
        //Id Claimback = qutRecTypeId.get('Claimback Quotation').getrecordtypeid();
        Id ClaimBack = qutRecTypeId.get('Special Price').getRecordTypeId();
        q = new Quote(Name = 'TestQuote', OpportunityId = opp.Id, RecordTypeId = ClaimBack, Pricebook2Id = pb.Id, Discount_Perc__c = 10, Expiration_Date__c = Date.today().addDays(60));
        try {
            insert q;
        } catch (Exception e) {
            System.debug(e);
        }

        q2 = new Quote(Name = 'TestQuote2', OpportunityId = opp.Id, RecordTypeId = ClaimBack, Pricebook2Id = pb.Id, Discount_Perc__c = 10, Expiration_Date__c = Date.today().addDays(60));
        try {
            insert q2;
        } catch (Exception e) {
            System.debug(e);
        }

        // Inserting Product Data 
        product.add(new Product2(Name = 'HY PUMP70', ProductCode = 'HY PUMP70', Site__c = '01', IsActive = true));
        product.add(new Product2(Name = 'HY PUMP50', ProductCode = 'HY PUMP50', Site__c = '02', IsActive = true));
        product.add(new Product2(Name = 'HY PUMP100', ProductCode = 'HY PUMP100', Site__c = '03', IsActive = true));
        product.add(new Product2(Name = 'HY PUMP71', ProductCode = 'HY PUMP71', Site__c = '04', IsActive = true));

        try {
            insert product;
        } catch (DmlException e) {
            System.debug(e);
        }

        // Inserting Product Clone Data 
        productC.add(new Product_Clone__c(Name = 'HY PUMP7012', Site_and_Product_Code__c = '01_HY PUMP7012', Product_Code__c = 'HY PUMP7012', Site__c = '01',
                Product_Active__c = true));
        productC.add(new Product_Clone__c(Name = 'HY PUMP7013', Site_and_Product_Code__c = '04_HY PUMP7013', Product_Code__c = 'HY PUMP7013', Site__c = '04',
                Product_Active__c = true));
        productC.add(new Product_Clone__c(Name = 'HY PUMP7014', Site_and_Product_Code__c = '01_HY PUMP7014', Product_Code__c = 'HY PUMP7014', Site__c = '01',
                Product_Active__c = true, Package_Part__c = true, Package_Part_Components__c = 'RS SHCVO C~1;RS BF C~1;RS BAS C~1'));
        productC.add(new Product_Clone__c(Name = 'HY PUMP7015', Site_and_Product_Code__c = '04_HY PUMP7015', Product_Code__c = 'HY PUMP7015', Site__c = '04',
                Product_Active__c = true, Package_Part__c = true, Package_Part_Components__c = 'RS SHCVO C~1;RS BF C~1;RS BAS C~1'));
        try {
            insert productC;
        } catch (DmlException e) {
            System.debug('PRODUCT CLONE INSERT FAILED!');
            System.debug(e);
        }

        //Inserting Products into StandardPricebook       
        List<PricebookEntry> pbe = new List<PricebookEntry>();
        pbe.add(new PricebookEntry(Product2Id = product[0].Id, Pricebook2Id = pb.Id, UnitPrice = 100, IsActive = true, CurrencyIsoCode = 'GBP'));
        pbe.add(new PricebookEntry(Product2Id = product[1].Id, Pricebook2Id = pb.Id, UnitPrice = 150, IsActive = true, CurrencyIsoCode = 'GBP'));
        pbe.add(new PricebookEntry(Product2Id = product[2].Id, Pricebook2Id = pb.Id, UnitPrice = 160, IsActive = true, CurrencyIsoCode = 'GBP'));
        pbe.add(new PricebookEntry(Product2Id = product[3].Id, Pricebook2Id = pb.Id, UnitPrice = 140, IsActive = true, CurrencyIsoCode = 'GBP'));
        try {
            insert pbe;
        } catch (Exception e) {
            System.debug(e);
        }

        System.debug('OPPID :' + opp.Id);

        //Inserting Staff Sale Line
        System.debug('SS ID :' + ss.Id);
        Staff_Sale_Line__c ssl = new Staff_Sale_Line__c(Staff_Sale__c = ss.Id, Product__c = productC[0].Id, Quantity__c = 10);
        Staff_Sale_Line__c ssl2 = new Staff_Sale_Line__c(Staff_Sale__c = ss2.Id, Product__c = productC[1].Id, Quantity__c = 10);
        Staff_Sale_Line__c ssl3 = new Staff_Sale_Line__c(Staff_Sale__c = ss.Id, Product__c = productC[2].Id, Quantity__c = 10);
        Staff_Sale_Line__c ssl4 = new Staff_Sale_Line__c(Staff_Sale__c = ss2.Id, Product__c = productC[3].Id, Quantity__c = 10);
        ssli.add(ssl);
        ssli.add(ssl2);
        ssli.add(ssl3);
        ssli.add(ssl4);
        insert ssli;

        //Inserting 4 orderLineItems 
        for (Integer i = 0; i < 1; i++) {
            System.debug('OrdID :' + ord.Id);
            Order_Line__c op = new Order_Line__c(Order__c = ord.Id, Product__c = product[0].Id, Quantity__c = 10);
            Orli.add(op);
        }
        for (Integer i = 0; i < 1; i++) {
            System.debug('OrdID :' + ord2.Id);
            Order_Line__c op = new Order_Line__c(Order__c = ord2.Id, Product__c = product[3].Id, Quantity__c = 10);
            Orli.add(op);
        }
        for (Integer i = 0; i < 1; i++) {
            System.debug('OrdID :' + ord.Id);
            Order_Line__c op = new Order_Line__c(Order__c = ord.Id, Product__c = product[0].Id, Quantity__c = 10);
            Orli.add(op);
        }
        for (Integer i = 0; i < 1; i++) {
            System.debug('OrdID :' + ord.Id);
            Order_Line__c op = new Order_Line__c(Order__c = ord.Id, Product__c = product[0].Id, Quantity__c = 10);
            Orli.add(op);
        }

        insert Orli;

        //Inserting 4 Price_Enquiry_Line__c
        for (Integer i = 0; i < 1; i++) {
            System.debug('CorrespondenceID :' + corr.Id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.Id, Product__c = product[0].Id);
            corrli.add(cp);
        }
        for (Integer i = 0; i < 1; i++) {
            System.debug('CorrespondenceID :' + corr.Id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.Id, Product__c = product[0].Id);
            corrli.add(cp);
        }
        for (Integer i = 0; i < 1; i++) {
            System.debug('CorrespondenceID :' + corr.Id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.Id, Product__c = product[0].Id);
            corrli.add(cp);
        }
        for (Integer i = 0; i < 1; i++) {
            System.debug('CorrespondenceID :' + corr.Id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.Id, Product__c = product[0].Id);
            corrli.add(cp);
        }

        insert corrli;

        //Inserting 200 opportunityLineItems 
        for (Integer i = 0; i < 50; i++) {
            System.debug('OPPID :' + opp.Id);
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.Id, UnitPrice = 105.00, PricebookEntryId = pbe[0].Id, IFS_Price__c = 0.0, Quantity = 10);
            Oli.add(op);
        }
        for (Integer i = 0; i < 50; i++) {
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.Id, UnitPrice = 105.00, PricebookEntryId = pbe[1].Id, IFS_Price__c = 0.0, Quantity = 10);
            Oli.add(op);
        }
        for (Integer i = 0; i < 50; i++) {
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.Id, UnitPrice = 105.00, PricebookEntryId = pbe[2].Id, IFS_Price__c = 0.0, Quantity = 10);
            Oli.add(op);
        }
        for (Integer i = 0; i < 50; i++) {
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.Id, UnitPrice = 105.00, PricebookEntryId = pbe[3].Id, IFS_Price__c = 0.0, Quantity = 10);
            Oli.add(op);
        }

        insert Oli;

        //creating List of 200 QuoteLineItems  
        for (Integer i = 0; i < 50; i++) {
            QuoteLineItem qp = new QuoteLineItem(QuoteId = q.Id, UnitPrice = 105.00, PricebookEntryId = pbe[0].Id, IFS_Price__c = 10, Quantity = 10);
            Qli.add(qp);
        }
        for (Integer i = 0; i < 50; i++) {
            QuoteLineItem qp = new QuoteLineItem(QuoteId = q.Id, UnitPrice = 104.00, PricebookEntryId = pbe[1].Id, IFS_Price__c = 10, Quantity = 10);
            Qli.add(qp);
        }
        for (Integer i = 0; i < 50; i++) {
            QuoteLineItem qp = new QuoteLineItem(QuoteId = q.Id, UnitPrice = 106.00, PricebookEntryId = pbe[2].Id, IFS_Price__c = 10, Quantity = 10);
            Qli.add(qp);
        }
        for (Integer i = 0; i < 50; i++) {
            QuoteLineItem qp = new QuoteLineItem(QuoteId = q2.Id, UnitPrice = 107.00, PricebookEntryId = pbe[3].Id, IFS_Price__c = 10, Quantity = 10);
            Qli.add(qp);
        }
        insert Qli;
    }
}