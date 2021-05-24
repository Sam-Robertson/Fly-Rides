@IsTest
public with sharing class refreshTokenTest {
    @IsTest
    static void methodName(){

        test.setMock(httpcalloutmock.class, new MockResponseGenerator());
       
        Test.startTest();
        refreshToken.runRefresh();
        Test.stopTest();

    }
}