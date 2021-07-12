trigger serviceReportSendEmail on ServiceReport (after insert) {
    ServiceAppointment so;
    string soId;
    List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
    List<String> sendTo = new List<String>();
    
    for(ServiceReport sr : trigger.new){
        try {
            // Get service appointment details inc contact email
            soId = sr.ParentId;
            so = [select Id, Email_Service_Report__c, Contact_Email__c, Case_Number__c from ServiceAppointment where Id = :soId limit 1];

            // Check contact email exists and report should be sent            
            if(so.Email_Service_Report__c && so.Contact_Email__c != '' && so.Contact_Email__c != null)
            {
                sendTo.add(so.Contact_Email__c);
                Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
                mail.setToAddresses(sendTo);
                mail.setSubject('Service Report Created for Case Number: '+ so.Case_Number__c);
                String body = 'Your service report is attached.';
                mail.setHtmlBody(body);
                mails.add(mail);
                
                // Get file for attachment
                List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
                Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                efa.setContentType('application/pdf');
                efa.setInline(false);
                efa.setFileName(sr.ServiceReportNumber);
                // Have to fetch DocumentBody, it is null when accessing directly
                Blob attBody = [select DocumentBody from ServiceReport where Id = :sr.Id limit 1].DocumentBody;
                efa.setBody(attBody);
                fileAttachments.add(efa);
                mail.setFileAttachments(fileAttachments);

                Messaging.sendEmail(mails);
            }
        }
        catch(exception e) {
            System.debug('************************** Exception in serviceReportSendEmail trigger:'+e);
        }
    }
}