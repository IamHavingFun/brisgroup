@isTest(SeeAllData = True)
private class testUpdateEngNameOnCase{

    static testMethod void myUnitTest() {
        
        User MyUser = [SELECT Id,Name FROM User WHERE Name = 'Steve Mason'];
        
        Case MyCase = new Case(OwnerId = MyUser.Id, Subject = 'TestCase', Status = 'New', Case_Channel__c = 'Phone', IFS_Eng_Name__c = null);
        System.runAs(MyUser) { insert MyCase; }
                
        Engineer_Work_Order__c MyWO = new Engineer_Work_Order__c(Case__c = MyCase.Id);
        System.runAs(MyUser) { insert MyWO; }
        
        System.assertEquals(MyCase.IFS_Eng_Name__c,null);
         
        MyWO.Assigned_engineer__c = MyUser.Id;
        System.runAs(MyUser) { update MyWO; }
        system.debug('IFSName =' + MyCase.IFS_Eng_Name__c);                
        System.assertEquals(MyCase.OwnerId,MyUser.Id);

        MyWO.Assigned_engineer__c = null;
        System.runAs(MyUser) { update MyWO; }
        system.debug('IFSName =' + MyCase.IFS_Eng_Name__c);        
        System.assertEquals(MyCase.OwnerId,MyUser.Id);
        
        MyWO.Service_Agent__c = 'COOMB – Coombe Electrical';
        System.runAs(MyUser) { update MyWO; }
        System.assertEquals(MyCase.OwnerId,MyUser.Id);
       
        system.debug('Engineer =' + MyWO.Assigned_Engineer__c);
        system.debug('UserName =' + MyUser.Name);        
        system.debug('CaseOwnerId =' + MyCase.OwnerId);
        system.debug('UserId =' + MyUser.Id);
        system.debug('IFSName =' + MyCase.IFS_Eng_Name__c);
        System.assertEquals(MyCase.Id,MyWO.Case__c);
        System.assertEquals(MyCase.IFS_Eng_Name__c,null); 
    }
}