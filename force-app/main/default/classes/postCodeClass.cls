public class postCodeClass {
    
    public class PostOffice{
        string Name;
        string Description;
        string BranchType;
        string DeliveryStatus;
        string Circle;
        string District;
        string Division;
        string Region;
        string Block;
        string State;
        string Country;
        string Pincode;
       
    }
    
    
    public static void PostcodeMethod()
    {
        http h = new http();
        httpRequest req = new httpRequest();
        req.setEndpoint('callout:postlcode');
        req.setMethod('GET');
        
        httpresponse res =h.send(req);
        system.debug(res.getStatusCode());
        
        list<PostalPincode__c> acclist = new list<PostalPincode__c>();
        
        if(res.getStatusCode()==200)
        {
            system.debug(res.getbody());
            
            JSONParser jp=JSON.createparser(res.getbody());
            
            jp.nexttoken();
            
            while(jp.nexttoken()!=null)
            {
                
                if(jp.getcurrenttoken()==JSONTOKEN.START_ARRAY)
                {
                    while(jp.nexttoken()!=null)
                    {
                        if(jp.getcurrenttoken()==JSONTOKEN.START_OBJECT)
                        {
                            PostOffice pos=(PostOffice)jp.readValueAs(PostOffice.class);
                            system.debug(pos);
                            
                            PostalPincode__c po = new PostalPincode__c();
                            po.Name=pos.Name;
                            po.Description__c=pos.Description;
                            po.BranchType__c=pos.BranchType;
                            po.DeliveryStatus__c=pos.DeliveryStatus;
                            po.Circle__c=pos.Circle;
                            po.District__c=pos.District;
                            po.Division__c=pos.Division;
                            po.Region__c=pos.Region;
                            po.Block__c=pos.Block;
                            po.State__c=pos.State;
                            po.Country__c=pos.Country;
                            po.Pincode__c=pos.Pincode;
                            acclist.add(po);
                     }
                    }
                }
            }
            

            
            
        }
        
        if(acclist !=null)
        {
            insert acclist;
        }
    }
    

}