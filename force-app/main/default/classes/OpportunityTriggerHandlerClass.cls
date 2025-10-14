public class OpportunityTriggerHandlerClass implements THTriggerhandler {
    public static void beforeinsert(list<sobject> newlist){
        Opportunityhelper.apextrigger71(newlist);
        
    }
    public static void beforeudpate(list<sobject> newlist, map<id,sObject> newmap, list<sObject> oldlist, map<id,sObject> oldmap){
       // Opportunityhelper.ApextriggerStageNametesting(newlist,oldmap);
        
        
    }
    public static void beforedelete(list<sobject> oldlist,map<id,sObject> oldmap ){
        
    }
    public static void afterinsert(list<sobject> newlist, map<id,sObject> newmap){
        Opportunityhelper.Oppohelpermethod(newlist,newmap);
        Opportunityhelper.aprextriggernttdata(newlist,newmap);
        OpportunityHelperClass2.Oppomethodtogetcountof(newlist,newmap);
        Opportuintytriggerforecast.foresCastMethod(newlist,newmap);
        OpportunityHelperClass2.oppoRecordAndtotatamount(newlist, newmap);
        
    }
    public static void afterupdate(list<sobject> newlist, map<id,sObject> newmap, list<sObject> oldlist, map<id,sObject> oldmap){
        Opportunityhelper.Oppohelpermethod(newlist,oldmap);
        Opportunityhelper.ApexOpportunityShareTrigger65(newlist,oldmap);
        Opportunityhelper.aprextriggernttdata(newlist,oldmap);
        OpportunityHelperClass2.Oppomethodtogetcountof(newlist,oldmap);
        Opportuintytriggerforecast.foresCastMethod(newlist,oldmap);
        OpportunityHelperClass2.oppoRecordAndtotatamount(newlist, oldmap);
        
        
    }
    public static void afterdelete(list<sobject> oldlist,map<id,sObject> oldmap){
        Opportunityhelper.Oppohelpermethod(oldlist,oldmap);
        OpportunityHelperClass2.oppoRecordAndtotatamount(oldlist, oldmap);
        
        
    }
    public static void afterundelete(list<sobject> newlist, map<id,sObject> newmap){
        Opportunityhelper.Oppohelpermethod(newlist,newmap);
        OpportunityHelperClass2.oppoRecordAndtotatamount(newlist, newmap);
    }
    
}