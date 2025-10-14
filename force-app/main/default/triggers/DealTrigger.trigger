trigger DealTrigger on Deal__c (before insert, 
                                   before update, 
                                   before delete, 
                                   After insert, 
                                   After update, 
                                   After delete, 
                                   After undelete) {
                                       
       ThTriggerDispatcher.run( new dealhandlerClass(), 'dealTrigger');
                                   }