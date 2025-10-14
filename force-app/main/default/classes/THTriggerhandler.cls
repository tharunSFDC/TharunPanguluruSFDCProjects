public interface THTriggerhandler {
    
    void beforeinsert(list<sObject> newlist);
    
    void beforeudpate(list<sobject> newlist, map<id,sObject> newmap, list<sObject> oldlist, map<id,sObject> oldmap);
    
    void beforedelete(list<sobject> oldlist,map<id,sObject> oldmap );
    
    void afterinsert(list<sobject> newlist, map<id,sObject> newmap);
    
    void afterupdate(list<sobject> newlist, map<id,sObject> newmap, list<sObject> oldlist, map<id,sObject> oldmap);
    
    void afterdelete(list<sobject> oldlist,map<id,sObject> oldmap);
    
    void afterundelete(list<sobject> newlist, map<id,sObject> newmap);
    
}