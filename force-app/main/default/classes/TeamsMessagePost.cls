global class TeamsMessagePost {
    @InvocableMethod(label='postTeamsMessage' description='Post message to specified Teams channel')
    global static void postTeamsMessage(getParameters[] requests) {
        for (getParameters request : requests) {
            callWebService(request.teamName, request.postedBy, request.title, request.message, request.url);
        }
    }       

    @future(callout=true)
    public static void callWebService(String teamName, String postedBy, String title, String message, String url){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Teams_URIs__c tURI = Teams_URIs__c.getInstance(teamName);
        string URI = tURI.URI__c;
        System.debug('***** URI: ' + URI);
        request.setEndpoint(URI);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        String msg = '{"@context": "https://schema.org/extensions","@type": "MessageCard","potentialAction": [' +
                         '{"@type": "OpenUri","name": "View Details","targets":[{"os": "default",' +
                         '"uri": "' + url + '"' +
                         '}]}],"sections":[{"facts":[' +
                         '{"name": "Posted By:","value": "' + postedBy + '"},' +
                         '{"name": "Posted At:","value": "Now"}],' +
                         '"text": "' + message + '"}],' +
                         '"summary": "Summary...",' +
                         '"themeColor": "0072C6",' +
                         '"title": "' + title + '"}';
        request.setBody(msg);
        System.debug('***** MSG: ' + msg);
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
    }
    
    global class getParameters {
        @InvocableVariable(required=true)
        global String teamName;
        
        @InvocableVariable(required=true)
        global String postedBy;
        
        @InvocableVariable(required=true)
        global String title;
        
        @InvocableVariable(required=true)
        global String message;
        
        @InvocableVariable(required=true)
        global String url;
    }   
}