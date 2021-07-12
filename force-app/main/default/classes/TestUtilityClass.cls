/*
 * This class contains the data that is necessary to test OpportunityUpdatePrice, QuoteUpdatePrice, OrderUpdatePrice and CorrUpdatePrice classes.
 * Author : Bhushan Adhikari
 * since  : June 2012
 * E-Mail : badhikari@innoveer.com
 */
@isTest(SeeAllData = True)
public class TestUtilityClass {
    public static Account acc;
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
        schema.describesobjectresult resultAcc = Account.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> accRecTypeId = resultAcc.getrecordtypeinfosbyname();
        Id Direct = accrecTypeId.get('Direct').getrecordtypeid();
        acc = new Account(Name = 'Test Account1',
                        Address_Line_1__c = '7th street Lane',
                        Address_Line_2__c = 'Wing C',
                        Countrynew__c = 'UK',
                        County__c = 'Middlesex',
                        Town__c = 'George Town',
                        PostCode__c = '45613',
                        RecordTypeId = Direct,
                        AccountNumber = '0222/00000',
                        Status1__c = 'Active');
        try{            
            insert acc;
        }
        catch(Exception e){
            system.debug(e);
        }
        //Getting standard PriceBook information
        PriceBook2 pb = [SELECT Id,Name FROM PriceBook2 WHERE Name=:'Standard Price Book' Limit 1];
        
        //Case Data
        schema.describesobjectresult resultCase = Case.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> caseRecTypeId = resultCase.getrecordtypeinfosbyname();
        Id CaseRec = caseRecTypeId.get('Bristan General').getrecordtypeid();
        cs = new Case(Case_Channel__c='Phone',
                            Status='New',
                            Subject='Test Case',
                            RecordTypeId=CaseRec);
                    
            insert cs;
            
        CaseRec = caseRecTypeId.get('Heritage').getrecordtypeid();
        cs2 = new Case(Case_Channel__c='Phone',
                            Status='New',
                            Subject='Test Case2',
                            RecordTypeId=CaseRec);
                    
            insert cs2;
        
        system.debug('CaseID : ' + cs.id);
        
        // Staff Sale Data
        ss = new Staff_Sale__c(Division__c='Bristan',
                            Sales_Type__c='Friends and Family',
                            Delivery_Method__c='Collection',
                            Status__c = 'New');
                            
        insert ss;
        
        ss2 = new Staff_Sale__c(Division__c='Heritage',
                            Sales_Type__c='Staff Sales',
                            Delivery_Method__c='Collection',
                            Status__c = 'New');
                            
        insert ss2;
        
        ss3 = new Staff_Sale__c(Division__c='Bristan',
                            Sales_Type__c='Staff Sales',
                            Delivery_Method__c='Collection',
                            Status__c = 'New');
                            
        insert ss3;
        
        ss4 = new Staff_Sale__c(Division__c='Bristan',
                            Sales_Type__c='Staff Sales',
                            Delivery_Method__c='Collection');
                            
        insert ss4;
        
        // Order Data
        schema.describesobjectresult resultOrd = Order__c.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> ordRecTypeId = resultOrd.getrecordtypeinfosbyname();
        Id OrdRec = ordRecTypeId.get('Standard Order').getrecordtypeid();
        dt = [SELECT Id,Name FROM Delivery_Term__c WHERE Name=:'PST' Limit 1];
        ord = new Order__c(RecordTypeId = OrdRec,
                            Case_Account__c=acc.id,
                            Status__c='Pending',
                            Delivery_Term__c=dt.id,
                            Case__c=cs.id,
                            Ship_Via__c='AM',
                            Order_Type__c='SC',
                            Discount__c='0%',
                            Export_Order__c = true);
                    
            insert ord;
        
        system.debug('OrderID : ' + ord.id);
        
        ord2 = new Order__c(RecordTypeId = OrdRec,
                            Case_Account__c=acc.id,
                            Status__c='Pending',
                            Delivery_Term__c=dt.id,
                            Case__c=cs2.id,
                            Ship_Via__c='AM',
                            Order_Type__c='SC',
                            Discount__c='0%',
                            Export_Order__c = true);
                    
            insert ord2;

