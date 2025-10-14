public class ContactTriggerhandlerClass implements THTriggerhandler {
    
    public static void beforeinsert(list<sObject> newlist){
        //ContactHelperClass.phoneNumberisRequired(newlist);
    }
    public static void beforeudpate(list<sobject> newlist, map<id,sObject> newmap, list<sObject> oldlist, map<id,sObject> oldmap){
        //ContactHelperClass.contactAccountIdnotNull(newlist,oldmap);
    }
    public static void beforedelete(list<sobject> oldlist,map<id,sObject> oldmap ){
        //ContactHelperClass.contactAccountprevernt(oldlist);
    }
    public static void afterinsert(list<sobject> newlist, map<id,sObject> newmap){
        //ContactHelperClass.numberofContacts(newlist,newmap);
        //ContactHelperClass.contacttriggerforaccountdecupdate(newlist,newmap);
        ContactHelperClass.contactrigger55(newlist,newmap);
    }
    public static void afterupdate(list<sobject> newlist, map<id,sObject> newmap, list<sObject> oldlist, map<id,sObject> oldmap){
       // ContactHelperClass.numberofContacts(newlist,oldmap);
       // ContactHelperClass.contacttriggerforaccountdecupdate(newlist,oldmap);
        ContactHelperClass.contactrigger55(newlist,oldmap);
    }
    public static void afterdelete(list<sobject> oldlist,map<id,sObject> oldmap){
        //ContactHelperClass.numberofContacts(oldlist,oldmap);
        ContactHelperClass.contactrigger55(oldlist,oldmap);
        
    }
    public static void afterundelete(list<sobject> newlist, map<id,sObject> newmap){
        //ContactHelperClass.numberofContacts(newlist,newmap);
        ContactHelperClass.contactrigger55(newlist,newmap);
       
    }
    
}