/**
 * @author PolSource
 */

trigger AccountRequestTrigger on Account_Request__c (after update) {

    if (Trigger.isAfter && Trigger.isUpdate){
    
        AccountRequestTriggerHandler.lockRequestOnCompletion(Trigger.old, Trigger.new);
    
    }

}