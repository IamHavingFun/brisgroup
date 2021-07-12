trigger ECNRefreshOldLineValues on ECN__c (after update) {

    for (ECN__c ecn : Trigger.new)
    {
        if(ecn.Status__c=='New' || ecn.Status__c=='Rejected' || ecn.Status__c=='Awaiting Finance Approval')
        {
            String ecnId = ecn.Id;
            list<ECN_Line__c> lines = [SELECT Id, Field_to_Change__c, New_Value__c, Old_Value__c from ECN_Line__c where ECN__c = :ecnId];
            for(ECN_Line__c line : lines)
            {
              // Loop and update all lines on an ECN at New status when the ECN is saved
              // This is to retrigger the 'fetch old value' trigger so that the correct value is pulled when changing the product on a cloned ECN
              line.Old_Value__c = '';
              update line;
            }
        }
    }
}