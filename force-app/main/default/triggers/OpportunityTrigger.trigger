/**
 * @author  PolSource
 */

trigger OpportunityTrigger on Opportunity (before insert, after insert, before update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){

        // This trigger populates the read-only field "Assigned To" on events,
        // Along with ManagerName=
        // It's needed because
        // 1) the Owner field can't be used in 
        // formula fields--really! See http://tinyurl.com/ActivityDate
        // ManagerName is required for reporting setup

        OpportunityTriggerHandler.tgrPopulateAssignedToField_Opportunity(Trigger.new);


        /** This trigger is for updating the 'Division'custom field on 'Lead'record based upon on Lead Owner's 'Division'. 
        *  For example-If Lead Owner's 'Division' is 'Trade' that the custom 'Division' field will have value 'Trade'.
        *  It also sets the 3 Apporver fields by pulling the Approver infoemation from Owner record.
        *  Author-Hema kulkarni
        *  Since-May 2012
        *  Email-hkulkarni@innoveer.com
        **/

        OpportunityTriggerHandler.updateDivisionfieldonOpp(Trigger.new);
        
    }

    if ((Trigger.isAfter && Trigger.isInsert) || (Trigger.isBefore && Trigger.isUpdate)) {

         // Rolls up all notes from project Opportunity records
         //Trigger disabled
         
        //  OpportunityTriggerHandler.updateNoteOnProjects(Trigger.new);
    }



}