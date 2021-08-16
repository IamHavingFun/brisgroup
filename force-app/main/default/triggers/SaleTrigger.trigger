/**
 * @author  PolSource
 */

trigger SaleTrigger on Sale__c (before insert, before update) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){


        // This trigger populates the read-only field "Rep_Owner_Lookup__c" on Sales Summaries,
        // It's needed to create a single field that holds either the account owner (sales summary) or the owner (target)
        // For the joined report grouping for sales vs performance

        SaleTriggerHandler.tgrPopulateRepOwnerField_Sale(Trigger.new);

    }

}