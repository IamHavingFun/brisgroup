trigger OrderLineDeleteTrigger on Order_Line__c (before delete) {

      Boolean isAllowed = false;
      Profile[] UserProfile = [Select Name, Id From Profile where Name in ('Service User','Service Back Office User','Service Knowledge Contributer','Heritage User','Engineer User','System Administrator')];
      system.debug('#### UserProfile = ' + UserProfile + ' ####');

      for(Order_Line__c ThisLine :trigger.old) 
      {
        for (Profile ThisProfile : UserProfile)
        {
          system.debug('#### ThisProfile  = ' + ThisProfile + ' ####');
          if (UserInfo.getProfileId() == ThisProfile.id)
          {
            system.debug('#### Profile Match ####');
            String UserLevel = [Select Id, Level__c from User where Id = :UserInfo.getUserId()].Level__c;
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