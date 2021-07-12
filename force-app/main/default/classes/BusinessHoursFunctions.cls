global class BusinessHoursFunctions {

    @InvocableMethod(label='getDueDate' description='getDueDate for SLA via Business Hours')
    global static List<DateTime> getDueDate(getDueDateParameters[] requests)
    {
        List<Datetime> dateTimes = new List<Datetime>();
        for (getDueDateParameters request : requests) {
            BusinessHours bh = [select Id from BusinessHours where Name = :request.businessHoursName limit 1];
            Long duration = (long)(request.days * (request.hoursPerDay * 3600000)); //1 hour in milliseconds
            DateTime dueDate = BusinessHours.add(bh.Id, request.startDate, duration);
            dateTimes.add(dueDate);
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