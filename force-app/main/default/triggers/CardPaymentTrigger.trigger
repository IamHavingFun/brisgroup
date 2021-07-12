trigger CardPaymentTrigger on Income_Card_Payment__c (before insert) {
      Profile[] serviceuser = [Select Name, Id From Profile where Name in ('Service User','Engineer User', 'Heritage User','Service Back Office User' , 'Service Knowledge Contributer', 'System Administrator' ) ];
      system.debug('#### serviceuser =' + serviceuser);
         
      // Service User, Engineer User, Heritage User, Service Back Office User, Service Knowledge Contributor
         
      system.debug('#### userinfo.getProfileId()  =' + userinfo.getProfileId() );
      for(Income_Card_Payment__c thiscardpayment :trigger.new) 
      {
          for (Profile thisprof : serviceuser)
          {
              system.debug('#### thisprof  =' + thisprof );
              if (userinfo.getProfileId() == thisprof.id )
              {
                  system.debug('#### match');
                  thiscardpayment.Payment_Is_From_Console_View__c = true;
              }
          }
      }
}