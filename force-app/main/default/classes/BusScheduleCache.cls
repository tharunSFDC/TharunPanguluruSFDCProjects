public class BusScheduleCache {
    private Cache.OrgPartition part;
    
    Public BusScheduleCache()
    {
        part= new Cache.OrgPartition('local.BusSchedule');
    }
    public void putSchedule(String busLine,Time[] schedule)
    {
        if(part !=null)
        {
            part.put('busLine',schedule);
        }
        
    }
    public Time[] getSchedule(String busLine)
    {
        Time[] schedule =(Time[])part.get(busLine);
        
        if(schedule !=null)
        {
            return schedule;
            
        }else
        {
            return new list<Time>{Time.newInstance(8,0,0,0),Time.NewInstance(17,0,0,0)};
        }
        
    }

}