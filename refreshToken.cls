public class refreshToken {
    public static String runRefresh() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://cloud.lightspeedapp.com/oauth/access_token.php'); 
        request.setMethod('POST');
        string body = '{"client_id": "18cf661b3bfe5725fe3c194ff29b37d59a46f4651add5303a210354fa3599861", "client_secret": "f4f84af7126595106f53f0b1b40e45de208d32d110b135597ae658ac187260c8", "refresh_token": "9d4946b88a48c7a43b580627b86c86b352fee572", "grant_type": "refresh_token"}';  
        request.setBody(body);
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        system.debug(response); 
        system.debug(response.getStatusCode()); 
        string accessToken;
        if (response.getStatusCode() == 204 || String.isBlank(response.getBody())) {return null;}
        if (response.getStatusCode() == 200) {
            try { 
			
                map<string,Object> resultMap = (map<string,Object>)JSON.deserializeUntyped(response.getBody()); 
               
              
                accessToken = (String)resultMap.get('access_token');

                timeStamp__c lastPull =  timeStamp__c.getorgdefaults();
              

           
                System.debug(accessToken);

                

            }catch (DMLException e) {
                System.debug('Error is' + e);
               
                
            }
        }
        System.debug('access token is' + accessToken);
       return accessToken;
       
    }
}