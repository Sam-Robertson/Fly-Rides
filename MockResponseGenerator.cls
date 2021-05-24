@isTest
global class MockResponseGenerator implements HttpCalloutMock {
  
   // Implement this interface method
   global HTTPResponse respond(HTTPRequest req) {
       // Optionally, only send a mock response for a specific endpoint
       // and method.
       // System.assertEquals('http://example.com/example/test', req.getEndpoint());
       // System.assertEquals('GET', req.getMethod());
     
      
       // Create a fake response
       HttpResponse res = new HttpResponse();
       res.setHeader('Content-Type', 'application/json');
       res.setBody('{"access_token": "ce1dabc48f066e52eafc93a76b354afdae9b11bf",'
       +'"expires_in": 1800,'
       +'"token_type": "bearer",'
       +'"scope": "employee:register_read systemuserid:911379",' 
       +'"Item": [{"itemID": "20", "description": "Matrix"}],' 
       +'"Tag": [{"tagID": "3", "name": "test"}],' 
       +'"Sale": [{"saleID": "7", "ticketNumber": "10",  "completeTime": "2021-01-01"}],' 
       +'"Customer": [{"customerID": "7",  "firstName": "Alex", "lastName": "Lugo"}],' 
       +'"@attributes": { "count": "2529",  "offset": "0","limit": "100"}}');
       res.setStatusCode(200);
       return res;
   }
}