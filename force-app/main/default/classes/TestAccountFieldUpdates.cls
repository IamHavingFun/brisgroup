@isTest(SeeAllData = True)
private class TestAccountFieldUpdates {

    static testMethod void myUnitTest() {
        schema.describesobjectresult resultAcc = Account.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> accRecTypeId = resultAcc.getrecordtypeinfosbyname();
        Id accRec = accRecTypeId.get('Person Account').getrecordtypeid();
        Account acc = new Account(RecordTypeId=accRec,FirstName='Bob',LastName='Hoskins',GDPR_Confirmed__pc='Verbal');
        insert acc;
        acc.GDPR_Confirmed__pc='Written';
        acc.PersonMobilePhone='07999876544';
        update acc;
        TestUtilityClass.setUpData();
        Account acc2 = TestUtilityClass.acc;
        acc2.Cleanse_Complete__c = true;
        acc2.Data_Cleanse__c = true;
        acc2.Deactivate_Account__c = true;
        acc2.Heritage_Customer__c = false;
        acc2.Heritage_New_Customer_Pack_Sent__c = false;
        update acc2;
        System.debug('*!*!*!*!*: ' + acc2);
        acc2.Heritage_Customer__c = true;
        update acc2;
        System.debug('*!*!*!*!*: ' + acc2);        
    }
}