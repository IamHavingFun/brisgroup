@isTest(SeeAllData = True)
private class TeamsMessagePostTest {

    static testMethod void myUnitTest() {
        // Now, create the argument data structure for the InvocableMethod
        TeamsMessagePost.getParameters argument;
        argument = new TeamsMessagePost.getParameters();
        argument.teamName = 'RF_Broadcast';
        argument.postedBy = 'Steve';
        argument.title = 'Title';
        argument.message = 'Message';
        argument.url = 'https://www.google.co.uk';
        
        Test.StartTest();
        Test.setMock(HttpCalloutMock.class, new TeamsHttpCalloutMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        TeamsMessagePost.postTeamsMessage(new List<TeamsMessagePost.getParameters>{ argument });
        Test.StopTest();
    }
}