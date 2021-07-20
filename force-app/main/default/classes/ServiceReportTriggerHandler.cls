public with sharing class ServiceReportTriggerHandler {

    public static void sendEmails(List<ServiceReport> records) {
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
        List<String> sendTo = new List<String>();
        List<String> parentIds = new List<String>();
        for (ServiceReport sr : records) {
            parentIds.add(sr.ParentId);
        }
    
        Map<String, ServiceAppointment> serviceAppointments = new Map<String, ServiceAppointment>([SELECT Id, Email_Service_Report__c, Contact_Email__c, Case_Number__c 
                                                                                                    FROM ServiceAppointment 
                                                                                                    WHERE Id IN :parentIds]);
        Set<String> serviceReportIds = (new Map<String, ServiceReport>(records)).keySet();
        Map<String, ServiceReport> serviceReports = new Map<String, ServiceReport>([SELECT DocumentBody FROM ServiceReport WHERE Id IN :serviceReportIds]);
        for(ServiceReport sr : records) {
            try {
                // Get service appointment details inc contact email
                ServiceAppointment so = serviceAppointments.get(sr.ParentId);
    
                // Check contact email exists and report should be sent            
                if (so.Email_Service_Report__c && so.Contact_Email__c != '' && so.Contact_Email__c != null) {
                    sendTo.add(so.Contact_Email__c);
                    Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
                    mail.setToAddresses(sendTo);
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
                    fileAttachments.add(efa);
                    mail.setFileAttachments(fileAttachments);
                    mails.add(mail);
                }
            } catch(exception e) {
                System.debug('************************** Exception in serviceReportSendEmail trigger handler:'+e);
            }
        }

        if (!mails.isEmpty()) {
            Messaging.sendEmail(mails);
        }
    }
}
