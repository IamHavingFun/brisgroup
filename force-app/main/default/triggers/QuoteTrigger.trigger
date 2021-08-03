/**
 * @author  PolSource
 */

 trigger QuoteTrigger on Quote (before insert, before update, after update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){

        /*
        * This trigger updates the Approvers on Quote  form its Opportunity Owner user record.
        * Author : Bhushan Adhikari
        * since  : June 2012
        * E-Mail : badhikari@innoveer.com
        */
        QuoteTriggerHandler.updateApprovers(Trigger.new);

    }

    if (Trigger.isAfter && Trigger.isUpdate){

        /** This trigger is for updating the Opportunity Stage to 'Closed Won' once any related Quote gets approved.
         * Author-Hema Kulkarni
         * Email-hkulkarni@innoveer.com
         * Since-June 2012
        **/
        QuoteTriggerHandler.updateOppField(Trigger.new);

    }

}