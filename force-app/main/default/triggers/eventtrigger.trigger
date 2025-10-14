trigger eventtrigger on Event (After Insert, After update, After undelete) {
    
    Switch on Trigger.OperationType{
        
        when AFTER_INSERT{
            Eventhandler.eventMethod1(Trigger.New,Trigger.NewMap);
        }
        when AFTER_UPDATE{
            Eventhandler.eventMethod1(Trigger.New,Trigger.oldmap);
        }
        When AFTER_UNDELETE{
            Eventhandler.eventMethod1(Trigger.New,Trigger.NewMap);
        }
    }

}