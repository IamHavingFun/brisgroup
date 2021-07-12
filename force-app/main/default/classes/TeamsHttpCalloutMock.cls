@isTest
global class TeamsHttpCalloutMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"@context": "https://schema.org/extensions","@type": "MessageCard","potentialAction": [{"@type": "OpenUri","name": "View in RF","targets":[{"os": "default",                    "uri": "https://google.co.uk"}]}],"sections":[{"facts":[{"name": "Posted By:","value": "Dave"},{"name": "Posted At:","value": "Now"}],"text": "An Outage has been logged in RF."}],"summary": "Teams message from SFDC","themeColor": "0072C6","title": "Teams message from SFDC"}');
        response.setStatusCode(200);
        return response; 
    }
}