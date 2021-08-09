/**
 * @author  PolSource
 */

public with sharing class CardPaymentTriggerHandler {
    private CardPaymentTriggerHandler() {}

    public static void setPaymentFromConsoleView(List<Income_Card_Payment__c> records){

        Profile[] serviceuser = [Select Name, Id From Profile where Name in ('Service User','Engineer User', 'Heritage User','Service Back Office User' , 'Service Knowledge Contributer', 'System Administrator' ) ];
        system.debug('#### serviceuser =' + serviceuser);
         
        // Service User, Engineer User, Heritage User, Service Back Office User, Service Knowledge Contributor
         
        String userProfileId = userinfo.getProfileId();
        for(Income_Card_Payment__c thiscardpayment :records) 
        {
            for (Profile thisprof : serviceuser)
            {
                system.debug('#### thisprof  =' + thisprof );
                if (userProfileId == thisprof.id )
                {
                    system.debug('#### match');
                    thiscardpayment.Payment_Is_From_Console_View__c = true;
                }
            }
        }
    }



}