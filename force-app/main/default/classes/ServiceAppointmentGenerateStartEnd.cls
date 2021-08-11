/**
 * @author 
 * @since 
 */
public without sharing class ServiceAppointmentGenerateStartEnd implements Schedulable {

    List<ServiceTerritoryMember> members = new List<ServiceTerritoryMember>();
    Time startTimeSlot = null;
    Time endTimeSlot = null;
    String dayStartId, dayEndId, dropboxId;
    String dayStartRecordId, dayEndRecordId, dropboxRecordId;
    String addy1, city, county, postcode, country;
    String dbaddy1, dbcity, dbcounty, dbpostcode, dbcountry;
    Integer daysToAdd = 0;

    /**
     * @param sc 
     */
    public void execute(SchedulableContext sc) {
        startPoint();
    }

    /**
     * 
     */
    public void startPoint() {
        try {
            List<ServiceAppointmentWrapper> records = new List<ServiceAppointmentWrapper>();
            // Get 'Days to Add' value from custom setting
            FSL__c csDays = FSL__c.getInstance('DaysToAdd');
            daysToAdd = csDays.Value__c.intValue();
            Date dNow = System.today().addDays(daysToAdd);
            DateTime dtNow = Datetime.newInstance(dNow, Time.newInstance(12,00,00,00));
            // Fetch territory members
            members = getMembers(dtNow);
            // Get Work Type IDs
            dayStartId = getRecordId('Engineer Day Start');
            dayEndId = getRecordId('Engineer Day End');
            dropboxId = getRecordId('Drop Box Collection');
            // Get record type IDs
            dayStartRecordId = getRecordTypeId('Day_Start');
            dayEndRecordId = getRecordTypeId('Day_End');
            dropboxRecordId = getRecordTypeId('Dropbox');

            if (members == null) {
                return;

            } else {
                // Loop territory members
                for(ServiceTerritoryMember member : members) {
                    // Get earliest Time slot
                    startTimeSlot = null;
                    endTimeSlot = null;
                    Date dayCheck = System.today().addDays(daysToAdd);
                    if (String.isNotBlank(member.OperatingHoursId)) {
                        startTimeSlot = getTimeSlot(member.OperatingHoursId, dayCheck, 'First');
                        endTimeSlot = getTimeSlot(member.OperatingHoursId, dayCheck, 'Last');
                    } else {
                        startTimeSlot = getTimeSlot(member.ServiceTerritory.OperatingHoursId, dayCheck, 'First');
                        endTimeSlot = getTimeSlot(member.ServiceTerritory.OperatingHoursId, dayCheck, 'Last');
                    }
                    // Only create day start/end records if a start timeslot is found (won't be found on non working days)
                    if(startTimeSlot != null) {
                        // Set appointment date
                        Date d = System.today().addDays(daysToAdd);
                        // Set 'day end' start Time
                        endTimeSlot = endTimeSlot.addMinutes(-15);
                        DateTime dtEnd = Datetime.newInstance(d, Time.newInstance(endTimeSlot.hour(),endTimeSlot.minute(),endTimeSlot.second(),00));
                        // Set 'dropbox' start Time
                        startTimeSlot = startTimeSlot.addMinutes(15);
                        DateTime dtDropboxStart = Datetime.newInstance(d, Time.newInstance(startTimeSlot.hour(),startTimeSlot.minute(),startTimeSlot.second(),00));
                        // Set 'day start' start Time
                        startTimeSlot = startTimeSlot.addMinutes(-15);
                        DateTime dtStart = Datetime.newInstance(d, Time.newInstance(startTimeSlot.hour(),startTimeSlot.minute(),startTimeSlot.second(),00));
                        // Get engineer address details
                        addy1 = member.Street;
                        city = member.City;
                        county = member.State;
                        postcode = member.PostalCode;
                        country = member.Country;
                        // Get dropbox address details
                        dbaddy1 = member.Drop_Box_Address_1__c;
                        dbcity = member.Drop_Box_City__c;
                        dbcounty = member.Drop_Box_County__c;
                        dbpostcode = member.Drop_Box_Postcode__c;
                        dbcountry = member.Drop_Box_Country__c;
                        // Create day start appt
                        records.add(new ServiceAppointmentWrapper(dtStart, dtStart.addMinutes(15), member.ServiceResourceId, dayStartId, 
                            dayStartRecordId, addy1, city, county, postcode, country, 'Y', member.ServiceTerritoryId));
                        // create day end appt
                        records.add(new ServiceAppointmentWrapper(dtEnd, dtEnd.addMinutes(15), member.ServiceResourceId, dayEndId,
                            dayEndRecordId, addy1, city, county, postcode, country, 'Y', member.ServiceTerritoryId));
                        // Check if dropbox appt is needed
                        String dayOfWeek = dtDropboxStart.format('E');
                        if(dayOfWeek == 'Mon' || dayOfWeek == 'Wed' || dayOfWeek == 'Fri') {
                            // create drop box appt
                            records.add(new ServiceAppointmentWrapper(dtDropboxStart, dtDropboxStart.addMinutes(10), member.ServiceResourceId, dropboxId,
                                dropboxRecordId, dbaddy1, dbcity, dbcounty, dbpostcode, dbcountry, '', member.ServiceTerritoryId));
                        }
                    }
                }
            }
            if (!records.isEmpty()) {
                // call batch
                Database.executeBatch(new ServiceAppointmentBatch(records), 1);
            }
        } catch(exception e) {
            return;
        }
    }

    /**
     * Get RecordTypeID for Service Appointment
     * @param SAType 
     * @return  `String`
     */
    public static String getRecordTypeId(String SAType) {
        return [SELECT Id FROM RecordType WHERE SobjectType = 'ServiceAppointment' AND DeveloperName = :SAType LIMIT 1].Id;
    }

    /**
     * Get Work Order Record ID
     * @param workType 
     * @return  `String`
     */
    public static String getRecordId(String workType) {
        return [SELECT Id FROM WorkType WHERE Name = :workType LIMIT 1].Id;
    }

    /**
     * Get Territory Members/Service Resources/Operating Hours
     * @param dtNow 
     * @return  `List<ServiceTerritoryMember>`
     */
    public static List<ServiceTerritoryMember> getMembers(DateTime dtNow) {
        return [SELECT Id, TerritoryType, ServiceResourceId, ServiceTerritoryId, OperatingHoursId,
                ServiceTerritory.OperatingHoursId, Street, City, State, PostalCode, Country, Drop_Box_Address_1__c, Drop_Box_City__c, Drop_Box_County__c,
                Drop_Box_Postcode__c, Drop_Box_Country__c FROM ServiceTerritoryMember WHERE TerritoryType = 'P'
        and EffectiveStartDate <= :dtNow and EffectiveEndDate >= :dtNow];        
    }

    /**
     * Get Time Slot
     * @param hoursId 
     * @param dayCheck 
     * @param slotType 
     * @return  `Time`
     */
    public static Time getTimeSlot(String hoursId, Datetime dayCheck, String slotType) {
        String dayOfWeek = dayCheck.format('EEEE');
        List<TimeSlot> slots = new List<TimeSlot>();
        Time slotTime = null;

        slots = [SELECT DayOfWeek, StartTime, EndTime FROM TimeSlot WHERE OperatingHoursId = :hoursId and DayOfWeek = :dayOfWeek];

        if(slotType == 'First') {
            for(TimeSlot slot : slots) {
                if(slotTime== null || slot.StartTime < slotTime)
                    slotTime= slot.StartTime;
            }
        }
        else {
            for(TimeSlot slot : slots) {
                if(slotTime== null || slot.EndTime > slotTime)
                    slotTime= slot.EndTime;
            }
        }
        system.debug('****** TIMESLOT: ' + slotTime);
        return slotTime;
    }
}