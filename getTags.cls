public class getTags implements Queueable, Database.AllowsCallouts{ 
    integer myOffset;
    integer myAccount;
    string myToken;
    public getTags(integer thisOffset, integer myAccount, string myToken) {
        this.myOffset = thisOffset;
        this.myAccount = myAccount;
        this.myToken = myToken;

        System.debug('This is the account number Tag ' + myAccount);
        System.debug('This is the refresh token Tag' + myToken);
    }


    public void execute(QueueableContext sc) { 


        List<Integration_Data__c> tagIntegrationData = lightspeedCallout.lightspeedCallout(myAccount, myToken,  'Tag', '/Tag.json?&offset=' + myOffset);
        upsert tagIntegrationData external_id__c; 

        System.debug('This is the integration size Tag' + tagIntegrationData.size());

        if (tagIntegrationData.size() == 100) {
            System.debug('Enqueing next job');
                myOffset = myOffset + 100;
            System.enqueueJob(new getTags(myOffset, myAccount, myToken));
         
        

        }
        
    }
}
// lightspeedCallout.lightspeedCallout(myAccount, myToken, 'Tag', '/Tag.json?');