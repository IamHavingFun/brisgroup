@isTest(SeeAllData = True)
private class TestContactFieldUpdates {

    static testMethod void myUnitTest() {
        TestUtilityClass.setUpData();
        Account acc = TestUtilityClass.acc;
        Contact con = new Contact(FirstName='Bob',LastName='Hoskins',AccountId=acc.Id,GDPR_Confirmed__c='Verbal');
        insert con;
        con.MobilePhone='07999876544';
        con.GDPR_Confirmed__c='Written';
        update con;
    }
}