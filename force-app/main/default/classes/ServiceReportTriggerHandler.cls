/**
 * @author PolSource
 */
public with sharing class ServiceReportTriggerHandler {

    private ServiceReportTriggerHandler() {}

    /**
     * @param records `List<ServiceReport>`
     */
    public static void sendEmails(List<ServiceReport> records) {
        // List of Mails to send
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
        // List of all Parent Ids
        List<String> parentIds = new List<String>();
        for (ServiceReport sr : records) {
            parentIds.add(sr.ParentId);
        }
    
        // returns a map returning a ServiceAppointment record given its Id
        Map<String, ServiceAppointment> serviceAppointments = new Map<String, ServiceAppointment>([SELECT Id, Email_Service_Report__c, Contact_Email__c, Case_Number__c 
                                                                                                    FROM ServiceAppointment 
                                                                                                    WHERE Id IN :parentIds]);
        // get all ServiceAppointment Ids
        Set<String> serviceReportIds = (new Map<String, ServiceReport>(records)).keySet();
        // We need to query the DocumentBody property, return the record based on its Id
        Map<String, ServiceReport> serviceReports = new Map<String, ServiceReport>([SELECT DocumentBody FROM ServiceReport WHERE Id IN :serviceReportIds]);
        for(ServiceReport sr : records) {
            try {
                // Get service appointment details inc contact email
                ServiceAppointment so = serviceAppointments.get(sr.ParentId);
    
                // Check contact email exists and report should be sent            
                if (so.Email_Service_Report__c && so.Contact_Email__c != '' && so.Contact_Email__c != null) {
                    Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
                    // set contact's Email
                    mail.setToAddresses(new List<String>{so.Contact_Email__c});
                    // Subject includes Case Number
                    mail.setSubject('Service Report Created for Case Number: '+ so.Case_Number__c);
                    String body = 'Your service report is attached.';
                    mail.setHtmlBody(body);
                    // Get file for attachment
                    List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
                    Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                    efa.setContentType('application/pdf');
                    efa.setInline(false);
                    efa.setFileName(sr.ServiceReportNumber);
                    // Have to fetch DocumentBody, it is null when accessing directly
                    Blob attBody = serviceReports.get(sr.Id).DocumentBody;
                    efa.setBody(attBody);
                    // Add Email's Attachment
                    fileAttachments.add(efa);
                    mail.setFileAttachments(fileAttachments);
                    // Add Email to Email List
                    mails.add(mail);
                }
            } catch(exception e) {
                System.debug('************************** Exception in serviceReportSendEmail trigger handler:'+e);
            }
        }

        //  only send emails if there is any records in the list
        if (!mails.isEmpty()) {
            // Sends the list of emails instantiated with SingleEmailMessage
            Messaging.sendEmail(mails);
        }
    }
}
