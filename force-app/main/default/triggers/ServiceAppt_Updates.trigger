trigger ServiceAppt_Updates on ServiceAppointment (before insert, before update) {
  
  if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
    ServiceAppointmentTriggerHandler.updateServiceAppointmentFields(Trigger.new);
  }

}