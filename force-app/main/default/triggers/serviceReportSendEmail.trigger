trigger serviceReportSendEmail on ServiceReport (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        ServiceReportTriggerHandler.sendEmails(Trigger.new);
    }
}