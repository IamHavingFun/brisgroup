/**
 * @author  PolSource
 */

trigger OrderTrigger on Order__c (after update) {

    if (Trigger.isAfter && Trigger.isUpdate){

        OrderTriggerHandler.lockOrderOnCancel(Trigger.old, Trigger.new);

    }

}