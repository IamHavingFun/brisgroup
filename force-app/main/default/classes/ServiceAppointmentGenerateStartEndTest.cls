/**
 * @author 
 * @since 
 */
@IsTest
private class ServiceAppointmentGenerateStartEndTest {
  
    @TestSetup
    static void initData() {
        User contextuser = TestUtilityDataFactory.insertSystemUser('System Administrator', 'tmp');
        WorkType engineerDayStart = new WorkType(
            Name = 'Engineer Day Start',
            EstimatedDuration = 1
        );
        WorkType engineerDayEnd = new WorkType(
            Name = 'Engineer Day End',
            EstimatedDuration = 1
        );
        WorkType dropboxCollection = new WorkType(
            Name = 'Drop Box Collection',
            EstimatedDuration = 1
        );
        List<WorkType> workTypes = new List<WorkType>{engineerDayStart, engineerDayEnd, dropboxCollection};
        insert workTypes;

        FSL__c fsl = new FSL__c(
            Name = 'DaysToAdd',
            Value__c = 1
        );
        insert fsl;

        ServiceResource serviceResource = new ServiceResource(
            Name = 'Test',
            ResourceType = 'T',
            RelatedRecordId = contextuser.Id,
            IsActive = true
        );
        insert serviceResource;

        OperatingHours operatingHours = new OperatingHours(
            Name = 'TEST',
            TimeZone = 'America/Chicago'
        );
        insert operatingHours;

        ServiceTerritory serviceTerritory = new ServiceTerritory(
            Name = 'E1',
            OperatingHoursId = operatingHours.Id,
            IsActive = true
        );
        insert serviceTerritory;

        ServiceTerritoryMember serviceTerritoryMember = new ServiceTerritoryMember(
            ServiceResourceId = serviceResource.Id,
            ServiceTerritoryId = serviceTerritory.Id,
            TerritoryType = 'P',
            EffectiveStartDate = Date.today(),
            EffectiveEndDate = Date.today().addDays(7),
            Street = 'St Unit C',
            City = 'Los Angeles',
            State = 'CA',
            PostalCode = '90014',
            Country = 'US',
            Drop_Box_Address_1__c = 'St Unit C',
            Drop_Box_City__c = 'Los Angeles',
            Drop_Box_County__c = 'CA',
            Drop_Box_Postcode__c = '90014',
            Drop_Box_Country__c = 'US'
        );
        insert serviceTerritoryMember;
        
        // Time Slot
        Datetime dayCheck = System.today().addDays(1);
        string dayOfWeek = dayCheck.format('EEEE');
        TimeSlot timeSlot = new TimeSlot(
            DayOfWeek = dayOfWeek,
            StartTime = Time.newInstance(8, 0, 0, 0),
            EndTime = Time.newInstance(17, 0, 0, 0),
            OperatingHoursId = operatingHours.Id
        );
        insert timeSlot;
    }

    @IsTest
    static void validateRecords() {
 
        ServiceAppointmentGenerateStartEnd sag = new ServiceAppointmentGenerateStartEnd();
        Test.startTest();
        sag.execute(null);
        Test.stopTest();
        List<WorkOrder> workOrders = [SELECT Id FROM WorkOrder];
        System.assert(!workOrders.isEmpty(), 'Work Orders were not created');
    }
}