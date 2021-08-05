/**
 * 
 * @author 
 * @since 
 */
@IsTest
private class TeamsMessagePostTest {

    @TestSetup
    static void initData() {
        Teams_URIs__c teamUri = new Teams_URIs__c(
            Name = 'RF_Broadcast',
            URI__c = 'https://www.google.co.uk'
        );
        insert teamUri;        
    }

    @IsTest
    static void myUnitTest() {
        Boolean success = true;
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
        try {
            TeamsMessagePost.postTeamsMessage(new List<TeamsMessagePost.getParameters>{ argument });
        } catch (Exception e) {
            success = false;
        }        
        Test.StopTest();
        System.assert(success, 'Exception was thrown by callout method');
    }
}