        ord3 = new Order__c(RecordTypeId = OrdRec,
                            Case_Account__c=acc.id,
                            Status__c='Pending',
                            Delivery_Term__c=dt.id,
                            Case__c=cs.id,
                            Export_Order__c = true);
                    
            insert ord3;
        
        system.debug('OrderID : ' + ord.id);   
        
        // Income Card Payment
        icp = new Income_Card_Payment__c(Order__c = ord.id);
        insert icp;     

        // Correspondence Data
        schema.describesobjectresult resultCorr = Correspondence__c.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> corrRecTypeId = resultCorr.getrecordtypeinfosbyname();
        Id CorrRec = corrRecTypeId.get('Price Enquiry').getrecordtypeid();
        corr = new Correspondence__c(RecordTypeId = CorrRec,
                            Contact__c='003D000001UGduF', Currency__c = 'GBP');
                    
            insert corr;
        
        system.debug('CorrespondenceID : ' + corr.id);
        
        //Project Data
        schema.describesobjectresult resultProj = Opportunity.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> projRecTypeId = resultProj.getrecordtypeinfosbyname();
        Id ProjRec = projRecTypeId.get('Project').getrecordtypeid();
        proj = new Opportunity(Name='TestProj',
                            RecordTypeId = ProjRec,
                            AccountId=acc.id,
                            CloseDate=system.today(),
                            StageName='New Project',
                            PriceBook2Id= pb.Id,
                            Customer_Order_Number__c = 'Test Order',
                            Division__c = 'Group',
                            LeadSource = 'Glenigan',
                            Estimated_Start_Date__c = date.today(),
                            Estimated_Completion__c = date.today().addDays(60),
                            Initiated_By__c = 'Bristan');
                    
            insert proj;
        
        system.debug('ProjectID : ' + proj.id);
        
        //Opportunity Data
        schema.describesobjectresult resultOpp = Opportunity.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> oppRecTypeId = resultOpp.getrecordtypeinfosbyname();
        Id OppRec = oppRecTypeId.get('Opportunity').getrecordtypeid();
        opp = new Opportunity(Name='TestOpp',
                            RecordTypeId = OppRec,
                            AccountId=acc.id,
                            CloseDate=system.today(),
                            StageName='New Project',
                            PriceBook2Id= pb.Id,
                            Project__c = proj.id,
                            Customer_Order_Number__c = 'Test Order',
                            Division__c = 'Group',
                            LeadSource = 'Glenigan',
                            Estimated_Start_Date__c = date.today(),
                            Estimated_Completion__c = date.today().addDays(60),
                            Initiated_By__c = 'Bristan');
                    
            insert opp;
        
        system.debug('OpportunityID : ' + opp.id);
        
        //Opportunity2 Data
        opp2 = new Opportunity(Name='TestOpp2',
                            RecordTypeId = OppRec,
                            AccountId=acc.id,
                            CloseDate=system.today(),
                            StageName='New Project',
                            PriceBook2Id= pb.Id,
                            Project__c = proj.id,
                            Customer_Order_Number__c = 'Test Order 2',
                            Division__c = 'Group',
                            LeadSource = 'Glenigan',
                            Estimated_Start_Date__c = date.today(),
                            Estimated_Completion__c = date.today().addDays(60),
                            Initiated_By__c = 'Bristan');
                    
            insert opp2;
        
        system.debug('Opportunity2ID : ' + opp2.id);        
        
        //Quote Data
        schema.describesobjectresult resultQuote = Quote.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> qutRecTypeId = resultQuote.getrecordtypeinfosbyname();
        Id Claimback = qutRecTypeId.get('Claimback Quotation').getrecordtypeid();
        q = new Quote(Name= 'TestQuote',opportunityId = opp.id, RecordTypeId= ClaimBack,Pricebook2Id = pb.id, Discount_Perc__c = 10, Expiration_Date__c = date.today().addDays(60) );
        try{            
            insert q;
        }
        catch(Exception e){
            system.debug(e);
        }
        
        q2 = new Quote(Name= 'TestQuote2',opportunityId = opp.id, RecordTypeId= ClaimBack,Pricebook2Id = pb.id, Discount_Perc__c = 10, Expiration_Date__c = date.today().addDays(60) );
        try{            
            insert q2;
        }
        catch(Exception e){
            system.debug(e);
        }
        
