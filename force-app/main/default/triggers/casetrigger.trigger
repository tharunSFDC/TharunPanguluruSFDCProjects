trigger casetrigger on Case (Before insert, 
                             before update, 
                             before delete, 
                             After insert,
                             After update, 
                             After delete, 
                             After undelete) {
    
    ThTriggerDispatcher.run( new CaseTriggerHanlderClass(), 'CaseTrigger');
    


}