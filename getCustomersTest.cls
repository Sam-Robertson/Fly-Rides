@IsTest
public with sharing class getCustomersTest {
    @IsTest
    public static void getCustomersTest() {

        test.setMock(httpcalloutmock.class, new MockResponseGenerator());

        String myAccessToken = refreshToken.runRefresh();
        System.debug('Holla');

        List<Integration_Data__c> finalIntegrationData = new  List<Integration_Data__c>();


        List<endpoint__c> myEndpoints = new List<endpoint__c>();  
        List<mapping__c> myMappings = new List<mapping__c>();  

        endpoint__c myItemEndpoint= new endpoint__c (Name = 'Item', Salesforce_object__c = 'Product');  
        endpoint__c myTagEndpoint = new endpoint__c (name = 'Tag', Salesforce_object__c = 'Tag__c');  
        endpoint__c myCustomerEndpoint = new endpoint__c (name = 'Customer', Salesforce_object__c = 'Contact'); 
        endpoint__c mySaleEndpoint = new endpoint__c (name = 'Sale', Salesforce_object__c = 'Opportunity');  

        myEndpoints.add(myItemEndpoint);
        myEndpoints.add(myTagEndpoint);
        myEndpoints.add(myCustomerEndpoint);
        myEndpoints.add(mySaleEndpoint);

        insert myEndpoints;

        mapping__c myItemMapping = new mapping__c(endpoint__c = myItemEndpoint.id, External_Id__c = true, incoming_field__c = 'itemID', salesforce_field__c = 'lightspeed_item_id__c' );
        mapping__c itemName = new mapping__c(endpoint__c = myItemEndpoint.id, incoming_field__c = 'description', salesforce_field__c = 'Name' );


        mapping__c myTagMapping = new mapping__c(endpoint__c = myTagEndpoint.id, External_Id__c = true, incoming_field__c = 'tagID', salesforce_field__c = 'lightspeed_tag_id__c' );
        mapping__c mySaleMapping = new mapping__c(endpoint__c = mySaleEndpoint.id, External_Id__c = true, incoming_field__c = 'saleID', salesforce_field__c = 'lightspeed_sale_id__c' );
        mapping__c saleName = new mapping__c(endpoint__c = mySaleEndpoint.id, incoming_field__c = 'ticketNumber', salesforce_field__c = 'Name');
        mapping__c saleCloseDate = new mapping__c(endpoint__c = mySaleEndpoint.id, incoming_field__c = 'completeTime', salesforce_field__c = 'CloseDate');

        
        mapping__c myCustomerMapping = new mapping__c(endpoint__c = myCustomerEndpoint.id, External_Id__c = true, incoming_field__c = 'customerID', salesforce_field__c = 'lightspeed_contact_id__c');
        mapping__c customerLastName = new mapping__c(endpoint__c = myCustomerEndpoint.id, incoming_field__c = 'lastName', salesforce_field__c = 'lastname');

      
        myMappings.add(myItemMapping);
        myMappings.add(itemName);
        myMappings.add(myTagMapping);
        myMappings.add(mySaleMapping);
        myMappings.add(myCustomerMapping);
        myMappings.add(customerLastName);
        myMappings.add(saleName);
        myMappings.add(saleCloseDate);


        insert myMappings; 

        
      
        String sch = '0 0 23 * * ?';

        System.debug('At Ja Boi');

        Test.startTest();
        System.enqueueJob(new getCustomers(0, 165093, myAccessToken));
        Test.stopTest();

         finalIntegrationData = [SELECT Id, Name FROM Integration_Data__c];

         System.assertNotEquals(0, finalIntegrationData.size(),'Your method did not upsert any accounts');
    }
}