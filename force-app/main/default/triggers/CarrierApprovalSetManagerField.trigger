/**
 * @param insert PolSource
 */
trigger CarrierApprovalSetManagerField on Carrier_Approval_System__c (before insert) {

  if (Trigger.isInsert && Trigger.isBefore) {
    // Set Manager and Manager's Manager field values
    CarrierApprovalSystemTriggerHandler.setManager(Trigger.new);
  }

}