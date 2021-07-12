@isTest(SeeAllData = True)
private class TestCaseCloneCaseComments {

    static testMethod void myUnitTest() {
        TestUtilityClass.setUpData();
        Case cs = TestUtilityClass.cs;
        CaseComment cc = new CaseComment(CommentBody='Testing',ParentId=cs.Id);
        insert cc;
        Case cs2 = cs.clone(false);
        insert cs2;
    }
}