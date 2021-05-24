public with sharing class schedule {
    public schedule() {
        public static String CRON_EXP = '0 25 * * * ?';
   
        global void schedule(SchedulableContext ctx) {
           CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                     FROM CronTrigger WHERE Id = :ctx.getTriggerId()];
      
          
      
           Account a = [SELECT Id, Name FROM Account WHERE Name = 
                       'testScheduledApexFromTestMethod'];
           a.name = 'testScheduledApexFromTestMethodUpdated';
           update a;
        }   
    }
}



// System.assertEquals(CRON_EXP, ct.CronExpression);
// System.assertEquals(0, ct.TimesTriggered);
// System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));



// Store last time ran in salesforce. .... IDK where
// Only one account. 
// Cycle through Customer object and check if changed.
// Cycle through Sales and do the same. 

// How do you check for duplicates? 
// 