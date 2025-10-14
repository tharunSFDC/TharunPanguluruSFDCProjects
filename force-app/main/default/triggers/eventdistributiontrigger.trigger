trigger eventdistributiontrigger on Event_Distribution__c  (before insert, 
                                           before update, 
                                           before delete, 
                                           After insert, 
                                           After update, 
                                           After delete, 
                                           After undelete) {
                                               
                                               ThTriggerDispatcher.run( new EventTriggerhanlder(), 'EventTrigger');
                                               
                                           }