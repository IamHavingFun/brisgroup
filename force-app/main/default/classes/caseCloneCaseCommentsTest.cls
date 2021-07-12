@isTest(SeeAllData=true)
private class caseCloneCaseCommentsTest {

  static testMethod void CheckValidRecord() {
    // Create Case
    Id csrt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Bristan_General' AND SobjectType = 'Case' LIMIT 1].Id;
    Case cs = new Case(Subject='Test Case',RecordTypeId=csrt);
    insert cs;
    // Insert case comment
    CaseComment cc = new CaseComment(ParentId=cs.Id,CommentBody='Test Comment');
    insert cc;
    // Clone Case
    Case csClone = cs.clone();
    insert csClone;
    // Query number of Case Comments for cloned case
    string cid = csClone.Id;
    integer count = database.countQuery('SELECT count() from CaseComment where ParentId = :cid');
    // Check values
    System.assertEquals(count, 1);
  }
}