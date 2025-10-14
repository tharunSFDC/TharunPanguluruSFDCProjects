public class OpportunityFactoryclass implements DataFactory {
    
    public list<sobject> getrecord()
    {
        list<Opportunity> opplist = new list<Opportunity>();
        
        
        for(integer i=0; i<=10;i++)
        {
            Opportunity opp=new Opportunity();
            opp.name='testingopp'+i;
            opp.stageName='Qualification';
            opp.CloseDate=system.today();
            opplist.add(opp);
            
            
        }
        return opplist;
        
    }
    public list<sobject> createRecord()
    {
        list<Opportunity> insertopplist=getRecord();
        
        if(insertopplist !=null)
        {
            insert insertopplist;
        }
        return insertopplist;
        
    }
    
    
}