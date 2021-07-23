/**
 * @description trigger file for WorkOrder SObject
 */
trigger WorkOrder_Get_Service_Territory on WorkOrder (before insert, before update) {

  if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    // update the ServiceTerritoryId value based on its Postal Code value
    WorkOrderTriggerHandler.updateServiceTerritory(Trigger.new);
  }
}