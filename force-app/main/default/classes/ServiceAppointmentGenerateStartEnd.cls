public class ServiceAppointmentGenerateStartEnd Implements Schedulable {
    List<ServiceTerritoryMember> members = new List<ServiceTerritoryMember>();
    time startTimeSlot = null;
    time endTimeSlot = null;    
    string dayStartId, dayEndId, dropboxId;
    string dayStartRecordId, dayEndRecordId, dropboxRecordId;    
    string addy1, city, county, postcode, country;
    string dbaddy1, dbcity, dbcounty, dbpostcode, dbcountry;
    integer daysToAdd = 0;
    
    public void execute(SchedulableContext sc)
    {
        startPoint();
    }
   
    public void startPoint()
    {
        try {
            // Get 'Days to Add' value from custom setting
            FSL__c csDays = FSL__c.getInstance('DaysToAdd');
            daysToAdd = csDays.Value__c.intValue();
            Date dNow = System.today().addDays(daysToAdd);
            DateTime dtNow = datetime.newInstance(dNow, Time.newInstance(12,00,00,00));
            // Fetch territory members
            members = getMembers(dtNow);
            // Get Work Type IDs
            dayStartId = getRecordId('Engineer Day Start');
            system.debug('****** DAY START ID: ' + dayStartId);
            dayEndId = getRecordId('Engineer Day End');
            system.debug('****** DAY END ID: ' + dayEndId);   
            dropboxId = getRecordId('Drop Box Collection');
            system.debug('****** DROPBOX ID: ' + dropboxId);    
            // Get record type IDs         
            dayStartRecordId = getRecordTypeId('Day_Start');
            system.debug('****** DAY START RECORD ID: ' + dayStartRecordId);   
            dayEndRecordId = getRecordTypeId('Day_End');         
            system.debug('****** DAY END RECORD ID: ' + dayEndRecordId);   
            dropboxRecordId = getRecordTypeId('Dropbox');         
            system.debug('****** DROPBOX RECORD ID: ' + dropboxRecordId);               
            
            if(members != null) {
                // Loop territory members
                system.debug('****** MEMBERS: ' + members);
                for(ServiceTerritoryMember member : members) {
                    // Get earliest time slot
                    startTimeSlot = null;
                    endTimeSlot = null;
                    Date dayCheck = System.today().addDays(daysToAdd);
                    if(member.OperatingHoursId != null) {
                        startTimeSlot = getTimeSlot(member.OperatingHoursId, dayCheck, 'First');
                        endTimeSlot = getTimeSlot(member.OperatingHoursId, dayCheck, 'Last');
                    }
                    else {
                        startTimeSlot = getTimeSlot(member.ServiceTerritory.OperatingHoursId, dayCheck, 'First');
                        endTimeSlot = getTimeSlot(member.ServiceTerritory.OperatingHoursId, dayCheck, 'Last');
                    }
                    // Only create day start/end records if a start timeslot is found (won't be found on non working days)
                    if(startTimeSlot != null) {
                        // Set appointment date
                        Date d = System.today().addDays(daysToAdd);
                        // Set 'day end' start time
                        endTimeSlot = endTimeSlot.addMinutes(-15);
                        DateTime dtEnd = datetime.newInstance(d, Time.newInstance(endTimeSlot.hour(),endTimeSlot.minute(),endTimeSlot.second(),00));
                        // Set 'dropbox' start time
                        startTimeSlot = startTimeSlot.addMinutes(15);
                        DateTime dtDropboxStart = datetime.newInstance(d, Time.newInstance(startTimeSlot.hour(),startTimeSlot.minute(),startTimeSlot.second(),00));
                        // Set 'day start' start time
                        startTimeSlot = startTimeSlot.addMinutes(-15);                    
                        DateTime dtStart = datetime.newInstance(d, Time.newInstance(startTimeSlot.hour(),startTimeSlot.minute(),startTimeSlot.second(),00));
                        system.debug('****** START DATE: ' + dtStart);
                        system.debug('****** END DATE: ' + dtEnd); 
                        system.debug('****** DROPBOX DATE: ' + dtDropboxStart);               
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
                        addRecords(dtStart, dtStart.addMinutes(15), member.ServiceResourceId, dayStartId,
                            dayStartRecordId, addy1, city, county, postcode, country, 'Y', member.ServiceTerritoryId);
                        // create day end appt
                        addRecords(dtEnd, dtEnd.addMinutes(15), member.ServiceResourceId, dayEndId,
                            dayEndRecordId, addy1, city, county, postcode, country, 'Y', member.ServiceTerritoryId);
                        // Check if dropbox appt is needed
                        String dayOfWeek = dtDropboxStart.format('E');
                        if(dayOfWeek == 'Mon' || dayOfWeek == 'Wed' || dayOfWeek == 'Fri') {
                            // create drop box appt
                            addRecords(dtDropboxStart, dtDropboxStart.addMinutes(10), member.ServiceResourceId, dropboxId,
                                dropboxRecordId, dbaddy1, dbcity, dbcounty, dbpostcode, dbcountry, '', member.ServiceTerritoryId);
                        }
                    }
                }
                initCreateRecords(workOrders);
            }
            else {
                system.debug('******NO TERRITORY MEMBERS FOUND');
                return;
            }
        } catch(exception e) {
            system.debug('******ERROR GENERATING DAY START/ENDS: ' + e.getStackTraceString());
            return;
        }
    }

    List<String> workOrders = new List<String>();
    public void addRecords(Datetime t_startDate, Datetime t_endDate, String t_resourceId,
            String t_workTypeId, String t_recordTypeId, String t_addy1, String t_city, String t_county, String t_postcode, String t_country, String t_pin, String t_territoryId) {
            workOrders.add(JSON.serialize(
                    new WorkOrderHelper(
                            t_startDate, t_endDate, t_resourceId, t_workTypeId,
                            t_recordTypeId, t_addy1, t_city, t_county, t_postcode, t_country, t_pin, t_territoryId
                    )
            ));
    }

    public with sharing class WorkOrderHelper {

        public Datetime startDate {set; get;}
        public Datetime endDate {set; get;}
        public String resourceId {set; get;}
        public String workTypeId {set; get;}
        public String recordTypeId {set; get;}
        public String addy1 {set; get;}
        public String city {set; get;}
        public String county {set; get;}
        public String postcode {set; get;}
        public String country {set; get;}
        public String pin {set; get;}
        public String territoryId {set; get;}

        public WorkOrderHelper(Datetime t_startDate, Datetime t_endDate, String t_resourceId,
                String t_workTypeId, String t_recordTypeId, String t_addy1, String t_city, String t_county, String t_postcode, String t_country, String t_pin, String t_territoryId) {
            startDate = t_startDate;
            endDate = t_endDate;
            resourceId = t_resourceId;
            workTypeId = t_workTypeId;
            recordTypeId = t_recordTypeId;
            addy1 = t_addy1;
            city = t_city;
            county = t_county;
            postcode = t_postcode;
            country = t_country;
            pin = t_pin;
            territoryId = t_territoryId;
        }
    }

    @future(callout=true)
    public static void initCreateRecords(List<String> workOrders) {
        WorkOrderHelper currentWorkOrder;
        for (String wo : workOrders)
        {

            currentWorkOrder = (WorkOrderHelper) JSON.deserialize(wo, WorkOrderHelper.class);
            System.debug('Deserialized in future:'+currentWorkOrder.city);
            createRecords(currentWorkOrder.startDate,currentWorkOrder.endDate,currentWorkOrder.resourceId,
                    currentWorkOrder.workTypeId,currentWorkOrder.recordTypeId,currentWorkOrder.addy1,currentWorkOrder.city,currentWorkOrder.county,currentWorkOrder.postcode,currentWorkOrder.country, currentWorkOrder.pin, currentWorkOrder.territoryId);
        }
    }

    // Create WO / SA / AR
    //@future(callout=true)
    public static void createRecords(datetime startDate, datetime endDate, string resourceId, 
      string workTypeId, string recordTypeId, string addy1, string city, string county, string postcode, string country, string pin, string territoryId) {
        // Create WO
        WorkOrder WO = new Workorder();
        WO.WorkTypeId = workTypeId;
        WO.Job_Address_Line_1__c = addy1;
        WO.Job_Town__c = city;
        WO.Job_County__c = county;
        WO.Job_Postcode__c = postcode;
        WO.Job_Country__c = country;
        insert WO;
        WO.ServiceTerritoryId = territoryId;
        update WO;
        ID WOId = WO.Id;
        // Create SA
        ServiceAppointment SA = new ServiceAppointment();
        SA.RecordTypeId = recordTypeId;
        SA.ParentRecordId = WOId;
        SA.EarliestStartTime = startDate;
        SA.DueDate = endDate.addHours(2);
        SA.ArrivalWindowStartTime = startDate;
        SA.ArrivalWindowEndTime = endDate.addHours(1);
        SA.SchedStartTime = startDate;
        SA.SchedEndTime = endDate;
        SA.Status = 'None';
        insert SA;
        ID SAId = SA.Id;
        // Create Assigned Resource
        AssignedResource AR = new AssignedResource();
        AR.ServiceResourceId = resourceId;
        AR.ServiceAppointmentId = SAId;
        insert AR;
        // Schedule SA
        if(pin == 'Y') {
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
    }

    // Get RecordTypeID for Service Appointment
    public static string getRecordTypeId(string SAType) {
        string recordTypeId = [SELECT Id FROM RecordType WHERE SobjectType = 'ServiceAppointment' AND DeveloperName = :SAType LIMIT 1].Id;
        return recordTypeId;
    }
    
    // Get Work Order Record ID
    public static string getRecordId(string workType) {
        string recordId= [SELECT Id FROM WorkType WHERE Name = :workType LIMIT 1].Id;
        return recordId;    
    }

    // Get Territory Members/Service Resources/Operating Hours
    public static List<ServiceTerritoryMember> getMembers(DateTime dtNow) {
        List<ServiceTerritoryMember> result = [SELECT Id, TerritoryType, ServiceResourceId, ServiceTerritoryId, OperatingHoursId, 
          ServiceTerritory.OperatingHoursId, Street, City, State, PostalCode, Country, Drop_Box_Address_1__c, Drop_Box_City__c, Drop_Box_County__c,
          Drop_Box_Postcode__c, Drop_Box_Country__c FROM ServiceTerritoryMember WHERE TerritoryType = 'P' 
          and EffectiveStartDate <= :dtNow and EffectiveEndDate >= :dtNow];
        return result;
    }
    
    // Get Time Slot
    public static time getTimeSlot(string hoursId, datetime dayCheck, string slotType) {
        string dayOfWeek = dayCheck.format('EEEE');
        List<TimeSlot> slots = new List<TimeSlot>();
        time slotTime = null;
        
        slots = [select DayOfWeek, StartTime, EndTime from TimeSlot where OperatingHoursId = :hoursId and DayOfWeek = :dayOfWeek];

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