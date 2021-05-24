public class getItems implements Queueable, Database.AllowsCallouts{ 
    integer myOffset;
    integer myAccount;
    string myToken;
    public getItems(integer thisOffset, integer myAccount, string myToken) {
        this.myOffset = thisOffset;
        this.myAccount = myAccount;
        this.myToken = myToken;

        System.debug('This is the account number Sales ' + myAccount);
        System.debug('This is the refresh token Sales' + myToken);
    }

    

    public void execute(QueueableContext sc) { 


        List<Integration_Data__c> itemIntegrationData = lightspeedCallout.lightspeedCallout(myAccount, myToken,  'Item', '/Item.json?offset=' + myOffset  + '&load_relations=%5B%22Tags%22%5D');
        //orderby=timeStamp&timeStamp=%3E%2C2020-01-01&
        upsert itemIntegrationData external_id__c; 

        System.debug('This is the integration size Sales' + itemIntegrationData.size());

        if (itemIntegrationData.size() == 100) {
            System.debug('Enqueing next job');
                myOffset = myOffset + 100;
            System.enqueueJob(new getItems(myOffset, myAccount, myToken));
         
        

        }
        
    }
}

// lightspeedCallout.lightspeedCallout(myAccount, myToken, 'Item', '/Item.json?orderby=timeStamp&timeStamp=%3E%2C'+ myTimeStamp + '&load_relations=["Tags"]');