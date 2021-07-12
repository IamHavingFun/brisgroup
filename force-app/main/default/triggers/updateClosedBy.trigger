/**This trigger will set the Closed_By__c and Closed_By_ID__c fields when the status is set to closed
 * Author-Steve Mason
 * Email-smason@bristan.com
 * Since July 2014
**/
trigger updateClosedBy on Case (before insert,before update) {
    for(case cs :trigger.new) { 
        if(Trigger.isUpdate) {
            case oldCase = Trigger.oldMap.get(cs.ID);
            case c = [select id,owner.type from case where id = :cs.Id];

            if(cs.Status == 'Closed' && (oldCase.Status != 'Closed' || oldCase.Status == null || oldCase.Status == '') && (cs.Closed_By__c == '' || cs.Closed_By__c == null) && (c.owner.type == 'User')) {
                case cstemp = [select Id, Owner.Name from case where Id = :cs.Id];
                cs.Closed_By__c = cstemp.Owner.Name;
                cs.Closed_by_SFID__c = cs.OwnerId;
                system.debug('CaseID : ' + cs.id);
                system.debug('Closed_By__c : ' + cs.Closed_By__c);
                system.debug('Closed_by_SFID__c : ' + cs.Closed_by_SFID__c);
            }
        }
        if(Trigger.isInsert) {
            if(cs.Status == 'Closed') {
                user usertemp = [select Id, Name from user where Id = :UserInfo.getUserId()];
                cs.Closed_By__c = usertemp.Name;
                cs.Closed_by_SFID__c = usertemp.Id;
                system.debug('CaseID : ' + cs.id);
                system.debug('Closed_By__c : ' + cs.Closed_By__c);
                system.debug('Closed_by_SFID__c : ' + cs.Closed_by_SFID__c);
            }            
        }
    }
}