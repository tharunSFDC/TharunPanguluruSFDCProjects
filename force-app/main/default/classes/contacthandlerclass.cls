public class contacthandlerclass {


    public static void apexTriggerhandlermethod(list<Contact> conlist){



        set<id> accountids = new set<id>();
        map<id,Contact> conmap = new map<id,Contact>();
        list<Contact>conupdate = new list<Contact>();
        if(conlist !=null)
        {
            for(Contact con:conlist)
            {
                if(con.AccountId !=null && con.pr__c==false)
                {
                    accountids.add(con.AccountId);

                }
            }
        }
        if(accountids !=null)
        {
            list<Contact> newcontacts=[select id,AccountId,pr__c from Contact where Accountid in :accountids order by createddate DESC ];

            if(newcontacts !=null)
            {
                for(contact con:newcontacts)
                {
                    if(!conmap.containsKey(con.AccountId))
                    {
                        conmap.put(con.AccountId,con);

                    }

                }

                for(Contact con:newcontacts)
                {
                    contact newcon=conmap.get(con.AccountId);
                    if(newcon.id==con.id && con.pr__c==false)
                    {
                        con.pr__c=true;
                        conupdate.add(con);
                    }
                    else if(con.pr__c==true) {
                        con.pr__c=false;
                        conupdate.add(con);
                    }
                    
                }

            }

            if(conupdate !=null)
            {
                update conupdate;
            }
        }


    }

}