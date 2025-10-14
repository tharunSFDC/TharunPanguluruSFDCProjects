trigger ContactTrigger on Contact (before insert, 
                                   before update, 
                                   before delete, 
                                   After insert, 
                                   After update, 
                                   After delete, 
                                   After undelete) {
                                       
       ThTriggerDispatcher.run( new ContactTriggerhandlerClass(), 'ContactTrigger');
                                       
                                       
    }