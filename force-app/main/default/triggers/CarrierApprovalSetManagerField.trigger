trigger CarrierApprovalSetManagerField on Carrier_Approval_System__c (before insert) {

  if (Trigger.isInsert && Trigger.isBefore) {
    CarrierApprovalSystemTriggerHandler.setManager(Trigger.new);
  }

}