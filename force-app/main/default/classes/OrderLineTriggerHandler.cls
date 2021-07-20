public with sharing class OrderLineTriggerHandler {

    public static void validatePermissionBeforeDelete(List<Order_Line__c> records) {
        Boolean isAllowed = false;
        List<String> profileNames = new List<String>{'Service User','Service Back Office User','Service Knowledge Contributer','Heritage User','Engineer User','System Administrator'};
        Profile[] UserProfile = [SELECT Name, Id FROM Profile WHERE Name IN :profileNames];
        system.debug('#### UserProfile = ' + UserProfile + ' ####');
  
        String UserLevel = [SELECT Id, Level__c FROM User WHERE Id = :UserInfo.getUserId()].Level__c;
        for(Order_Line__c ThisLine : records) 
        {
          for (Profile ThisProfile : UserProfile)
          {
            system.debug('#### ThisProfile  = ' + ThisProfile + ' ####');
            if (UserInfo.getProfileId() == ThisProfile.id)
            {
              system.debug('#### Profile Match ####');
              
              system.debug('#### UserLevel = ' + UserLevel + ' ####');
              if(UserLevel == 'Head of Customer Service') {
                system.debug('#### ALLOWED ####');            
                isAllowed = true;
              } else if(UserLevel == 'Coach') {
                system.debug('#### ALLOWED ####');                        
                isAllowed = true;
              } else if(UserLevel == 'Team Leader') {
                system.debug('#### ALLOWED ####');                        
                isAllowed = true;
              } else if(UserLevel == 'SysAdmin') {
                system.debug('#### ALLOWED ####');                        
                isAllowed = true;
              }
            }
          }
          if (!isAllowed) {
            ThisLine.addError('You do not have access to delete Order Lines.');
          }
        }
    }
}
