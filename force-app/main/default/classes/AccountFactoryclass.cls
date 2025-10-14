public class AccountFactoryclass implements Datafactory {
    
    public list<sobject> getrecord()
    {
        list<Account> acclist = new list<Account>();
        
        
        for(integer i=0; i<=10;i++)
        {
            Account acc=new Account();
            acc.name='testinfinteracedatafactory'+i;
            acc.type='Other';
            acc.AnnualRevenue=100000+i;
            acclist.add(acc);
            
            
        }
        return acclist;
        
    }
    public list<sobject> createRecord()
    {
        list<account> insertaccountlist=getRecord();
        
        if(insertaccountlist !=null)
        {
            insert insertaccountlist;
        }
        return insertaccountlist;
        
    }

}