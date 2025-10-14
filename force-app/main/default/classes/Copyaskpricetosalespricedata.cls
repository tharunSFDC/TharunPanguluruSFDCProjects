public class Copyaskpricetosalespricedata {

    public static void imagemethod(list<Property__c> polist, map<id,Property__c> pomap)
    {

        map<id,Property__c> mappo = new map<id,Property__c>();
        if(polist !=null)
        {
            for(Property__c po:polist)
            {
                if(po.Thumbnail__c !=pomap.get(po.Id).Thumbnail__c)
                {
                    po.Picture__c=pomap.get(po.Id).Thumbnail__c;
                    mappo.put(po.id,po);

                }else {
                    po.Picture__c=po.Thumbnail__c;
                    mappo.put(po.id,po);
                    
                }
            }
        }

        if(mappo !=null)
        {
            update mappo.values();
        }

    }


    public static void Askpricetosalesprice()
    {
        list<Property__c> Propertylist =[select id,Price__c,Sales_Price__c from Property__c];
        map<id,Property__c> Propertymap = new map<id,Property__c>();
        if(Propertylist !=null)
        {
            for(Property__c prop:Propertylist)
            {
                if(prop.Price__c !=null)
                {
                    prop.Sales_Price__c=prop.Price__c;
                    Propertymap.put(prop.id,prop);

                }
            }
        }
        if(Propertymap !=null)
        {
            update Propertymap.values();
        }
    }
    public static void mapthedatatothemaing()
    {
        list<Property__c> propertylist=[select id,Beds__c,Number_of_Rooms__c,City__c,Country__c from Property__c];
        map<id,Property__c> Propertymap = new map<id,Property__c>();

        if( propertylist !=null)
        {
            for(Property__c po:propertylist)
            {
                if(po.Beds__c !=null && po.City__c !=null)
                {
                    po.Number_of_Rooms__c=po.Beds__c;
                    po.Country__c=po.City__c;
                    Propertymap.put(po.id,po);

                }
            }
        }
        if(Propertymap !=null)
        {
            update Propertymap.values();
        }
    }

}