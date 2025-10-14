public  class accounthelperClass {
    

    //Write a trigger to automatically distribute the total budget of an account amoing its related
    // opportunites whenever the total budget field on the account is updated
    // 
    
    public static void ApexTrigger78(list<Account> newlist, map<id,sObject> oldmap){
        if(newlist.isempty())
        {
            return;
        }else{
            id USERID = userinfo.getuserid();
            
            for(Account acc:newlist)
            {
                Account oldaccount=(Account)oldmap.get(acc.id);
                
                if(oldaccount !=null)
                {
                    if(oldaccount.LastModifiedById==USERID && oldaccount.LastModifiedDate.addhours(1) > system.now())
                    {
                        acc.AddError('You Cannot modify this Account until next one hour');
                    }
                }
            }
        }
    }
    
    public static void Aoextrigger75NTTDATA(list<Account> oldlist)
    {
        //Write a trigger to perevent deleation of an account that has contact marked as potential buyer
        set<id> accids = new set<id>();
        
        if(!oldlist.isempty())
        {
            for(Account acc:oldlist)
            {
                accids.add(acc.id);
            }
            
            if(!accids.isempty())
            {
                list<Contact> conlist=[select id,pr__c,AccountId from Contact where pr__c=true and AccountId in :accids];
                system.debug(conlist);
                
                if(!conlist.isempty())
                {
                    for(Account acc:oldlist)
                    {
                        acc.AddError('These Account Cannot deleted Because these Account has Potential Buyers');
                    }
                }
            }
        }
    }
    
    public static void apexTrigger74(list<Account> newlist, map<id,sObject> oldmap){
        
        map<id,decimal> accountid = new map<id,decimal>();
        if(!newlist.isempty())
        {
            for(Account acc:newlist)
            {
                if(acc.Total_Budget__c !=null)
                {
                    Account oldaccount=(Account)oldmap.get(acc.id);
                    
                    if(acc.Total_Budget__c != oldaccount.Total_Budget__c)
                    {
                        accountid.put(acc.id,acc.Total_Budget__c);
                    }
                    
                }
            }
            
            if(accountid.isempty())
            {
                return;
            }
            
            list<Opportunity> listofopportunity =[select id,Accountid, Amount from opportunity where AccountId in : accountid.keyset()];
            map<id,list<opportunity>> accmapandoppmap = new map<id,list<Opportunity>>();
            list<opportunity> updateoppo = new list<opportunity>();
            map<id,decimal> budgetmap = new map<id,decimal>();
            
            if(!listofopportunity.isempty())
            {
                for(opportunity oppo:listofopportunity)
                {
                    if(!accmapandoppmap.containskey(oppo.accountid))
                    {
                        accmapandoppmap.put(oppo.accountid, new list<Opportunity>{});
                    }
                    
                    accmapandoppmap.get(oppo.AccountId).add(oppo);
                    
                }
            }
            
            for(id accounts:accountid.keyset())
            {
                if(accmapandoppmap.containskey(accounts))
                {
                    integer div =accmapandoppmap.get(accounts).size();
                    system.debug(div);
                    
                    
                    if(div > 0)
                    {
                        budgetmap.put(accounts,accountid.get(accounts)/div);
                        
                    }
                }
            }
            
            for(opportunity oppo:listofopportunity)
            {
                if(budgetmap.containskey(oppo.AccountId))
                {
                    oppo.Amount=budgetmap.get(oppo.AccountId);
                    system.debug(budgetmap.get(oppo.AccountId));
                    updateoppo.add(oppo);
                        
                }
            }
            
            if(!updateoppo.isempty())
            {
                Database.SaveResult[] result = database.update(updateoppo,false);
            }
        }
    }
    
    public static void aoextrigger72(list<Account> newlist, map<id,sObject> oldmap)
    {
        if(newlist !=null)
        {
            for(Account acc: newlist)
            {
                Account oldaccount=(Account)oldmap.get(acc.id);
                
                if(oldaccount.LastModifiedDate.addhours(1) > system.now())
                {
                    
                   // acc.addError('You can only update this account after 1 hours from the last modification');
                }
                
                
            }
        }
        
    }
    
    public static void apextrigger70(list<Account> oldlist)
    {
        if(oldlist !=null)
        {
            set<id>accountidds = new set<id>();
            list<Contact> conupdate = new list<Contact>();
            for(Account ac:oldlist)
            {
                accountidds.add(ac.id);
                
            }
            
            if(!accountidds.isempty())
            {
                list<Contact> conlist=[select id,AccountId from Contact where AccountId in : accountidds];
                
                if(conlist !=null)
                {
                    for(Contact con:conlist)
                    {
                        con.AccountId=null;
                        conupdate.add(con);
                    }
                }
                
                if(!conupdate.isempty())
                {
                    Database.SaveResult[] result= Database.Update(conupdate,false);
                    system.debug(result);
                }
            }
        }
    }
    
    
    public static void NttDataApextrigger51(list<Account> acclist , map<id,sObject> oldmap){
        /*
        map<id,datetime> lastmod = new map<id,datetime>();
        set<id> accountownerids = new set<id>();
        list<string> AccountOwnerEmailAddress = new list<String>();
        list<Messaging.SingleEmailMessage> messagingemaillist = new list<Messaging.SingleEmailMessage>();
        
        if(acclist !=null)
        {
            for(Account acc:acclist)
            {
                if(oldmap !=null)
                {
                    Account oldacc =(Account)oldmap.get(acc.id);
                    
                    if(acc.LastModifiedDate != oldacc.LastModifiedDate)
                    {
                        lastmod.put(acc.id,oldacc.LastModifiedDate);
                        accountownerids.add(acc.OwnerId);
                    }
                }
            }
        }
        
        if(lastmod !=null)
        {
            list<Contact> conlist =[select id,lastmodifiedDate, Accountid,FirstName,LastName,Email,Phone from Contact
                                    where Accountid in : 
                                    lastmod.keyset() and  
                                    LastmodifiedDate >:lastmod.values() 
                                    and lastmodifiedDate <=:system.now()];
            
            if(!conlist.isempty())
            {
                string Emailbody='The Following contact have been updated: \n';
                for(Contact con:conlist)
                {
                    Emailbody +='Name  =====>:'+' '+con.FirstName+' '+con.LastName+'\n';
                    Emailbody +='Phone =====>:'+' '+con.Phone+'\n';
                    Emailbody +='Email =====>:'+' '+con.Email+'\n';
                    
                }
                
                for(User us:[select id,FirstName,LastName,Email from User where id in :accountownerids])
                {
                    AccountOwnerEmailAddress.add(us.Email);
                }
                
                for(account acc:acclist)
                {
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.SetToAddresses(AccountOwnerEmailAddress);
                    email.SetSubject('Update contacts in your Account');
                    email.SetPlainTextBody(Emailbody);
                    messagingemaillist.add(email);
                }
                
                if(messagingemaillist !=null)
                {
                    Messaging.SendEmail(messagingemaillist);
                }
                
            }
            
        }*/
    } 
    
    
    public static void accountmethodapextrigger(list<Account> acclist)
    {
        list<AccountShare> accountsharelist = new list<AccountShare>();
        if(acclist !=null)
        {
          for(Account acc:acclist)
          {
              if(acc.Secondaryuser__c !=null)
              {
                  AccountShare ah = new AccountShare();
                  ah.Accountid=acc.id;
                  ah.UserOrGroupId=acc.Secondaryuser__c;
                  ah.AccountAccessLevel='Read';
                  ah.OpportunityAccessLevel='Read';
                  accountsharelist.add(ah);
              }
          }
        }
        if(accountsharelist !=null)
        {
            insert accountsharelist;
        }
    }
    
    public static void foroldsetofaccount(map<id,sObject> newmaps, map<id,sobject> oldmaps)
    {
        list<Account> newmap=(list<Account>)newmaps.values();
        set<id> accountids = new set<id>();
        list<AccountShare> deleteAccountSharerecord = new list<AccountShare>();
        list<AccountShare> insertaccountshare = new list<AccountShare>();
        
        if(newmap !=null)
        {
            for(Account acc:newmap)
            {
                Account newacc=(Account)newmaps.get(acc.id);
                Account oldacc=(Account)oldmaps.get(acc.id);
                
                if(newacc.Secondaryuser__c != oldacc.Secondaryuser__c)
                {
                    accountids.add(oldacc.id);
                    
                }
            }
        }
        
        if(accountids !=null)
        {
            list<AccountShare> accshare=[select id,AccountId,UserOrGroupId  from AccountShare where AccountId in : accountids ];
            
            map<id,AccountShare> accsharemap = new map<id,AccountShare>();
            for(AccountShare ach :accshare)
            {
                accsharemap.put(ach.AccountId,ach);
                
            }
            
            for(Account acc:newmap)
            {
                Account newacc=(Account)newmaps.get(acc.id);
                Account oldacc=(Account)oldmaps.get(acc.id);
                
                if(oldacc.Secondaryuser__c !=null)
                {
                    Accountshare oldshare=accsharemap.get(oldacc.id);
                    if(oldshare !=null && oldshare.UserOrGroupId == oldacc.Secondaryuser__c)
                    {
                        deleteAccountSharerecord.add(oldshare);
                        
                    }
                }
                
                if(newacc.Secondaryuser__c !=null)
                {
                    AccountShare ah = new AccountShare();
                    ah.Accountid=newacc.id;
                    ah.UserOrGroupId=newacc.Secondaryuser__c;
                    ah.AccountAccessLevel='Read';
                    ah.OpportunityAccessLevel='Read';
                    insertaccountshare.add(ah);
                    
                }
                
            }
            
        }
        if(deleteAccountSharerecord !=null)
        {
            delete deleteAccountSharerecord;
        }
        if(insertaccountshare !=null)
        {
            insert insertaccountshare;
        }
    }
    


    public static void AccountMethod(list<Account> acclist, map<id,Account> accmpa){


        set<id> accids = new set<id>();


        if(acclist !=null)
        {
            system.debug(acclist);
            for(Contact con: [select id,AccountId from Contact where AccountId =:acclist[0].id and isactive__c=true])
            {
                system.debug(con);
                if(con.AccountId !=null)
                {
                    accids.add(con.AccountId);
                    system.debug(con.AccountId);
                    
                }
            }

            for(Account ac:acclist)
            {
                Account olacc=accmpa.get(ac.id);

                if(olacc.status__c==true)
                {
                    if(ac.status__c==false && accids.contains(ac.id))
                    {
                        ac.status__c.adderror('The Account have the Active Contacts');
                        
                    }
                }
            }
        }

    }
}