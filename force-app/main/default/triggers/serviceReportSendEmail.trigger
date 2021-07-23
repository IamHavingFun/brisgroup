/**
 * @description trigger file for ServiceReport SObject
 */
trigger serviceReportSendEmail on ServiceReport (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        // Send Email notifications after Service Report records have been inserted
        ServiceReportTriggerHandler.sendEmails(Trigger.new);
    }
}