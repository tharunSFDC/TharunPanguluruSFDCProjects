public class AccountTriggerHandlerClass implements THTriggerhandler {
    
    public static void beforeinsert(list<sobject> newlist){
        
    }
    public static void beforeudpate(list<sobject> newlist, map<id,sObject> newmap, list<sObject> oldlist, map<id,sObject> oldmap){
        accounthelperClass.aoextrigger72(newlist,oldmap);
       // accounthelperClass.ApexTrigger78(newlist,oldmap);
        
    }
    public static void beforedelete(list<sobject> oldlist,map<id,sObject> oldmap ){
        accounthelperClass.Aoextrigger75NTTDATA(oldlist);
        accounthelperClass.apextrigger70(oldlist);
        
    }
    public static void afterinsert(list<sobject> newlist, map<id,sObject> newmap){
        
        accounthelperClass.accountmethodapextrigger(newlist);
    }
    public static void afterupdate(list<sobject> newlist, map<id,sObject> newmap, list<sObject> oldlist, map<id,sObject> oldmap){
        accounthelperClass.foroldsetofaccount(newmap,oldmap);
        accounthelperClass.NttDataApextrigger51(newlist,oldmap);
        accounthelperClass.apexTrigger74(newlist,oldmap);
    }
    public static void afterdelete(list<sobject> oldlist,map<id,sObject> oldmap){
       
        
    }
    public static void afterundelete(list<sobject> newlist, map<id,sObject> newmap){
        
    }
    
    
}