public with sharing class lightspeedCallout {
    public static  list<Integration_Data__c> lightspeedCallout(Integer accountNumber, String apiToken, String myObject, String myEndpoint) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        System.debug(accountNumber);
        System.debug( 'This is the Endpoint I am hitting ' + myEndpoint);
        request.setEndpoint('https://api.lightspeedapp.com/API/Account/' + accountNumber + myEndpoint); 
        request.setMethod('GET');
        request.setHeader('Authorization', 'bearer ' + apiToken);
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        System.debug('The token I am using is ' + apiToken);
        System.debug('https://api.lightspeedapp.com/API/Account/' + accountNumber + myEndpoint);
        HttpResponse response = http.send(request);
        list<Integration_Data__c> myIntegration = new List<Integration_Data__c>();
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            try { 
                Map<String,Object> dataMap = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
                Map<String,Object> countMap = (Map<String,Object>)dataMap.get('Count');
                System.debug(countMap);
                if (dataMap.get(myObject) == null){
                   system.debug('No new objects');
                
                }
                else {
                    List<object> myObjects = (List<object>)dataMap.get(myObject);
                    // System.debug(response.getBody());
                    for (object o : myObjects) {
                    // System.debug(JSON.serialize(o));
                    myIntegration.add(ing_endpoint.processdata(myObject, JSON.serialize(o)));
                    }
                }
            }catch (DMLException e) {
                        System.debug('Error is' + e);
                        
            }
            System.debug('Testing one two three');
        }
         return myIntegration;
    }
}