/**
 * 
 * @author 
 * @since 
 */
public with sharing class ServiceAppointmentIterable implements Iterable<ServiceAppointmentWrapper> {

    private List<ServiceAppointmentWrapper> records;

    /**
     * 
     * @param records 
     */
    public ServiceAppointmentIterable(List<ServiceAppointmentWrapper> records) {
        this.records = records;
    }

    /**
     * 
     */
    public Iterator<ServiceAppointmentWrapper> Iterator() {
        return new ServiceAppointmentIterator(records);
    }
}