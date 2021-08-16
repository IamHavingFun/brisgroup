/**
 * 
 * @author 
 * @since 
 */
public with sharing class ServiceAppointmentWrapper {

    public Datetime startDate;
    public Datetime endDate;
    public String resourceId;
    public String workTypeId;
    public String recordTypeId;
    public String addy1;
    public String city;
    public String county;
    public String postcode;
    public String country;
    public String pin;
    public String territoryId;

    /**
     * 
     * @param startDate 
     * @param endDate 
     * @param resourceId 
     * @param workTypeId 
     * @param recordTypeId 
     * @param addy1 
     * @param city 
     * @param county 
     * @param postcode 
     * @param country 
     * @param pin 
     * @param territoryId 
     */
    public ServiceAppointmentWrapper(Datetime startDate, Datetime endDate, String resourceId,
    String workTypeId, String recordTypeId, String addy1, String city, String county, String postcode, String country, String pin, String territoryId) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.resourceId = resourceId;
        this.workTypeId = workTypeId;
        this.recordTypeId = recordTypeId;
        this.addy1 = addy1;
        this.city = city;
        this.county = county;
        this.postcode = postcode;
        this.country = country;
        this.pin = pin;
        this.territoryId = territoryId;
    }
}