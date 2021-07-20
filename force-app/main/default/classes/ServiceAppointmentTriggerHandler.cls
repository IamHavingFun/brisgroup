public with sharing class ServiceAppointmentTriggerHandler {

    public static void updateServiceAppointmentFields(List<ServiceAppointment> records) {
        try {
            List<String> workOrders = new List<String>();
            List<String> contactIds = new List<String>();
            for (ServiceAppointment sa : records) {
              string woId = sa.ParentRecordId;
              workOrders.add(woId.substring(0,15));
              contactIds.add(sa.ContactId);
            }
            Map<String, WorkOrder> workOrderById = new Map<String, WorkOrder>([SELECT 
                                                  Id, Division__c, Product__c, IFS_Order_Number__c, Case.Id, Case.CaseNumber, Case.Subject, Case.Reason, Case.Work_Order_Recall__c 
                                                  FROM WorkOrder WHERE Id IN :workOrders]);
            Map<String, Contact> contactsById = new Map<String, Contact>([SELECT Email, MobilePhone, Mobile_Phone_Email__c, FirstName FROM Contact WHERE Id IN :contactIds]);
          for (ServiceAppointment sa : records) {
            string division;
            string caseNum;
            string caseSub;
            string caseId;
            string caseReason;
            string product;
            string orderNo;
            Boolean Recall = false;
            string woId = sa.ParentRecordId;
            woId = woId.substring(0,15);
            Contact con;
            string conId = sa.ContactId;
            WorkOrder wo;
          
            // Check scheduled start time is not blank
            if (sa.SchedStartTime != null) {
              sa.Hour__c = sa.SchedStartTime.hour();
              sa.Start_Time__c = string.valueof(sa.SchedStartTime.hour()).leftPad(2, '0') + ':' + string.valueof(sa.SchedStartTime.minute()).leftPad(2, '0');
              sa.End_Time__c = string.valueof(sa.SchedEndTime.hour()).leftPad(2, '0') + ':' + string.valueof(sa.SchedEndTime.minute()).leftPad(2, '0');
            }  
            // Get division from work order
            try {
              wo = workOrderById.get(woId);
              caseId = wo.Case.Id;
              if(caseId != null && caseId != '') {
                division = wo.Division__c;
                caseNum = wo.Case.CaseNumber;
                caseSub = wo.Case.Subject;        
                product = wo.Product__c;
                orderNo = wo.IFS_Order_Number__c;
                caseReason = wo.Case.Reason;
                Recall = wo.Case.Work_Order_Recall__c;
              } else {
                sa.Division__c = division;
                sa.Case_Subject__c = caseSub;
                sa.Case_Number__c = caseNum;  
                sa.Case_Reason__c = caseReason;
                sa.Work_Order_Recall__c = Recall;
                sa.IFS_Order_Number__c = orderNo;
                sa.Job_Product__c = product;
              }
            } catch (Exception ex) {
              division = '';
              caseNum = '';
              caseSub = '';
              caseReason = '';
              orderNo = '';
              product = '';
              Recall = false;
              System.debug('************************** Exception in ServiceAppt_Updates trigger:'+ex);
            }
            sa.Division__c = division;
            sa.Case_Subject__c = caseSub;
            sa.Case_Number__c = caseNum;
            sa.Job_Product__c = product;
            sa.IFS_Order_Number__c = orderNo;
            if (Trigger.isInsert) {
              sa.Case_Reason__c = caseReason;
              sa.Work_Order_Recall__c = Recall;
            }
            // Get contact details onto SA for SMS/emails
            try {
              if (conID != null && conId != '') {
                con = contactsById.get(conId);
                sa.Contact_Email__c = con.Email;
                sa.Contact_Mobile__c = con.MobilePhone;
                sa.Contact_Mobile_Email__c = con.Mobile_Phone_Email__c;
                sa.Contact_First_Name__c = con.FirstName;
              }
            } catch (Exception ex) {
              System.debug('************************** Exception in ServiceAppt_Updates trigger:'+ex);       
            }
          }
        } catch (Exception e) {
          System.debug('************************** Exception in ServiceAppt_Updates trigger:'+e);
        }
    }
}
