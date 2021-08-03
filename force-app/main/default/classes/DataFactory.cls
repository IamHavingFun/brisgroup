global class DataFactory {

    public static User createAdminUser(String userName) {
        Profile prof = [SELECT Id FROM Profile WHERE Name LIKE '%administrator%' LIMIT 1];
        return new User(
                FirstName = 'testFirstName',
                LastName = 'testLastName',
                ProfileId = prof.Id,
                Username = userName,
                Email = 'test@test.bristan.com',
                Alias = 'aliasTxt',
                EmailEncodingKey='UTF-8',
                LanguageLocaleKey='en_US',
                LocaleSidKey='en_US',
                TimeZoneSidKey='America/Los_Angeles'
        );
    }

    public static Account createAccount(String accountName) {
        return new Account( 
                Name = accountName,
                Address_Line_1__c = '7th street Lane',
                Address_Line_2__c = 'Wing C',
                Countrynew__c = 'UK',
                County__c = 'Middlesex',
                Town__c = 'George Town',
                Postcode__c = '45613',
                RecordTypeId = getAccountRecordTypeId('Indirect'),
                AccountNumber = '0222/00000',
                Status1__c = 'Active'
        );
    }

    public static Contact createContact(String firstName, String lastName, Account acc) {
        return new Contact(
            FirstName = firstName,
            LastName = lastName,
            AccountId = acc.Id
        );
    }

    public static Case createCase(String subject) {
        return new Case(
            Case_Channel__c = 'Phone',
            Status = 'New',
            Subject = subject,
            RecordTypeId = getCaseRecordTypeId('Bristan General')
        );
    }

    public static Order__c createOrder(Account acc, Delivery_Term__c dt, Case cs) {
        return new Order__c(
                RecordTypeId = getOrderRecordTypeId('Standard Order'),
                Case_Account__c = acc.Id,
                Status__c = 'Pending',
                Delivery_Term__c = dt.Id,
                Case__c = cs.Id,
                Export_Order__c = true
        );
    }

    public static Opportunity createProject(String name, Account acc, Pricebook2 pb) {
        return new Opportunity(
                Name = name,
                RecordTypeId = getOpportunityRecordTypeId('Project'),
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
    }

    public static Opportunity createOpportunity(String name, Account acc, Opportunity proj, Pricebook2 pb) {
        return new Opportunity(
                Name = name,
                RecordTypeId = getOpportunityRecordTypeId('Opportunity'),
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
    }


    public static Income_Card_Payment__c createICP(Integer immediateAmount, Contact con, Order__c ord){
        return new Income_Card_Payment__c(
            Immediate_Amount__c = immediateAmount,
            Contact__c = con.Id,
            Payment_Status__c = 'Authorised',
            Card_Type__c  = '',
            Authorisation_Date__c  = Date.today(),
            Transaction_Type__c  = 'Sale',
            Order__c = ord.Id
        );

    }

    public static BMCServiceDesk__BMC_BaseElement__c createBS(String name){
        return new BMCServiceDesk__BMC_BaseElement__c(
            BMCServiceDesk__Name__c = 'Generic Service'
        );
    }

    public static BMCServiceDesk__Impact__c createImpact(String name, Boolean inactive){
        return new BMCServiceDesk__Impact__c(
            Name = name,
            BMCServiceDesk__inactive__c = inactive
        );
    }
        
    public static BMCServiceDesk__Urgency__c createUrgency(String name, Boolean inactive){
        return new BMCServiceDesk__Urgency__c(
            Name = name,
            BMCServiceDesk__inactive__c = inactive
        );
    }

    public static BMCServiceDesk__Status__c createStatus(String name, Boolean inactive, Boolean appliesToIncident){
        return new BMCServiceDesk__Status__c(
            Name = name,
            BMCServiceDesk__inactive__c = inactive,
            BMCServiceDesk__appliesToIncident__c = appliesToIncident,
            BMCServiceDesk__appliesToChange__c = true
        );
    }
        
    public static BMCServiceDesk__Priority__c createPriority(String name, BMCServiceDesk__Impact__c impact, BMCServiceDesk__Urgency__c urgency){
        return new BMCServiceDesk__Priority__c(
            Name = name,
            BMCServiceDesk__description__c = 'Priority Test',
            BMCServiceDesk__FKImpact__c = impact.Id,
            BMCServiceDesk__FKUrgency__c = urgency.Id
        );
    }

    public static Id getCaseRecordTypeId(String name) {
        schema.DescribeSObjectResult resultCase = Case.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> caseRecTypeId = resultCase.getRecordTypeInfosByName();
        return caseRecTypeId.get(name).getRecordTypeId();
    }

    public static Id getAccountRecordTypeId(String name) {
        schema.DescribeSObjectResult resultAcc = Account.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> accRecTypeId = resultAcc.getRecordTypeInfosByName();
        return accRecTypeId.get(name).getRecordTypeId();
    }

    public static Id getOrderRecordTypeId(String name) {
        schema.DescribeSObjectResult resultOrd = Order__c.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> ordRecTypeId = resultOrd.getRecordTypeInfosByName();
        return ordRecTypeId.get(name).getRecordTypeId();
    }

    public static Id getOpportunityRecordTypeId(String name) {
        schema.DescribeSObjectResult resultOpp = Opportunity.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> oppRecTypeId = resultOpp.getRecordTypeInfosByName();
        return oppRecTypeId.get(name).getRecordTypeId();
    }

    public static Id getQuoteRecordTypeId(String name) {
        schema.DescribeSObjectResult resultQuote = Quote.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> qutRecTypeId = resultQuote.getRecordTypeInfosByName();
        return qutRecTypeId.get(name).getRecordTypeId();
    }

    public static Id getCorrespondenceRecordTypeId(String name) {
        schema.DescribeSObjectResult resultCorr = Correspondence__c.SObjectType.getDescribe();
        Map<String, schema.RecordTypeInfo> corrRecTypeId = resultCorr.getRecordTypeInfosByName();
        return corrRecTypeId.get(name).getRecordTypeId();
    }



}