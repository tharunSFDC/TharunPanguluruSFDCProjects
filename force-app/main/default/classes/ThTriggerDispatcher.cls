public class ThTriggerDispatcher {
    
    public static void run(THTriggerhandler handler,string triggername)
    {
        TriggerConfiguration__c triggersettings	= TriggerConfiguration__c.getvalues(triggername);
        
        boolean isactive = triggersettings !=null ? triggersettings.isActive__c:true ;
        
        if(isactive == false)
        {
            return;
        }
        
        Switch on Trigger.OperationType{
            When BEFORE_INSERT{
                handler.beforeinsert(Trigger.New);
                
            }
            when BEFORE_UPDATE{
                handler.beforeudpate(Trigger.New, Trigger.Newmap, Trigger.old, Trigger.oldmap);
                
            }
            When BEFORE_DELETE{
                handler.beforedelete(Trigger.old, Trigger.oldMap);
                
            }
            When AFTER_INSERT{
                handler.afterinsert(Trigger.New, Trigger.NewMap);
            }
            When AFTER_UPDATE{
                handler.afterupdate(Trigger.New, Trigger.newmap, Trigger.old, Trigger.oldmap);
                
            }
            When AFTER_DELETE{
                handler.afterdelete(Trigger.old, Trigger.oldmap);
                
            }
            When AFTER_UNDELETE{
                handler.afterundelete(Trigger.New, Trigger.NewMap);
                
            }
        } 
        
    } 

}