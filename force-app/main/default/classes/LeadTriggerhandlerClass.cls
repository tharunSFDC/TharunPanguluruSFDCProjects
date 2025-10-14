public class LeadTriggerhandlerClass implements THTriggerhandler {
    
    public static void beforeinsert(list<sObject> newlist){
    }
    public static void beforeudpate(list<sobject> newlist, map<id,sObject> newmap, list<sObject> oldlist, map<id,sObject> oldmap){
        
    }
    public static void beforedelete(list<sobject> oldlist,map<id,sObject> oldmap ){
        
    }
    public static void afterinsert(list<sobject> newlist, map<id,sObject> newmap){
        
    }
    public static void afterupdate(list<sobject> newlist, map<id,sObject> newmap, list<sObject> oldlist, map<id,sObject> oldmap){
        leadHelperClass.ApexTriggeronLeadConversionTaskCreationUpdate(newlist,oldmap);
    }
    public static void afterdelete(list<sobject> oldlist,map<id,sObject> oldmap){
        
        
    }
    public static void afterundelete(list<sobject> newlist, map<id,sObject> newmap){
        
    }
    
}