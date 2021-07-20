global class BusinessHoursFunctions {

    @InvocableMethod(label='getDueDate' description='getDueDate for SLA via Business Hours')
    global static List<DateTime> getDueDate(getDueDateParameters[] requests)
    {
        List<Datetime> dateTimes = new List<Datetime>();
        List<String> businessHourNames = new List<String>();
        // create a list with all business hour names
        for (getDueDateParameters request : requests) {
            businessHourNames.add(request.businessHoursName);
        }
        // returns the record based on its name.
        Map<String, BusinessHours> businessHourByName = new Map<String, BusinessHours>();
        // query and loop BusinessHours records that match any of the names on the list
        for (BusinessHours bh : [SELECT Id, Name FROM BusinessHours WHERE Name IN :businessHourNames]) {
            businessHourByName.put(bh.Name, bh);
        }
        for (getDueDateParameters request : requests) {
            if (businessHourByName.containsKey(request.businessHoursName)) {
                BusinessHours bh = businessHourByName.get(request.businessHoursName);
                Long duration = (long)(request.days * (request.hoursPerDay * 3600000)); //1 hour in milliseconds
                // Adds an interval of time from a start Datetime traversing business hours only. Returns the result Datetime in the local time zone.
                DateTime dueDate = BusinessHours.add(bh.Id, request.startDate, duration);
                dateTimes.add(dueDate);
            }
        }
        return dateTimes;
    }
    
    global class getDueDateParameters {
        @InvocableVariable(required=true)
        global String businessHoursName;
        
        @InvocableVariable(required=true)
        global DateTime startDate;
        
        @InvocableVariable(required=true)
        global Integer days;
        
        @InvocableVariable(required=true)
        global Double hoursPerDay;
    }  
}