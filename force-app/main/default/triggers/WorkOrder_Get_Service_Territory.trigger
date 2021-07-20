trigger WorkOrder_Get_Service_Territory on WorkOrder (before insert, before update) {

  if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    WorkOrderTriggerHandler.updateServiceTerritory(Trigger.new);
  }
}