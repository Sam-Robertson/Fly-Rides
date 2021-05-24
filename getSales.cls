public class getSales implements Queueable, Database.AllowsCallouts{ 
    integer myOffset;
    integer myAccount;
    string myToken;
    public getSales(integer thisOffset, integer myAccount, string myToken) {
        this.myOffset = thisOffset;
        this.myAccount = myAccount;
        this.myToken = myToken;

        System.debug('This is the account number Sales ' + myAccount);
        System.debug('This is the refresh token Sales' + myToken);
    }

    public void execute(QueueableContext qc) { 
        Set<String> externalIds = new Set<String>();
        List<Integration_Data__c> dataToUpdate = new List<Integration_Data__c>();
        
        List<Integration_Data__c> saleIntegrationData = lightspeedCallout.lightspeedCallout(myAccount, myToken,  'Sale', '/Sale.json?offset=' + myOffset  + '&load_relations=%5B%22SaleLines%22%2C%20%22Customer%22%5D');
        // orderby=timeStamp&timeStamp=%3E%2C2020-01-01&
        
        upsert saleIntegrationData external_id__c; 

        System.debug('This is the integration size Sales' + saleIntegrationData.size());

        if (saleIntegrationData.size() == 100) {
            System.debug('Enqueing next job');
            myOffset = myOffset + 100;
            System.enqueueJob(new getSales(myOffset, myAccount, myToken));

        }
        
    }
   
}