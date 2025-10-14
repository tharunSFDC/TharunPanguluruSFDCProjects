public class leadfactoryclass implements Datafactory {
    
    public list<sObject> getrecord(){
        
        list<Lead> leadlist = new list<Lead>();
        
        for(integer i=0; i<=10; i++)
        {
            Lead ld = new lead();
            ld.FirstName='testing'+i;
            ld.LastName='sampletesting'+i;
            ld.LeadSource='Web';
            ld.Company='Salesforce and NTT DATA';
            leadlist.add(ld);
        }
        return leadlist;
        
    }
    public list<sObject> createRecord(){
        
        list<Lead> insertLeads = getrecord();
        
        if(insertLeads !=null)
        {
            insert insertleads;
        }
        
        return insertleads;
        
    }

}