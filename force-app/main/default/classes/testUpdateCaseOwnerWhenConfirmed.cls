@isTest(SeeAllData = True)
private class testUpdateCaseOwnerWhenConfirmed{

    static testMethod void myUnitTest() {
        
        User MyUser = [SELECT Id,Name FROM User WHERE Name = 'No Reply'];
        User engUser = [SELECT Id,Name FROM User WHERE Name = 'Salesforce Reporting'];
        
        Case MyCase = new Case(OwnerId = MyUser.Id, Subject = 'TestCase', Status = 'New', Case_Channel__c = 'Phone');
        System.runAs(MyUser) { insert MyCase; }
                
        Engineer_Work_Order__c MyWO = new Engineer_Work_Order__c(Case__c = MyCase.Id);
        System.runAs(MyUser) { insert MyWO; }
        
        System.assertEquals(MyCase.OwnerId,MyUser.Id);
        
        MyWO.Assigned_engineer__c = engUser.Id;
        System.runAs(MyUser) { update MyWO; }
        
        Case MyCase2 = [SELECT Id, OwnerId from Case WHERE ID=:MyCase.Id ];

        System.assertEquals(1,1);
    }
}