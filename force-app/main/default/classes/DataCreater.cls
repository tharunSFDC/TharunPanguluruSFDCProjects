public class DataCreater {
    
    private static final map<sObjecttype,system.type> OBJECT_TO_FACTORY = new map<sObjecttype,system.type>{
        Account.sObjecttype => AccountFactoryclass.class,
            Contact.sObjecttype => Contactfactory.class,
            Lead.sObjecttype => leadfactoryclass.class,
            Opportunity.sObjecttype => OpportunityFactoryclass.class
            };
                
                
                public static object creatRecord(sobjectType objecttypeTocreate)
            {
                DataFactory factory =(DataFactory)OBJECT_TO_FACTORY.get(objecttypeTocreate).newInstance();
                
                return factory.createRecord();
                
            }
    
    
}