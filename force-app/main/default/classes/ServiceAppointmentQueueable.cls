/**
 * 
 * @author 
 * @since 
 */
public with sharing class ServiceAppointmentQueueable implements Queueable {

    private ServiceAppointmentWrapper wrapper;

    /**
     * 
     * @param wrapper 
     */
    public ServiceAppointmentQueueable(ServiceAppointmentWrapper wrapper) {
        this.wrapper = wrapper;
    }

    /**
     * 
     * @param context 
     */
    public void execute(QueueableContext context) {
        try {
            // Create WO
            WorkOrder WO = new Workorder();
            WO.WorkTypeId = wrapper.workTypeId;
            WO.Job_Address_Line_1__c = wrapper.addy1;
            WO.Job_Town__c = wrapper.city;
            WO.Job_County__c = wrapper.county;
            WO.Job_Postcode__c = wrapper.postcode;
            WO.Job_Country__c = wrapper.county;
            insert WO;
            System.debug('#K# WO ID ' + WO.Id);
            WO.ServiceTerritoryId = wrapper.territoryId;
            update WO;
            ID WOId = WO.Id;
            // Create SA
            ServiceAppointment SA = new ServiceAppointment();
            SA.RecordTypeId = wrapper.recordTypeId;
            SA.ParentRecordId = WOId;
            SA.EarliestStartTime = wrapper.startDate;
            SA.DueDate = wrapper.endDate.addHours(2);
            SA.ArrivalWindowStartTime = wrapper.startDate;
            SA.ArrivalWindowEndTime = wrapper.endDate.addHours(1);
            SA.SchedStartTime = wrapper.startDate;
            SA.SchedEndTime = wrapper.endDate;
            SA.Status = 'None';
            insert SA;
            ID SAId = SA.Id;
            // Create Assigned Resource
            AssignedResource AR = new AssignedResource();
            AR.ServiceResourceId = wrapper.resourceId;
            AR.ServiceAppointmentId = SAId;
            insert AR;
            // Schedule SA
            if (wrapper.pin == 'Y') {
                SA.Status = 'Scheduled';
                SA.FSL__Pinned__c = true;
                update SA;
                SA.Status = 'Dispatched';
                update SA;
            }
            else {
                SA.Status = 'Scheduled';
                SA.FSL__Pinned__c = false;
                update SA;
            }            
        } catch (Exception e) {
            system.debug('******ERROR GENERATING DAY START/ENDS: ' + e);
        }
    }

}
