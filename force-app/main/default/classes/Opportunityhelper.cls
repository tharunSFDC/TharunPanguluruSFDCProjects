public class Opportunityhelper {
    public static integer numberofdays; 
    
    // Write a Trigger To prevent multiple opportunity creation for the same account within day or a single Transaction.
    public static void apextrigger71(list<Opportunity> newlist)
    {
        map<id,list<Opportunity>> oppmap = new map<id,list<Opportunity>>();
        if(!newlist.isempty())
        {
            for(Opportunity opp:newlist)
            {
                if(opp.AccountId !=null)
                {
                    if(!oppmap.containskey(opp.AccountId))
                    {
                        oppmap.put(opp.AccountId, new list<Opportunity>());
                    }
                    else
                    {
                        oppmap.get(opp.AccountId).add(opp);
                    }
                    
                }
            }
            list<Opportunity> opplist =[select id,AccountID,CreatedDate from Opportunity where AccountId in :
                                        oppmap.keyset() AND 
                                        CreatedDate >= :Date.today() AND 
                                        CreatedDate < :Date.today().addDays(1)];
            
            set<id> Exsitngoppaccountids = new set<id>();
            
            for(Opportunity opp: opplist)
            {
                Exsitngoppaccountids.add(opp.AccountId);
                
            }
            
            for(opportunity opp: newlist)
            {
                if(opp.AccountId !=null && Exsitngoppaccountids.contains(opp.AccountId))
                {
                    opp.AddError('Only one Opportunity can be created per Account per Day ');
                    system.debug('there if');
                    system.debug(oppmap.get(opp.AccountId).size());
                }
                else if(opp.AccountId !=null && oppmap.get(opp.AccountId).size() >= 1)
                {
                    opp.AddError('Your attempting to create mutiple opportunitys for the same Account in a single day');
                    
                    system.debug(oppmap.get(opp.AccountId).size());
                }
            }
            
        }
    }
    
    public static void aprextriggernttdata(list<Opportunity> newlist, map<id,sObject> oldmap)
    {
        set<id> accountids = new set<id>();
        map<id,Account> acclistupdate = new map<id,Account>();
        if(newlist !=null)
        {
            for(Opportunity opp:newlist)
            {
                if(opp.AccountId !=null)
                {
                    accountids.add(opp.AccountId);
                    
                    if(oldmap !=null)
                    {
                        Opportunity oldopp=(Opportunity)oldmap.get(opp.id);
                        
                        if(opp.AccountId != oldopp.AccountId)
                        {
                            accountids.add(opp.AccountId);
                            accountids.add(oldopp.AccountId);
                        }
                    }
                    
                }
            }
            
            if(accountids !=null)
            {
                map<id,Account> accmap =new map<id,Account>([select id,Mult_select__c from Account where id in:accountids]);
                
                if(accmap !=null)
                {
                    for(Opportunity opp:newlist)
                    {
                        if(accmap.containskey(opp.AccountId))
                        {
                            Account acc=accmap.get(opp.AccountId);
                            
                            acc.Mult_select__c=opp.mult_select__c;
                            acclistupdate.put(acc.id,acc);
                        }
                    }
                    
                }
                
                if(acclistupdate !=null)
                {
                    Database.SaveResult[] result=DataBase.update(acclistupdate.values(),false);
                    system.debug(result);
                }
            }
            
        }
    }
    
   /* public static void ApextriggerStageNametesting(list<opportunity> newlist, map<id,sObject> oldmap)
    {
        set<id> oppid = new set<id>();
        
        if(newlist !=null)
        {
            for(Opportunity opp:newlist)
            {
                system.debug(opp.StageName);
                if(oldmap !=null)
                {
                    Opportunity oldopp=(Opportunity)oldmap.get(opp.id);
                    system.debug(oldopp.StageName);
                    
                    if(opp.StageName != oldopp.StageName && oldopp.StageName !=null && opp.StageName !=null)
                    {
                        date stagenewdate=opp.LastStageChangeDate.date();
                        date stageolddate=oldopp.LastStageChangeDate.date();
                        integer numberofdays=stagenewdate.daysbetween(stageolddate);
                        opp.numbef_of_stagenamecount__c=numberofdays;
                        
                    }
                }
            }
            
        }
        
    } */
    
    
    public static void ApexOpportunityShareTrigger65(list<Opportunity> newlist, map<id,sObject> oldmap)
    {
        set<id> oppids = new set<id>();
        set<id> oppownerid = new set<id>();
        map<id,id> userandmanagerid = new map<id,id>();
        list<Deal_Reveiew__Share> DealShareInsert = new list<Deal_Reveiew__Share>();
        if(newlist !=null)
        {
            for(Opportunity opp:newlist)
            {
                if(oldmap !=null)
                {
                    Opportunity oldopp=(Opportunity)oldmap.get(opp.id);
                    
                    if(oldopp.StageName !='Closed Won' && opp.StageName =='Closed Won')
                    {
                        oppids.add(opp.Id);
                        oppownerid.add(opp.OwnerId);
                    }
                }
            }
        }
        if(oppids !=null)
        {
            list<Deal_Reveiew__c> deallist =[select id,Opportunity__c,Opportunity__r.ownerId from Deal_Reveiew__c where Opportunity__c in :oppids];
            
            for(User us: [select id,ManagerId from User where id in :oppownerid])
            {
                userandmanagerid.put(us.id,us.ManagerId);
            }
            system.debug(deallist);
            
            if(deallist !=null)
            {
                for(Deal_Reveiew__c del:deallist)
                {
                    string managerId = userandmanagerid.get(del.Opportunity__r.ownerId);
                    
                    Deal_Reveiew__Share delShare = new Deal_Reveiew__Share();
                    delShare.ParentId=del.id;
                    delShare.UserOrGroupId=managerId;
                    delShare.AccessLevel='Read';
                    DealShareInsert.add(delShare);
                }
                
            }
        }
        if(DealShareInsert !=null)
        {
            DataBase.SaveResult[] result= DataBase.insert(DealShareInsert,False);
        }
    }
    
    public static void Oppohelpermethod(list<Opportunity> newlist, map<id,Sobject> oldmap)
    {
        map<id,decimal> datamap = new map<id,decimal>();
        list<Account> Accountupdate = new list<Account>();
        
        set<id>Accountids = new set<id>();
        if(newlist !=null)
        {
            for(Opportunity opp:newlist)
            {
                if(opp.accountId !=null)
                {
                    if(oldmap!=null)
                    {
                        Opportunity oldopp=(Opportunity)oldmap.get(opp.id);
                        if(opp.AccountId !=oldopp.AccountId)
                        {
                            Accountids.add(oldopp.AccountId);
                            Accountids.add(opp.AccountId);
                        }
                        else{
                            Accountids.add(opp.AccountId);
                        }
                        
                    }else{
                        Accountids.add(opp.AccountId);
                    }
                }
            }
        }
        if(Accountids !=null)
        {
            list<Opportunity> opplist = [select id,Name,AccountId,Amount, StageName from Opportunity where AccountId in :Accountids and StageName='Closed Won'];
            
            if(opplist !=null)
            {
                for(Opportunity opp:opplist)
                {
                    decimal maxamount =datamap.get(opp.AccountId);
                    
                    if(maxamount ==null || opp.Amount > maxamount){
                        datamap.put(opp.AccountId,opp.Amount);
                    }
                }
            }
            
            for(id ids:Accountids)
            {
                decimal maxamounthere=datamap.get(ids);
                
                maxamounthere= (maxamounthere !=null)?maxamounthere:0;
                Account acc= new Account();
                acc.id=ids;
                acc.Description=string.valueof(maxamounthere);
                Accountupdate.add(acc);
            }
            
        }
        if(Accountupdate !=null)
        {
            Database.update(Accountupdate,false);
        }
        
    }
    
}