/**
 * @author  PolSource
 */

trigger EventTrigger on Event (before insert, before update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){

        // This trigger populates the read-only field "Assigned To" on events,
        // Along with ManagerName and Customer Type
        // It's needed because
        // 1) the Owner field can't be used in 
        //    formula fields--really! See http://tinyurl.com/ActivityDate
        // ManagerName is required for reporting setup and Customer Type is
        // required for a report (can't be accessed through the report)

        EventTriggerHandler.tgrPopulateAssignedToField_Event(Trigger.new);


        /**This trigger will set the Closed_Date__c field when the status is set to closed
        * Author-Steve Mason
        * Email-smason@bristan.com
        * Since March 2013
        **/

        EventTriggerHandler.updateClosedDate(Trigger.new);


        /**This is a simple trigger which will update the custom date fields by standard date fields as we the standard date fields are available in formula to 
        * run the report 'Call Report Completed on time'
        * Author-Hema Kulkarni
        * Email-hkulkarni@innoveer.com    
        * Since May 2012
        */
        EventTriggerHandler.upDateCustomDates(Trigger.new);


        /* Trigger to update address on Event with the related contact address if it is left blank on event page.
        * Author - Bhushan Adhikari
        * since - May 2012
        * e-mail :badhikari@innoveer.com    
        *
        */
        EventTriggerHandler.updateEventAddress(Trigger.new);

    }



}