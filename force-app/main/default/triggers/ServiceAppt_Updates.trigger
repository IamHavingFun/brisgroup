/**
 * @description trigger file for ServiceAppointment SObject
 */
trigger ServiceAppt_Updates on ServiceAppointment (before insert, before update) {
  
  if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    // update Service Appointment fields based on related Work Order record
    ServiceAppointmentTriggerHandler.updateServiceAppointmentFields(Trigger.new);
  }

}