        // Inserting Product Data 
        product.add(new Product2(Name='HY PUMP70',ProductCode='HY PUMP70',Site__c = '01', IsActive=true));
        product.add(new Product2(Name='HY PUMP50',ProductCode='HY PUMP50',Site__c = '02', IsActive=true));
        product.add(new Product2(Name='HY PUMP100',ProductCode='HY PUMP100',Site__c = '03', IsActive=true));
        product.add(new Product2(Name='HY PUMP71',ProductCode='HY PUMP71',Site__c = '04', IsActive=true));
        
        try{
            insert product;
        }
        catch(DMLException e){
            system.debug(e);
        }
        
        // Inserting Product Clone Data 
        productC.add(new Product_Clone__c(Name='HY PUMP7012',Site_and_Product_Code__c='01_HY PUMP7012',Product_Code__c='HY PUMP7012',Site__c = '01', 
            Product_Active__c=true));
        productC.add(new Product_Clone__c(Name='HY PUMP7013',Site_and_Product_Code__c='04_HY PUMP7013',Product_Code__c='HY PUMP7013',Site__c = '04', 
            Product_Active__c=true));
        productC.add(new Product_Clone__c(Name='HY PUMP7014',Site_and_Product_Code__c='01_HY PUMP7014',Product_Code__c='HY PUMP7014',Site__c = '01', 
            Product_Active__c=true,Package_Part__c=true,Package_Part_Components__c='RS SHCVO C~1;RS BF C~1;RS BAS C~1'));
        productC.add(new Product_Clone__c(Name='HY PUMP7015',Site_and_Product_Code__c='04_HY PUMP7015',Product_Code__c='HY PUMP7015',Site__c = '04', 
            Product_Active__c=true,Package_Part__c=true,Package_Part_Components__c='RS SHCVO C~1;RS BF C~1;RS BAS C~1'));
        try{
            insert productC;
        }
        catch(DMLException e){
            system.debug('PRODUCT CLONE INSERT FAILED!');
            system.debug(e);
        }
        
        //Inserting Products into StandardPricebook       
        List<PriceBookEntry> pbe = new List<PriceBookEntry>();
        pbe.add(new PriceBookEntry(Product2Id= product[0].id, PriceBook2Id=pb.id,UnitPrice=100,IsActive=True,CurrencyIsoCode='GBP'));
        pbe.add(new PriceBookEntry(Product2Id= product[1].id, PriceBook2Id=pb.id,UnitPrice=150,IsActive=True,CurrencyIsoCode='GBP'));
        pbe.add(new PriceBookEntry(Product2Id= product[2].id, PriceBook2Id=pb.id,UnitPrice=160,IsActive=True,CurrencyIsoCode='GBP'));
        pbe.add(new PriceBookEntry(Product2Id= product[3].id, PriceBook2Id=pb.id,UnitPrice=140,IsActive=True,CurrencyIsoCode='GBP'));
        try{
            insert pbe;
        }
        catch(Exception e){
        system.debug(e);}
        
        system.debug('OPPID :' + opp.id);

        //Inserting Staff Sale Line
        system.debug('SS ID :' + ss.id);
        Staff_Sale_Line__c ssl = new Staff_Sale_Line__c(Staff_Sale__c = ss.id,Product__c=productC[0].id,Quantity__c=10);
        Staff_Sale_Line__c ssl2 = new Staff_Sale_Line__c(Staff_Sale__c = ss2.id,Product__c=productC[1].id,Quantity__c=10);
        Staff_Sale_Line__c ssl3 = new Staff_Sale_Line__c(Staff_Sale__c = ss.id,Product__c=productC[2].id,Quantity__c=10);
        Staff_Sale_Line__c ssl4 = new Staff_Sale_Line__c(Staff_Sale__c = ss2.id,Product__c=productC[3].id,Quantity__c=10);
        ssli.add(ssl);
        ssli.add(ssl2);
        ssli.add(ssl3);
        ssli.add(ssl4);
        insert ssli;

