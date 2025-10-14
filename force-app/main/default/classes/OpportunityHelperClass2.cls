public class OpportunityHelperClass2 {
    // On Account there are two fields, open opportunity and closed opportunity
    // You have to write a trigger on opportunity that every time a new opportunity is created or updated
    // All have to populate the number of opporunites open and number of closed opportunites on account
    // let's say if any opporunity is closed, then this will remove one from open opporunity and will add one in the closed opporunity field on account.
    // Fields: open oppo, closed oppo.
    
    public static void Oppomethodtogetcountof(list<Opportunity> newlist, map<id,sObject> oldmap)
    {
        set<id> Accountids = new set<id>();
        if(newlist.isempty())
        {
            return;
        }else{
            for(opportunity oppo:newlist)
            {
                if(oppo?.AccountId !=null)
                {
                    Opportunity oldOppo=(Opportunity)oldmap.get(oppo.id);
                    
                    accountids.add(oppo.AccountId);
                    if(oldoppo !=null)
                    {
                        accountids.add(oldoppo.AccountId);
                        if(oppo.StageName != oldoppo.StageName)
                        {
                            accountids.add(oppo.AccountId);
                            accountids.add(oldoppo.AccountId);
                            
                        }
                        
                    }
                    
                    
                }
                
            }
        }
        if(accountids.isempty())
        {
            return;
        }else{
            
            list<AggregateResult> opencount =[select count(StageName) opencounts, AccountId accids from opportunity where 
                                              stageName not in('Closed Won', 'Closed Lost') 
                                              and Accountid in:accountids group by AccountId limit 2000];
            list<AggregateResult> Closedcount =[select count(StageName) closecounts, AccountId accids from opportunity where 
                                                stageName in('Closed Won', 'Closed Lost')
                                                and Accountid in: accountids group by AccountId limit 2000];
            map<id,Account> accupdatemap = new map<id,Account>();
            
            Account updateaccount = new Account();
            
            for(AggregateResult agr:opencount)
            {
                id acids=(id)agr.get('accids');
                integer count=(integer)agr.get('opencounts');
                
                updateaccount.id=acids;
                if(count !=0)
                {                        
                    updateaccount.Open_Opportunitys__c=count;
                    
                }
                if(Closedcount.size() ==0)
                {
                    updateaccount.Closed_Opportunitys__c=0;
                }
                accupdatemap.put(updateaccount.id,updateaccount);
                
            }
            
            for(AggregateResult agr:Closedcount)
            {
                id acids=(id)agr.get('accids');
                integer count=(integer)agr.get('closecounts');
                updateaccount.id=acids;
                
                if(count !=0)
                {
                    updateaccount.Closed_Opportunitys__c=count;
                }
                if(opencount.size() ==0)
                {
                    updateaccount.Open_Opportunitys__c=0;
                }
                accupdatemap.put(updateaccount.id,updateaccount);
                
            }
            
            if(accupdatemap.isempty())
            {
                return;
            }else{
                Database.SaveResult[] results= Database.Update(accupdatemap.values(),false);
                
            }
            
            
        }
        
    }
    //Imagine a company uses Salesforce to track projects and their associated deliverables. Each deliverable is a child record (B__c), and projects are parent records (A__c).
    // Each project includes fields for tracking the number of deliverables (Record_Count__c) and the cumulative value of those deliverables (Total__c).
    
    public static void oppoRecordAndtotatamount(list<opportunity> newlist, map<id,Sobject> oldmap){
        
        set<id> accountids = new set<id>();
        if(newlist.isempty())
        {
            return;
        }else{
            for(Opportunity oppo: newlist)
            {
                if(oppo.AccountId !=null)
                {
                    Opportunity oldoppo=(Opportunity)oldmap.get(oppo.id);
                    if(oldoppo.AccountId !=null && oldoppo.AccountId != oppo.AccountId)
                    {
                        accountids.add(oldoppo.AccountId);
                        accountids.add(oppo.AccountId);
                        
                    }else if(oldoppo.AccountId !=null)
                    {
                        accountids.add(oldoppo.AccountId);
                    }else{
                        accountids.add(oppo.AccountId);
                    }
                }
            }
        }
        if(accountids.isempty())
        {
            return;
        }else{
            map<id,integer> childRecordCount = new map<id,integer>();
            map<id,decimal> childValuesSum = new map<id,decimal>();
            list<Account> accountstoupdate = new list<Account>();
            
            for(Opportunity oppo: [select id,AccountId,Amount from opportunity where Accountid in : accountids])
            {
                id accountid = oppo.AccountId;
                childRecordCount.put(accountid,(childRecordCount.containskey(accountid) ? childRecordCount.get(accountid) : 0)+1);
                
                decimal OpportunityAmount=childValuesSum.containskey(accountid)? childValuesSum.get(Accountid) : 0;
                decimal OpportunitycurrentAmount=oppo.Amount != null ? oppo.Amount : 0;
                childValuesSum.put(accountid, OpportunityAmount+OpportunitycurrentAmount);
           }
            
            for(Account acc:[select id,Record_Count__c,Opportunity_Total_Amount__c from Account where id in : accountids])
            {
                acc.Record_Count__c=childRecordCount.containskey(acc.id)? childRecordCount.get(acc.id) : 0;
                acc.Opportunity_Total_Amount__c=childValuesSum.containskey(acc.id)? childValuesSum.get(acc.id) : 0;
                accountstoupdate.add(acc);
            } 
            
            if(!accountstoupdate.isempty())
            {
                Database.SaveResult[] result = Database.update(accountstoupdate,false);
                system.debug(result);
                
            }
            
        }
        
    }
}