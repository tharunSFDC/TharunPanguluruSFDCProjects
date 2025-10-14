public class eventdistrubtionhelper {
    
    public static void eventfirstmethod(list<Event_Distribution__c> newlist)
    {
        set<id> evetids = new set<id>(); 
        if(newlist !=null)
        {
            for(Event_Distribution__c ed:newlist)
            {
                if(ed.Event__c !=null)
                {
                    evetids.add(ed.Event__c);

                }
                
            }
            
            if(!evetids.isempty())
            {
                system.debug(evetids);
                integer eventcapacitycount=0;
                integer Distributioncount=0;
                integer finalcapacityvalue=0;
                map<id,event__c> eventmap = new map<id,event__c>([select id, Event_Capacity__c from event__c where id in: evetids]);
                system.debug(eventmap);
                list<Event__c> eventupdate = new list<Event__c>();
                
                for(Event_Distribution__c ed:newlist)
                {
                    if(eventmap.containskey(ed.Event__c))
                    {
                        event__c newev=eventmap.get(ed.Event__c);
                        
                        eventcapacitycount=(integer)newev.Event_Capacity__c;
                        Distributioncount=(integer)ed.Distribution__c;
                        if(eventcapacitycount>0)
                        {
                            system.debug(eventcapacitycount);
                            finalcapacityvalue=eventcapacitycount-Distributioncount;
                            system.debug(finalcapacityvalue);
                            newev.Event_Capacity__c=finalcapacityvalue;
                            ed.Status__c='Confirmed';
                            
                        }
                        else{
                            ed.Status__c='Waiting';
                        }
                        eventupdate.add(newev);
                        
                    }
                    
                }
                if(!eventupdate.isempty())
                {
                    update eventupdate;
                }
                
            }
        }
        
    } 
    
}