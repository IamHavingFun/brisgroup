@isTest(SeeAllData = True)
private class BusinessHoursFunctionsTest {

    static testMethod void myUnitTest() {
        // Now, create the argument data structure for the InvocableMethod
        BusinessHoursFunctions.getDueDateParameters argument;
        argument = new BusinessHoursFunctions.getDueDateParameters();
        argument.businessHoursName = 'Customer Contact';
        argument.startDate = datetime.now();
        argument.days = 3;
        argument.hoursPerDay = 8.5;
        
        Test.StartTest();
        List<DateTime> dates = BusinessHoursFunctions.getDueDate(new List<BusinessHoursFunctions.getDueDateParameters>{ argument });
        Test.StopTest();
        System.assertNotEquals(null, dates);
    }
}