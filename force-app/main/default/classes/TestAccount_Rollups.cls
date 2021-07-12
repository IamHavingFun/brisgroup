@isTest(SeeAllData = True)
private class TestAccount_Rollups {

    static testMethod void myUnitTest() {
        schema.describesobjectresult resultAcc = Account.sobjecttype.getdescribe();
        Map<string, schema.recordtypeinfo> accRecTypeId = resultAcc.getrecordtypeinfosbyname();
        Id accRec = accRecTypeId.get('Person Account').getrecordtypeid();
        Account acc = new Account(RecordTypeId=accRec,FirstName='Bob',LastName='Hoskins');
        insert acc;
        update acc;
    }
}