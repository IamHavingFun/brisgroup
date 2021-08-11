/**
 * 
 * @author 
 * @since 
 */
public with sharing class ServiceAppointmentBatch implements Database.Batchable<ServiceAppointmentWrapper>, Database.AllowsCallouts {
    
    private List<ServiceAppointmentWrapper> records;

    /**
     * 
     * @param records 
     */
    public ServiceAppointmentBatch(List<ServiceAppointmentWrapper> records) {
        this.records = records;
    }

    /**
     * 
     * @param bc 
     * @return  `Iterable<ServiceAppointmentWrapper>`
     */
    public Iterable<ServiceAppointmentWrapper> start(Database.BatchableContext bc) {
        return new ServiceAppointmentIterable(records);
    }

    /**
     * 
     * @param bc 
     * @param scope 
     */
    public void execute(Database.BatchableContext bc, List<ServiceAppointmentWrapper> scope) {        
        try {
            ServiceAppointmentWrapper wrapper = scope.get(0);
            // Queuable job is needed since there is a trigger that performs a callout
            // so DML operations upon AssignedResource object must be performed from within
            // a @future method or a Queuable method
            // @future methods are not allowed to be called from batch
            // (Exception thrown if operation is not in an async context: `Callout from triggers are currently not supported`)
            System.enqueueJob(new ServiceAppointmentQueueable(wrapper));
        } catch (Exception e) {
            system.debug('******ERROR GENERATING DAY START/ENDS: ' + e);
        }
    }

    /**
     * 
     * @param bc 
     */
    public void finish(Database.BatchableContext bc) {

    }
}
