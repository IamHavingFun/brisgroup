/**
 * @author PolSource
 */
public with sharing class ServiceAppointmentTriggerHandler {

    private ServiceAppointmentTriggerHandler() {}

    /**
     * @param records `List<ServiceAppointment>`
     */
    public static void updateServiceAppointmentFields(List<ServiceAppointment> records) {
        try {
          // List of all Work Order Ids
          List<String> workOrders = new List<String>();
          // List of all Contact Ids
          List<String> contactIds = new List<String>();
          for (ServiceAppointment sa : records) {
            String woId = sa.ParentRecordId;
            // get the first 15 characters from woId and add them to the list
            workOrders.add(woId.substring(0,15));
            // get contactId and add it to the list
            contactIds.add(sa.ContactId);
          }
          // returns a WorkOrder record given an Id
          Map<String, WorkOrder> workOrderById = new Map<String, WorkOrder>([SELECT 
                                                Id, Division__c, Product__c, IFS_Order_Number__c, CaseId, Case.CaseNumber, Case.Subject, Case.Reason, Case.Work_Order_Recall__c 
                                                FROM WorkOrder WHERE Id IN :workOrders]);
          // returns a Contact record given an Id
          Map<String, Contact> contactsById = new Map<String, Contact>([SELECT Email, MobilePhone, Mobile_Phone_Email__c, FirstName FROM Contact WHERE Id IN :contactIds]);
          for (ServiceAppointment sa : records) {
            // Init string variables with an empty string
            String division = '', caseNum = '', caseSub = '', caseReason = '', product = '', orderNo = '';
            Boolean recall = false;
            String woId = sa.ParentRecordId;
        
            // Check scheduled start time is not blank
            if (sa.SchedStartTime != null) {
              sa.Hour__c = sa.SchedStartTime.hour();
              sa.Start_Time__c = String.valueof(sa.SchedStartTime.hour()).leftPad(2, '0') + ':' + String.valueof(sa.SchedStartTime.minute()).leftPad(2, '0');
              sa.End_Time__c = String.valueof(sa.SchedEndTime.hour()).leftPad(2, '0') + ':' + String.valueof(sa.SchedEndTime.minute()).leftPad(2, '0');
            }  
            // Get division from work order
            WorkOrder wo = workOrderById.get(woId);
            if (String.isNotBlank(wo.CaseId)) {
              division = wo.Division__c;
              caseNum = wo.Case.CaseNumber;
              caseSub = wo.Case.Subject;        
              product = wo.Product__c;
              orderNo = wo.IFS_Order_Number__c;
              caseReason = wo.Case.Reason;
              recall = wo.Case.Work_Order_Recall__c;
            }
            // Update Service request properties
            sa.Division__c = division;
            sa.Case_Subject__c = caseSub;
            sa.Case_Number__c = caseNum;
            sa.Job_Product__c = product;
            sa.IFS_Order_Number__c = orderNo;
            // If method was fired from a Before Inser trigger
            if (Trigger.isInsert) {
              // Set Case Reason and Work Order Recall properties
              sa.Case_Reason__c = caseReason;
              sa.Work_Order_Recall__c = recall;
            }
            // Get contact details onto SA for SMS/emails
            if (String.isNotBlank(sa.ContactId)) {
              Contact con = contactsById.get(sa.ContactId);
              sa.Contact_Email__c = con.Email;
              sa.Contact_Mobile__c = con.MobilePhone;
              sa.Contact_Mobile_Email__c = con.Mobile_Phone_Email__c;
              sa.Contact_First_Name__c = con.FirstName;
            }
          }
        } catch (Exception e) {
          System.debug('************************** Exception in ServiceAppt_Updates trigger:' + e.getStackTraceString());
        }
    }
}