        //Inserting 4 orderLineItems 
        for(Integer i=0; i<1; i++)
        {
            system.debug('OrdID :' + ord.id);
            Order_Line__c op = new Order_Line__c(Order__c = ord.id,Product__c=product[0].id,Quantity__c=10);
            Orli.add(op);
        }
        for(Integer i=0; i<1; i++)
        {
            system.debug('OrdID :' + ord2.id);
            Order_Line__c op = new Order_Line__c(Order__c = ord2.id,Product__c=product[3].id,Quantity__c=10);
            Orli.add(op);
        }
        for(Integer i=0; i<1; i++)
        {
            system.debug('OrdID :' + ord.id);
            Order_Line__c op = new Order_Line__c(Order__c = ord.id,Product__c=product[0].id,Quantity__c=10);
            Orli.add(op);
        }
        for(Integer i=0; i<1; i++)
        {
            system.debug('OrdID :' + ord.id);
            Order_Line__c op = new Order_Line__c(Order__c = ord.id,Product__c=product[0].id,Quantity__c=10);
            Orli.add(op);
        }               
        
        insert Orli; 

       //Inserting 4 Price_Enquiry_Line__c
        for(Integer i=0; i<1; i++)
        {
            system.debug('CorrespondenceID :' + corr.id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.id,Product__c=product[0].id);
            corrli.add(cp);
        }
        for(Integer i=0; i<1; i++)
        {
            system.debug('CorrespondenceID :' + corr.id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.id,Product__c=product[0].id);
            corrli.add(cp);
        }
        for(Integer i=0; i<1; i++)
        {
            system.debug('CorrespondenceID :' + corr.id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.id,Product__c=product[0].id);
            corrli.add(cp);
        }
        for(Integer i=0; i<1; i++)
        {
            system.debug('CorrespondenceID :' + corr.id);
            Price_Enquiry_Line__c cp = new Price_Enquiry_Line__c(Correspondence__c = corr.id,Product__c=product[0].id);
            corrli.add(cp);
        }               
        
        insert corrli;      
        
        //Inserting 200 opportunityLineItems 
        for(Integer i=0; i<50; i++)
        {
            system.debug('OPPID :' + opp.id);
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.id,unitPrice = 105.00,PriceBookEntryId= pbe[0].id,IFS_Price__c=0.0,Quantity=10);
            Oli.add(op);
        }
        for(Integer i=0; i<50; i++)
        {
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.id,unitPrice = 105.00,PriceBookEntryId= pbe[1].id,IFS_Price__c=0.0,Quantity=10);
            Oli.add(op);
        }
        for(Integer i=0; i<50; i++)
        {
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.id,unitPrice = 105.00,PriceBookEntryId= pbe[2].id,IFS_Price__c=0.0,Quantity=10);
            Oli.add(op);
        }
        for(Integer i=0; i<50; i++)
        {
            OpportunityLineItem op = new OpportunityLineItem(OpportunityId = opp.id,unitPrice = 105.00,PriceBookEntryId= pbe[3].id,IFS_Price__c=0.0,Quantity=10);
            Oli.add(op);
        }
        
        insert Oli; 
        
        //creating List of 200 QuoteLineItems  
        for(Integer i=0; i<50; i++)
        {
            QuoteLineItem qp = new QuoteLineItem(Quoteid = q.id,unitPrice = 105.00,PriceBookEntryId= pbe[0].id,IFS_Price__c=10,Quantity=10);
            Qli.add(qp);
        }
        for(Integer i=0; i<50; i++)
        {
            QuoteLineItem qp = new QuoteLineItem(Quoteid = q.id,unitPrice = 104.00,PriceBookEntryId= pbe[1].id,IFS_Price__c=10,Quantity=10);
            Qli.add(qp);
        }
        for(Integer i=0; i<50; i++)
        {
            QuoteLineItem qp = new QuoteLineItem(Quoteid = q.id,unitPrice = 106.00,PriceBookEntryId= pbe[2].id,IFS_Price__c=10,Quantity=10);
            Qli.add(qp);
        }
        for(Integer i=0; i<50; i++)
        {
            QuoteLineItem qp = new QuoteLineItem(Quoteid = q2.id,unitPrice = 107.00,PriceBookEntryId= pbe[3].id,IFS_Price__c=10,Quantity=10);
            Qli.add(qp);
        }        
        insert Qli;                 
    }
}