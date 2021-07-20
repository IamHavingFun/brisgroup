/**This trigger will set the Closed_By__c and Closed_By_ID__c fields when the status is set to closed
 * Author-Steve Mason
 * Email-smason@bristan.com
 * Since July 2014
**/
trigger updateClosedBy on Case (before insert,before update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        CaseTriggerHandler.updateClosedBy(Trigger.new);
    }

}