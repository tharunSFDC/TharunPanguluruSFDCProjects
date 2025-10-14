public class MarketplaceHelperClass {
    
    public static set<id> accids= new set<id>();
    
    // Write a trigger that whenever a marketplace record gets inserted and updated and deleted,
    // then update the related account activemarticep field with the names of all marketplaces linked via asset.
    public static void afterInsertAndUpdate(list<Marketplace__c> newlist, map<id,sObject> oldmap)
    {
        if(newlist.isempty())
        {
            return;
        }
        if(!newlist.isempty())
        {
            system.debug('entered');
            for(Marketplace__c ma:newlist)
            {
                if(ma.Asset__c !=null)
                {
                    accids.add(ma.Asset__c);
                }
                Marketplace__c mc=(Marketplace__c)oldmap.get(ma.Id);
                
                if(ma.Asset__c != mc.Asset__c)
                {
                    accids.add(ma.Asset__c);
                }
                
            }
        }
        system.debug(accids);
        updatetheRelatedAccount(accids);
        
    }
    
    public static void AfterDelete(list<Marketplace__c> oldlist)
    {
        if(oldlist.isempty())
        {
            return;
        }else if(!oldlist.isempty())
        {
            for(Marketplace__c mc:oldlist)
            {
                if(mc.Asset__c !=null)
                {
                    accids.add(mc.Asset__c);
                }
            }
        }
        updatetheRelatedAccount(accids);
        
    }
    

    public static void updatetheRelatedAccount(set<id> accids){
        list<Account> AccountUpdate = new list<Account>();
        
        map<id,id> assidsandaccountids= new map<id,id>();
        
        if(accids.isempty())
        {
            return;
        }else if(!accids.isempty())
        {
            for(Asset ass:[select id, AccountId from Asset where id in :accids])
            {
                if(ass.AccountId !=null)
                {
                    assidsandaccountids.put(ass.id,ass.AccountId);
                    system.debug(ass.AccountId);
                }
                
            }
        }
        map<id,list<string>> accounttomarket = new map<id,list<string>>();
        
        if(!assidsandaccountids.isempty())
        {
            for(Marketplace__c mc:[select id,Asset__c,Name from Marketplace__c where Asset__c in :assidsandaccountids.keyset()])
            {
                id accountid=assidsandaccountids.get(mc.Asset__c);
                
                if(accountid !=null)
                {
                    if(!accounttomarket.containskey(accountid))
                    {
                        accounttomarket.put(accountid,new list<string>());
                    }
                    accounttomarket.get(accountid).add(mc.Name);
                }
            }
        }
        
        for(id accid:assidsandaccountids.values())
        {
            list<string> names=accounttomarket.get(accid);
            
            string joinednames= (names !=null) ? string.join(names,', '):'';
            
            Account acc = new Account();
            acc.id=accid;
            acc.Active_Marketplace__c=joinednames;
            system.debug(acc.Active_Marketplace__c);
            AccountUpdate.add(acc);
        }
        
        if(AccountUpdate.isempty())
        {
            return;
        }else if(!AccountUpdate.isempty())
        {
            Database.SaveResult[] Results = Database.Update(AccountUpdate,false);
            system.debug(results);
           for(database.Saveresult re:results)
           {
               for(Database.Error er: re.geterrors())
               {
             System.debug('The following error has occurred.');                    
            System.debug(er.getStatusCode() + ': ' + er.getMessage());
            System.debug('Fields that affected this error: ' + er.getFields());
                   
               }
           }
            
            for(Account acc:AccountUpdate)
            {
                system.debug(acc.Name);
                system.debug(acc.Description);
            }
        }
    }

}