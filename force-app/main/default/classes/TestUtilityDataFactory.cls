/**
 * @author PolSource
 * @since 2021.07.23
 * @description provides helper methods to create test records used on test classes
 */
@IsTest
public with sharing class TestUtilityDataFactory {

    /**
     * @param profileName 
     * @param alias 
     * @return  `User`
     */
    public static User insertSystemUser(String profileName, String alias) {
        // get Profile Id based on its Name
        Profile profile = [SELECT Id FROM Profile WHERE Name = :profileName];
        // create user record
        User u = new User(
            Alias = alias, 
            Email = alias + '@testorg.com', 
            EmailEncodingKey = 'UTF-8',
            FirstName = alias.toUpperCase(),
            LastName = alias.toUpperCase(),
            LanguageLocaleKey = 'en_US', 
            LocaleSidKey = 'en_US',
            ProfileId = profile.Id, 
            TimeZoneSidKey = 'America/Los_Angeles', 
            UserName = alias + '@testorg.com');
        insert u;
        return u;
    }

    /**
     * @param userId user to be assigned
     * @param permissionSetName permission set name to assign
     */
    public static void assignUserToPermissionSet(String userId, String permissionSetName) {
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = :permissionSetName LIMIT 1];
        PermissionSetAssignment psa =  new PermissionSetAssignment(AssigneeId = userId, PermissionSetId = ps.Id);
        insert psa;
    }

    /**
     * 
     * @param recordTypeName 
     * @return  `Carrier_Approval_System__c`
     */
    public static Carrier_Approval_System__c createNextDayApprovalSystem(String recordTypeName) {
        // get record type Id based on its name
        Id recordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = :recordTypeName AND SObjectType = 'Carrier_Approval_System__c'].Id;
        // create and return new Approval System record
        return new Carrier_Approval_System__c(
            RecordTypeId = recordTypeId,
            Status__c = 'New',
            Service__c = 'Next Day',
            Type__c = 'Personal'
        );
    }

    /**
     * @return  `Product__c`
     */
    public static Product__c createProduct() {
        return new Product__c(
            Status__c = 'Complete'
        );
    }

    /**
     * @param salesGroupName 
     * @param key 
     * @param name 
     * @return  `Sales_Group__c`
     */
    public static Sales_Group__c createSalesGroup(String salesGroupName, String key, String name) {
        //  Create Sales Group
        return new Sales_Group__c(
            Key__c = key,
            Name = name,
            Sales_Group_Name__c = salesGroupName);
    }

    /**
     * @param supplierName 
     * @param key 
     * @param name 
     * @return  `Supplier__c`
     */
    public static Supplier__c createSupplier(String supplierName, String key, String name) {
        //  Create Supplier
        return new Supplier__c(
            Key__c = key,
            Name = name,
            Supplier_Name__c = supplierName);
    }


    /**
     * @param prodId 
     * @param type 
     * @param notes 
     * @param status 
     * @return  `ECN__c`
     */
    public static ECN__c createECN(String prodId, String type, String notes, String status) {
        return new ECN__c(
            Product__c = prodId,
            Type__c = type,
            Notes__c = notes,
            Status__c = status,
            Effective_Date__c = Date.today(),
            Value_of_Obsolete_Stock__c = 10,
            Quantity_of_Obsolete_Stock__c = 10,
            Last_Sales_Date__c = Date.today()
        );
    }

    /**
     * @param recordTypeDevName 
     * @return  `Case`
     */
    public static Case createCase(String recordTypeDevName) {
        Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(recordTypeDevName).getRecordTypeId();
        return new Case(
            Subject = 'Test Case',
            RecordTypeId = recordTypeId
        );
    }

    /**
     * 
     * @param caseRecordType Record Type Developer Name
     * @param commentNumber Total number of comment records to create
     * @return  `Case`
     */
    public static Case insertCaseWithComments(String caseRecordType, Integer commentNumber) {
        Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(caseRecordType).getRecordTypeId();
        Case caseTest = new Case(
            Subject = 'Test Case',
            RecordTypeId = recordTypeId
        );
        insert caseTest;
        // List of comments
        List<CaseComment> comments = new List<CaseComment>();
        for (Integer i = 0; i < commentNumber; i++) {
            CaseComment comment = new CaseComment(
                ParentId = caseTest.Id,
                CommentBody = 'Test Comment #' + i
            );
            comments.add(comment);
        }
        if (!comments.isEmpty()) {
            insert comments;
        }
        return caseTest;
    }

    /**
     * @return  `Contact`
     */
    public static Contact createPersonContact() {
        Id recordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'PersonAccount' AND SObjectType = 'Account'].Id;
        Account personAccount = new Account(
            RecordTypeId = recordTypeId,
            FirstName = 'Test',
            LastName = 'Test',
            PersonMailingStreet = 'Test Street',
            PersonMailingPostalCode = '12345',
            PersonMailingCity = 'SFO',
            PersonEmail = 'test@bristangroup.com',
            PersonHomePhone = '1234567',
            PersonMobilePhone = '12345678');
        insert personAccount;
        return [SELECT Id, AccountId FROM Contact WHERE LastName = 'Test'];
    }

    /**
     * 
     * @return  `Contact`
     */
    public static Contact createContact() {
        return new Contact(LastName = 'Test');
    }

    /**
     * @return  `Account`
     */
    public static Account createPersonAccount() {
        Id recordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'PersonAccount' AND SObjectType = 'Account'].Id;
        return new Account(
            RecordTypeId = recordTypeId,
            FirstName = 'Test',
            LastName = 'Test',
            PersonMailingStreet = 'Test Street',
            PersonMailingPostalCode = '12345',
            PersonMailingCity = 'SFO',
            PersonEmail = 'test@bristangroup.com',
            PersonHomePhone = '1234567',
            PersonMobilePhone = '12345678');        
    }

    /**
     * @param recordTypeName 
     * @return  `Account`
     */
    public static Account createBusinessAccount(String recordTypeName) {
        Id accountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();
        return new Account(
            RecordTypeId = accountRecordTypeId,
            Name = 'Test BA'
        );
    }

    /**
     * 
     * @param orderRecordType 
     * @param status 
     * @param accountId 
     * @param totalOrders 
     */
    public static void insertOrderRecordsForAccount(String orderRecordType, String status, String accountId, Integer totalOrders) {
        Id orderRecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByDeveloperName().get(orderRecordType).getRecordTypeId();
        Delivery_Term__c deliveryTerm = TestDataCreation.CreateDeliveryTermPST();
        List<Order__c> orders = new List<Order__c>();
        for (Integer i = 0; i < totalOrders; i++) {
            Order__c order = new Order__c(
                RecordTypeId = orderRecordTypeId,
                Case_Account__c = accountId,
                Status__c = status,
                Delivery_Term__c = deliveryTerm.id);
            orders.add(order);
        }
        if (!orders.isEmpty()) {
            insert orders;
        }
    }

    /**
     * 
     * @param totalRecords 
     * @param contactId 
     */
    public static void insertWarrantyRecordsForAccount(Integer totalRecords, String contactId) {
        List<Warranty__c> warranties = new List<Warranty__c>();
        for (Integer i = 0; i < totalRecords; i++) {
            warranties.add(new Warranty__c(Name = 'Test #' + i, Contact__c = contactId));
        }
        if (!warranties.isEmpty()) {
            insert warranties;
        }
    }

    /**
     * 
     * @param totalRecords 
     * @param accountId 
     * @param contactId 
     */
    public static void insertCasesForAccount(Integer totalRecords, String accountId, String contactId) {
        List<Case> cases = new List<Case>();
        for (Integer i = 0; i < totalRecords; i++) {
            cases.add(new Case(
                Subject = 'Test #' + i,
                Description = 'Test #' + i,
                Status = 'New', 
                AccountId = accountId, 
                ContactId = contactId)
            );
        }
        if (!cases.isEmpty()) {
            insert cases;
        }
    }

    /**
     * 
     * @param totalRecords 
     * @param contactId 
     */
    public static void insertCallsForAccount(Integer totalRecords, String contactId) {
        List<Calls__c> calls = new List<Calls__c>();
        for (Integer i = 0; i < totalRecords; i++) {
            calls.add(new Calls__c(
                Name = 'Test #' + i, 
                Contact__c = contactId)
            );
        }
        if (!calls.isEmpty()) {
            insert calls;
        }
    }

    /**
     * 
     * @param totalRecords 
     * @param contactId 
     */
    public static void insertChatsForContact(Integer totalRecords, String contactId) {
        List<LiveChatTranscript> chats = new List<LiveChatTranscript>();
        LiveChatVisitor chatVisitor = new LiveChatVisitor();
        insert chatVisitor;
        for (Integer i = 0; i < totalRecords; i++) {
            chats.add(new LiveChatTranscript(
                LiveChatVisitorId = chatVisitor.Id,
                StartTime = System.now(),
                ContactId = contactId
            ));
        }
        if (!chats.isEmpty()) {
            insert chats;
        }
    }

    /**
     * 
     * @param recordType 
     * @return  `Opportunity`
     */
    public static Opportunity createOpportunity(String recordType, String name, String pricebookId) {
        Id recordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get(recordType).getRecordTypeId();
        return new Opportunity(
                Name = name,
                RecordTypeId = recordTypeId,
                CloseDate = System.today(),
                StageName = 'New Project',
                Pricebook2Id = pricebookId,
                Customer_Order_Number__c = 'Test Order',
                Division__c = 'Group',
                LeadSource = 'Glenigan',
                Estimated_Start_Date__c = Date.today(),
                Estimated_Completion__c = Date.today().addDays(60),
                Initiated_By__c = 'Bristan');
    }

    /**
     * @return  `BMCServiceDesk__Incident__c`
     */
    public static BMCServiceDesk__Incident__c createIncidentRecord(String userId, String supId, String manId) {
        BMCServiceDesk__BMC_BaseElement__c bs = DataFactory.createBS('TestBS');
        insert bs;
        BMCServiceDesk__Impact__c impact = DataFactory.createImpact('TestImpact', false);
        insert impact;
        BMCServiceDesk__Urgency__c urgency = DataFactory.createUrgency('Low', false);
        insert urgency;
        BMCServiceDesk__Status__c status = DataFactory.createStatus('New', false, true);
        insert status;
        BMCServiceDesk__Priority__c priority = DataFactory.createPriority('1', impact, urgency);
        insert priority;

        return new BMCServiceDesk__Incident__c(
            RF_Manager__c = supId,
            RF_Delegated_Approver__c = manId,
            BMCServiceDesk__FKClient__c = userId,
            BMCServiceDesk__incidentDescription__c = 'Test',
            BMCServiceDesk__FKBusinessService__c = bs.Id,
            BMCServiceDesk__FKImpact__c = impact.Id ,
            BMCServiceDesk__FKUrgency__c = urgency.Id,
            BMCServiceDesk__FKStatus__c = status.Id,
            BMCServiceDesk__FKPriority__c = priority.Id
        );
    }

    /**
     * @return  `BMCServiceDesk__Change_Request__c`
     */
    public static BMCServiceDesk__Change_Request__c createChangeRequestRecord(String userId) {
        BMCServiceDesk__BMC_BaseElement__c bs = DataFactory.createBS('TestBS');
        insert bs;
        BMCServiceDesk__Impact__c impact = DataFactory.createImpact('TestImpact', false);
        insert impact;
        BMCServiceDesk__Urgency__c urgency = DataFactory.createUrgency('Low', false);
        insert urgency;
        BMCServiceDesk__Status__c status = DataFactory.createStatus('New', false, true);
        insert status;
        BMCServiceDesk__Priority__c priority = DataFactory.createPriority('1', impact, urgency);
        insert priority;

        return new BMCServiceDesk__Change_Request__c(
            BMCServiceDesk__FKInitiator__c = userId,
            BMCServiceDesk__FKImpact__c = impact.id ,
            BMCServiceDesk__FKUrgency__c = urgency.id,
            BMCServiceDesk__FKStatus__c = status.id,
            BMCServiceDesk__FKPriority__c = priority.id,
            BMCServiceDesk__Back_out_Plan_Details__c  = '12345678910',
            BMCServiceDesk__Change_Description__c  = '12345678910',
            BMCServiceDesk__Reason_for_Change_Details__c = '12345678910',
            BMCServiceDesk__Roll_Out_Plan_Details__c = '12345678910',
            CR_Test_Plan_Details__c = '12345678910'
        );
    }    
}