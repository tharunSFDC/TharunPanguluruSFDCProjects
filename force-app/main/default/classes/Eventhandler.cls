public class Eventhandler implements Eventinterfaces {
    
    public static  void eventMethod1(list<Event> eventlist, map<id,Event> eventmap)
    {
        map<id,event> leadmap = new map<id,event>();
        list<Lead> Leadupdate = new list<lead>();
        if(eventlist !=null)
        {
            for(Event ev:eventlist)
            {
                if(ev.WhoId !=null)
                {
                    event oldevent = eventmap.get(ev.id);
                    if(ev.OwnerId != oldevent.ownerid)
                    {
                        leadmap.put(ev.WhoId,ev);
                    }
                }
            }
        }
        if(leadmap !=null)
        {
            for(lead ld:[select id,ownerid from lead where id in:leadmap.keyset() limit 10])
            {
                ld.OwnerId=leadmap.get(ld.id).ownerid;
                Leadupdate.add(ld);
                
            }
        }
        if(Leadupdate !=null)
        {
            update Leadupdate;
        }
        
    }
    
}