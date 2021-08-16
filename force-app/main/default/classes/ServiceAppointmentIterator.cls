/**
 * @author PolSource
 * @since 
 */
public with sharing class ServiceAppointmentIterator implements Iterator<ServiceAppointmentWrapper> {

    List<ServiceAppointmentWrapper> results {get; set;}

    //  tracks which result item is returned
    Integer index {get; set;} 

    /**
     * 
     * @param records 
     */
    public ServiceAppointmentIterator(List<ServiceAppointmentWrapper> records) {
        index = 0;
        results = records;
    } 
    
    /**
     * 
     * @return  `boolean`
     */
    public boolean hasNext() {
        return results != null && !results.isEmpty() && index < results.size(); 
    }
    
    /**
     * 
     * @return  `ServiceAppointmentWrapper`
     */
    public ServiceAppointmentWrapper next() {
        return results[index++];
    } 
}