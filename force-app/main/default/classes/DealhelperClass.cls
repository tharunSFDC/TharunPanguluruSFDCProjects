public with sharing class DealhelperClass {
    public static set<id> oppoids = new set<id>();

    //Write a trigger on the Deal Object to validate that the 
    //Deal Amount matches the Amount fields of the Associated opportunity during record insert or update.
    public static void DealAmountValidateMethod(list<Deal__c> newlist){

        if(!newlist.isempty())
        {
            for(Deal__c de:newlist)
            {
                if(de.Opportunity__c !=null)
                {
                    oppoids.add(de.Opportunity__c);
                }
            }
        }
        if(!oppoids.isEmpty())
        {
            map<id,Opportunity> oppmap = new map<id,Opportunity>([select id,Amount from Opportunity where id in: oppoids]);

            if(!oppmap.isEmpty())
            {
                for(Deal__c de:newlist)
                {
                    if(de.Opportunity__c !=null && oppmap.containsKey(de.Opportunity__c))
                    {
                        if(de.deal_Amount__c != oppmap.get(de.Opportunity__c).Amount)
                        {
                            de.deal_Amount__c.AddError('The Deal Amount shoud same as Opportunity Amount:'+' '+oppmap.get(de.Opportunity__c).Amount);
                        }
                    }
                }
                
            }
        }
        
    }
}