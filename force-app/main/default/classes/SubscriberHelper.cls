public class SubscriberHelper {
    public static void AccountSubMethodTrigger73PWC(list<Sub__c> newlist)
    {
        if(!newlist.isempty())
        {
            set<id> accountid= new set<id>();
            for(Sub__c sub:newlist)
            {
                if(sub.Account__c !=null)
                {
                    accountid.add(sub.Account__c);
                    
                }
            }
            
            if(!accountid.isempty())
            {
                list<Sub__c> newsublist=[select id,Recent_Subscriber__c,Account__c,CreatedDate
                                         from Sub__c where Account__c in: accountid order by 
                                         Account__c, CreatedDate DESC];
                
                map<id,Sub__c> Mostrecentsub = new map<id,sub__c>();
                list<sub__c> updatesub = new list<sub__c>();
                
                if(!newsublist.isempty())
                {
                    for(sub__c sub:newsublist)
                    {
                        if(!Mostrecentsub.containskey(sub.Account__c))
                        {
                            sub.Recent_Subscriber__c=true;
                            Mostrecentsub.put(sub.Account__c,sub);
                            
                        }else
                        {
                            sub.Recent_Subscriber__c=false;
                        }
                        updatesub.add(sub);
                    }
                }
                if(!updatesub.isempty())
                {
                    Database.update(updatesub,false);
                }
            }
        }
    }

}