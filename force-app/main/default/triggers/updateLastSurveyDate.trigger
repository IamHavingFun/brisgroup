/**This trigger will set the Last_Survey_Date_del__c field on case contact
 * Author-Steve Mason
 * Email-smason@bristan.com
 * Since July 2014
**/
trigger updateLastSurveyDate on Case (before update) {

    if (Trigger.isBefore && Trigger.isUpdate) {
        // Update information on related Contact and Account records
        CaseTriggerHandler.updateDatesOnContactAndAccounts(Trigger.new);
    }


}