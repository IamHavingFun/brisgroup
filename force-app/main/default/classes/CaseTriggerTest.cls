/**
 * 
 * @author PolSource
 */
@IsTest
public with sharing class CaseTriggerTest {

    private static final String CASE_RECORD_TYPE_GENERAL = 'Bristan_General';

    @IsTest
    static void copyAllCommentsFromClonedCaseTest() {
        Integer totalComments = 10;
        Case testCase = TestUtilityDataFactory.insertCaseWithComments(CASE_RECORD_TYPE_GENERAL, totalComments);
        Test.startTest();
        Case clonedCase = testCase.clone();
        insert clonedCase;
        Test.stopTest();
        List<CaseComment> clonedComments = [SELECT Id FROM CaseComment WHERE ParentId = :clonedCase.Id];
        System.assert(!clonedComments.isEmpty(), 'Comments must be copied from source Case');
        System.assertEquals(totalComments, clonedComments.size(), 'All comment records must be copied');
    }

    @IsTest
    static void noCommentsAddedToCaseTest() {
        Integer totalComments = 0;
        Case testCase = TestUtilityDataFactory.insertCaseWithComments(CASE_RECORD_TYPE_GENERAL, totalComments);
        Test.startTest();
        Case clonedCase = testCase.clone();
        insert clonedCase;
        Test.stopTest();
        List<CaseComment> clonedComments = [SELECT Id FROM CaseComment WHERE ParentId = :clonedCase.Id];
        System.assert(clonedComments.isEmpty(), 'Original case does not have comment, no new records should be inserted');
    }

    @IsTest
    static void setClosedByWhenInsertCase() {
        User adminUser = TestUtilityDataFactory.insertSystemUser('System Administrator', 'adm');
        String caseId;
        Test.startTest();
        System.runAs(adminUser){
            Case testCase = TestUtilityDataFactory.createCase(CASE_RECORD_TYPE_GENERAL);
            testCase.Status = 'Closed';
            testCase.Reason = 'Spam';
            insert testCase;
            caseId = testCase.Id;
        }
        Test.stopTest();
        Case testCase = [SELECT Closed_By__c, Closed_by_SFID__c FROM Case WHERE Id = :caseId];
        System.assertEquals('ADM ADM', testCase.Closed_By__c, 'Name doesn\'t match');
        System.assertEquals(adminUser.Id, testCase.Closed_by_SFID__c, 'ID doesn\'t match');
    }

    @IsTest
    static void setClosedByWhenUpdatingCase() {
        User adminUser = TestUtilityDataFactory.insertSystemUser('System Administrator', 'adm');
        Case testCase = TestUtilityDataFactory.createCase(CASE_RECORD_TYPE_GENERAL);
        testCase.OwnerId = adminUser.Id;
        insert testCase;
        Test.startTest();
        System.runAs(adminUser){
            testCase.Status = 'Closed';
            testCase.Reason = 'Spam';
            update testCase;
        }
        Test.stopTest();
        testCase = [SELECT Closed_By__c, Closed_by_SFID__c FROM Case WHERE Id = :testCase.Id];
        System.assertEquals('ADM ADM', testCase.Closed_By__c, 'Name doesn\'t match');
        System.assertEquals(adminUser.Id, testCase.Closed_by_SFID__c, 'ID doesn\'t match');
    }

    @IsTest
    static void updateLastSurveyOnAccount() {
        Contact contact = TestUtilityDataFactory.createPersonContact();
        Case testCase = TestUtilityDataFactory.createCase(CASE_RECORD_TYPE_GENERAL);
        testCase.Survey_Sent__c = false;
        testCase.ContactId = contact.Id;
        insert testCase;
        Test.startTest();
        testCase.Survey_Sent__c = true;
        update testCase;
        Test.stopTest();
        Account personAccount = [SELECT Last_Survey_Date_del__pc, dupcheck__dc3DisableDuplicateCheck__c FROM Account WHERE Id = :contact.AccountId];
        System.assert(personAccount.dupcheck__dc3DisableDuplicateCheck__c, 'dupcheck__dc3DisableDuplicateCheck__c must be true');
        System.assertEquals(Date.today(), personAccount.Last_Survey_Date_del__pc, 'Last Survey Date must be updated');
    }

    @IsTest
    static void updateLastIndirectSurveyDateOnAccount() {
        Contact contact = TestUtilityDataFactory.createPersonContact();
        Case testCase = TestUtilityDataFactory.createCase(CASE_RECORD_TYPE_GENERAL);
        testCase.Indirect_Survey_Sent__c = false;
        testCase.ContactId = contact.Id;
        insert testCase;
        Test.startTest();
        testCase.Indirect_Survey_Sent__c = true;
        update testCase;
        Test.stopTest();
        Account personAccount = [SELECT Last_Indirect_Survey_Date__pc, dupcheck__dc3DisableDuplicateCheck__c FROM Account WHERE Id = :contact.AccountId];
        System.assert(personAccount.dupcheck__dc3DisableDuplicateCheck__c, 'dupcheck__dc3DisableDuplicateCheck__c must be true');
        System.assertEquals(Date.today(), personAccount.Last_Indirect_Survey_Date__pc, 'Last Indirect Survey Date must be updated');
    }

    @IsTest
    static void updateLastBristancareSurveyDateOnAccount() {
        Contact contact = TestUtilityDataFactory.createPersonContact();
        Case testCase = TestUtilityDataFactory.createCase(CASE_RECORD_TYPE_GENERAL);
        testCase.Bristancare_Survey_Sent__c = false;
        testCase.ContactId = contact.Id;
        insert testCase;
        Test.startTest();
        testCase.Bristancare_Survey_Sent__c = true;
        update testCase;
        Test.stopTest();
        Account personAccount = [SELECT Last_Bristancare_Survey_Date__pc, dupcheck__dc3DisableDuplicateCheck__c FROM Account WHERE Id = :contact.AccountId];
        System.assert(personAccount.dupcheck__dc3DisableDuplicateCheck__c, 'dupcheck__dc3DisableDuplicateCheck__c must be true');
        System.assertEquals(Date.today(), personAccount.Last_Bristancare_Survey_Date__pc, 'Last Bristancare Survey Date must be updated');
    }

    @IsTest
    static void updateLastSurveyOnContact() {
        Contact contact = TestUtilityDataFactory.createContact();
        insert contact;
        Case testCase = TestUtilityDataFactory.createCase(CASE_RECORD_TYPE_GENERAL);
        testCase.Survey_Sent__c = false;
        testCase.ContactId = contact.Id;
        insert testCase;
        Test.startTest();
        testCase.Survey_Sent__c = true;
        update testCase;
        Test.stopTest();
        contact = [SELECT Last_Survey_Date_del__c, dupcheck__dc3DisableDuplicateCheck__c FROM Contact WHERE Id = :contact.Id];
        System.assert(contact.dupcheck__dc3DisableDuplicateCheck__c, 'dupcheck__dc3DisableDuplicateCheck__c must be true');
        System.assertEquals(Date.today(), contact.Last_Survey_Date_del__c, 'Last Survey Date must be updated');
    }

    @IsTest
    static void updateLastIndirectSurveyDateOnContact() {
        Contact contact = TestUtilityDataFactory.createContact();
        insert contact;
        Case testCase = TestUtilityDataFactory.createCase(CASE_RECORD_TYPE_GENERAL);
        testCase.Indirect_Survey_Sent__c = false;
        testCase.ContactId = contact.Id;
        insert testCase;
        Test.startTest();
        testCase.Indirect_Survey_Sent__c = true;
        update testCase;
        Test.stopTest();
        contact = [SELECT Last_Indirect_Survey_Date__c, dupcheck__dc3DisableDuplicateCheck__c FROM Contact WHERE Id = :contact.Id];
        System.assert(contact.dupcheck__dc3DisableDuplicateCheck__c, 'dupcheck__dc3DisableDuplicateCheck__c must be true');
        System.assertEquals(Date.today(), contact.Last_Indirect_Survey_Date__c, 'Last Indirect Survey Date must be updated');
    }

    @IsTest
    static void updateLastBristancareSurveyDateOnContact() {
        Contact contact = TestUtilityDataFactory.createContact();
        insert contact;
        Case testCase = TestUtilityDataFactory.createCase(CASE_RECORD_TYPE_GENERAL);
        testCase.Bristancare_Survey_Sent__c = false;
        testCase.ContactId = contact.Id;
        insert testCase;
        Test.startTest();
        testCase.Bristancare_Survey_Sent__c = true;
        update testCase;
        Test.stopTest();
        contact = [SELECT Last_Bristancare_Survey_Date__c, dupcheck__dc3DisableDuplicateCheck__c FROM Contact WHERE Id = :contact.Id];
        System.assert(contact.dupcheck__dc3DisableDuplicateCheck__c, 'dupcheck__dc3DisableDuplicateCheck__c must be true');
        System.assertEquals(Date.today(), contact.Last_Bristancare_Survey_Date__c, 'Last Bristancare Survey Date must be updated');
    }    
}