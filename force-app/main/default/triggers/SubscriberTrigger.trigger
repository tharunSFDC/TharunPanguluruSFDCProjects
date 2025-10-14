trigger SubscriberTrigger on Sub__c (before insert,before update, before delete, After insert, After update, After Delete, After Undelete) {
    
    ThTriggerDispatcher.run( new SubscriberTriggerhandlerClass(), 'SubscriberTrigger');

}