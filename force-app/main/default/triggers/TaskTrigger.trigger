/**
 * @author  PolSource
 */

trigger TaskTrigger on Task (after update) {


    if (Trigger.isAfter && Trigger.isUpdate){

        /* This trigger is used to send an email notification to task creator when a task is completed by another user.
        * Author-Hema Kulkarni
        * Since- may 2012
        * Email-hkulkarni@innoveer.com
        */
        TaskTriggerHandler.sendEmailToCreator(Trigger.old, Trigger.new);

    }


}