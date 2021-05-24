@IsTest
public with sharing class lightspeedCalloutTest {
    @IsTest
    public static void methodName(){
     
        test.setMock(httpcalloutmock.class, new MockResponseGenerator());
        
        String myAccessToken = refreshToken.runRefresh();

        endpoint__c myEndpoint = new endpoint__c(name = 'Item', Salesforce_object__c = 'Product');  
        insert myEndpoint;
       
        insert new mapping__c(endpoint__c = myEndpoint.id, External_Id__c = true, incoming_field__c = 'itemID', salesforce_field__c = 'lightspeed_item_id__c' );
       
        Test.startTest();
        lightspeedCallout.lightspeedCallout(165093, myAccessToken, 'Item', '&load_relations=["Tags"]');
        Test.stopTest();

    }
}