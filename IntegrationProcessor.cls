public class IntegrationProcessor implements Schedulable {

    public static void run() {
        Integer myAccount = 165093;
        String myToken;
        String myTimeStamp;

        timeStamp__c lastPull =  timeStamp__c.getorgdefaults(); 

        if(!Test.isRunningTest()){     
            myToken = refreshToken.runRefresh();
        }
        else {
            myToken = '1111111';
            lastPull.stampDate__c = DateTime.newInstance(2020, 1, 1);
        }
       
        
         
        myTimeStamp = EncodingUtil.urlEncode(lastPull.stampDate__c.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\''), 'UTF-8');

        System.debug('Third Debug');
        System.debug(myAccount);
        System.debug(myToken);
        System.debug(myTimeStamp);

  

       // System.enqueueJob(new getCustomers(0, myAccount, myToken)); 
        //System.enqueueJob(new getSales(0, myAccount, myToken)); 
        //System.enqueueJob(new getItems(0, myAccount, myToken)); 
        System.enqueueJob(new getTags(0, myAccount, myToken)); 

        lastPull.stampDate__c = dateTime.now();
        System.debug(lastPull);

        ING_ProcessorBatch.runBatch();

        upsert lastPull; 


    }

    public static void execute(SchedulableContext sc) { 
        run();
    }
    

}