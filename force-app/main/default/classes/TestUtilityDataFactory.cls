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
}
