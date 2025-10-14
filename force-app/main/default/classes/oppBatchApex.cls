public class oppBatchApex implements  Database.Batchable<sObject> {
    
    public database.querylocator start(Database.BatchableContext bc){
        return Database.getQuerylocator([select id,StageName from opportunity where stageName !='Closed Won' and StageName !='Closed lost']);
    }
    public void execute(Database.BatchableContext bc, list<Opportunity> opplist){
        list<Opportunity> oppupdate = new list<Opportunity>();
        system.debug(opplist);
        if(opplist !=null)
        {
            for(Opportunity opp:opplist)
            {
                opp.stageName='Prospecting';
                oppupdate.add(opp);
            }
        }
        if(oppupdate !=null)
        {
            update oppupdate;
        }
    }
    public void finish(Database.BatchableContext bc){}

}