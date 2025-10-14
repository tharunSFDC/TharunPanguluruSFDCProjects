public class BackUpBatch implements Database.Batchable<sObject>{
    public string sObjectQuery;
    list<Generice_BackUp__c> backupslist = new list<Generice_BackUp__c>();
    
    public BackupBatch(string sObjectQuery)
    {
        if(sObjectQuery!=null)
        {
            this.sObjectQuery=sObjectQuery;
        }
    }
    
    public  Database.querylocator start(Database.Batchablecontext bc){
        return Database.getQueryLocator(sObjectQuery);
    }
    public void execute(Database.BatchableContext bc, list<sObject> scope){
        
        list<sObject> sobjectlist = new list<sObject>();
        if(scope !=null)
        {
            for(SObject sob:scope)
            {
                sobjectlist.add(sob);
                
            }
            for(integer i=0; i<scope.size();i++)
            {
                sObject obj=sobjectlist.get(i);
                system.debug(obj);
                
                Generice_BackUp__c gb = new Generice_BackUp__c();
                gb.Name=obj.getsObjectType().getDescribe().getName()+' '+i;
                gb.Source_Object__c=obj.getsObjectType().getDescribe().getName();
                gb.Record_Id__c=obj.id;
                gb.Serialized_Data__c=JSON.SerializePretty(obj);
                backupslist.add(gb);
           }
        }
        if(backupslist !=null)
        {
            Database.Insert(backupslist,false);
        }
        
    }
    public void finish(Database.BatchableContext bc){
        
        system.debug('The Batch have completed successfully');
        
        
    }
    

}