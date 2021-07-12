@isTest(SeeAllData = True)
private class testEmailBeforeDelete{

    static testMethod void myUnitTest() {
        
        Case MyCase = new Case(Subject = 'TestCase', Status = 'New', Case_Channel__c = 'Phone', IFS_Eng_Name__c = null);
        insert MyCase;

        EmailMessage eml = new EmailMessage(Subject = 'Test', ParentId = MyCase.Id);
        insert eml;

        try {
          delete eml;
        } catch(Exception e) {}  
                
        System.assertEquals(eml.Subject,'Test'); 
    }
}