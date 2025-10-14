trigger Marketplace on Marketplace__c (Before insert, before update, before delete, After insert, After update, After delete, After undelete) {
    
     ThTriggerDispatcher.run( new MarketplaceHandlerClass(), 'marketplactrigger');

}