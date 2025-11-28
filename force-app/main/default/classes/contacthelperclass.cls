public  class contacthelperclass {
    
    // Write a trigger to calcualte the number of male and female  contacts related to an Account.
    // Updated the accounts Desc: with number of male and female contacts.
    public static void contactrigger83(list<Contact> newlist, map<id,sobject>oldmap)
    {
        set<id> accids = new set<id>();
        list<Account> accupdate = new list<Account>();
        map<id,Contact> oldcontacmap = new map<id,Contact>();
        if(newlist.isempty())
        {
            return;
        }else{
            for(Contact con:newlist)
            {
                if(con?.AccountId !=null)
                {
                    
                    if(con.Gender__c=='Male')
                    {
                        accids.add(con?.AccountId);
                        
                    }else if(con.Gender__c=='Female')
                    {
                        accids.add(con?.AccountId);
                    }
                    
                    
                    Contact oldContact =(Contact)oldmap.get(con.id);
                    if(con.AccountId !=oldcontact.AccountId && oldcontact?.AccountId!=null)
                    {
                        accids.add(oldcontact?.AccountId);
                        
                        if(oldContact.Gender__c=='Male')
                        {
                            accids.add(oldcontact?.AccountId);
                        }else if(oldcontact.Gender__c=='Female')
                        {
                            accids.add(oldcontact?.AccountId);
                        }
                    }
                }
                
            }
            
        }
        
        if(accids.isempty())
        {
            return;
        }else{
            map<id,list<Contact>> malecontactmap = new map<id,list<Contact>>();
            map<id,list<Contact>> femalecontactmap= new map<id,list<Contact>>();
            for(Contact con:[select id,AccountId,Gender__c from Contact where AccountId in:accids and (Gender__c='Male' or Gender__c='Female')])
            {
                if(con?.AccountId !=null)
                {
                    if(con.Gender__c=='Male')
                    {
                        if(!malecontactmap.containskey(con.AccountId))
                        {
                            malecontactmap.put(con.AccountId, new list<contact>{con});
                            
                        }else{
                            malecontactmap.get(con.AccountId).add(con);
                        }
                        
                    }
                    if(con.Gender__c=='Female')
                    {
                        if(!femalecontactmap.containskey(con.AccountId))
                        {
                            femalecontactmap.put(con.AccountId, new list<contact>{con});
                            
                        }else{
                            femalecontactmap.get(con.AccountId).add(con);
                        }
                    }
                    
                }
                
            }
            for(Account acc:[select id,Description from Account where id in:accids])
            {
                string malecontacts;
                string femalecontacts;
                string descupdate;
                if(malecontactmap.containskey(acc.id))
                {
                    malecontacts='The number of male Contacts ===> :'+' '+malecontactmap.get(acc.id).size();
                }
                if(femalecontactmap.containskey(acc.id))
                {
                    femalecontacts='The number of female Contacts ===> :'+' '+femalecontactmap.get(acc.id).size();
                }
                descupdate= malecontacts+'\n'+femalecontacts;
                acc.Description=descupdate;
                accupdate.add(acc);
                
            }
            
            if(accupdate !=null)
            {
                Database.SaveResult[] results = Database.update(accupdate,false);
                system.debug(results);
            }
            
            
        }
        
    }
    
    // When a Contact is inserted,Updated,Deleted then all related contact names and created date will be populated in the parent Account Description.
    // Also on the update or delete of the parent on related contact, the existing contact record will be update or removed from the description.
    public static void contactrigger55(list<Contact> newlist, map<id,sObject> oldmap)
    {
        set<id> accountids = new set<id>();
        list<Account> UpdateAccount = new list<Account>();
        if(newlist !=null)
        {
            for(Contact con:newlist)
            {
                if(con.AccountId !=null)
                {
                    accountids.add(con.AccountId);
                    contact oldcontact=(contact)oldmap.get(con.id);
                    
                    if(oldcontact.AccountId !=null)
                    {
                        if(oldcontact.AccountId != con.AccountId)
                        {
                            accountids.add(oldcontact.AccountId);
                            accountids.add(con.AccountId);
                        }
                    }
                }
            }
            
            if(accountids !=null)
            {
                string contactnameandcreateddate;
                list<Contact> conlist = [select id,Name,Createddate,AccountId from contact where AccountId In :accountids];
                map<id,list<String>> accmap = new map<id,list<String>>();
                
                if(conlist !=null)
                {
                    for(Contact con:conlist)
                    {
                        contactnameandcreateddate='Contact Name ===>:'+' '+con.Name+' '+'Contact Created Date==>:'+con.CreatedDate+'\n';
                        if(!accmap.containsKey(con.AccountId))
                        {
                            accmap.put(con.AccountId,new list<string>{contactnameandcreateddate});
                        }else
                        {
                            accmap.get(con.AccountId).add(contactnameandcreateddate);
                        }
                        
                    }
                }
                
                for(Account acc:[select id,Description from Account where id in : accountids])
                {
                    Account newacc = new Account();
                    if(accmap.containskey(acc.id)){
                        
                        newacc.id=acc.id;
                        newacc.Description=String.join(accmap.get(acc.id),'');
                    }else
                    {
                        newacc.Description='No Related Contacts for these Account';
                    }
                    UpdateAccount.add(newacc);
                    
                }
                
                if(UpdateAccount !=null)
                {
                    Database.SaveResult[] result=Database.update(UpdateAccount,false);
                    system.debug(result);
                }
            }
        }
    }
    
    public static void ContactmethodTrigger(list<Contact> newlist, map<id,sobject> oldmap)
    {
        set<id> accountidset= new set<id>();
        list<Case> newcase = new list<Case>();
        if(!newlist.isEmpty())
        {
            for(Contact con:newlist)
            {
                system.debug(con);
                if(con.AccountId !=null)
                {
                    system.debug(con.accountId);
                    
                    Contact oldcontact=(contact)oldmap.get(con.id);
                    system.debug(oldcontact);
                    
                    if(oldcontact.AccountId != con.AccountId)
                    {
                        accountidset.add(oldcontact.AccountId);
                        accountidset.add(con.AccountId);
                        
                    }else {
                        
                        accountidset.add(con.AccountId);
                        system.debug(con.AccountId);
                        
                    }
                }
            }
            
            if(!accountidset.isEmpty())
            {
                map<id,Account> accmap = new map<id,Account>([select id,ownerid,Type from Account where id in:accountidset and Type='Premium']);
                system.debug(accmap);
                
                if(!accmap.isEmpty())
                {
                    for(Contact con:newlist){
                        if(accmap.containsKey(con.AccountId))
                        {
                            Account acc=accmap.get(con.AccountId);
                            
                            Case ca = new Case();
                            ca.OwnerId=acc.OwnerId;
                            ca.status='New';
                            ca.Description='Contact FullName'+''+con.FirstName+' '+con.LastName;
                            ca.AccountId=acc.id;
                            newcase.add(ca);
                        }
                    }
                }
                if(!newcase.isEmpty())
                {
                    database.SaveResult[] result=Database.insert(newcase,false);
                    system.debug(result);
                }
                
            }
        }
    }
    
}