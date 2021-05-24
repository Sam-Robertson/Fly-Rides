public class getCustomers implements Queueable, Database.AllowsCallouts{ 
    integer myOffset;
    integer myAccount;
    string myToken;
    public getCustomers(integer thisOffset, integer myAccount, string myToken) {
        this.myOffset = thisOffset;
        this.myAccount = myAccount;
        this.myToken = myToken;

        System.debug('This is the account number ' + myAccount);
        System.debug('This is the refresh token ' + myToken);
    }


    public void execute(QueueableContext sc) { 

     

        List<Integration_Data__c> customerIntegrationData = lightspeedCallout.lightspeedCallout(myAccount, myToken, 'Customer', '/Customer.json?load_relations=%5B%22Contact%22%2C%20%22CreditAccount%22%2C%20%22Note%22%2C%20%22Tags%22%5D&offset=' + myOffset);
       // orderby=timeStamp&timeStamp=%3E%2C2020-01-01&
        upsert customerIntegrationData external_id__c; 

        System.debug('This is the integration size' + customerIntegrationData.size());

        if (customerIntegrationData.size() == 100) {
            System.debug('Enqueueing next customer job');
                myOffset = myOffset + 100;
            System.enqueueJob(new getCustomers(myOffset, myAccount, myToken));
         
        

        }
        
    }
}