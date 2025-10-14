public class leadHelperClass {
    
    public static void ApexTriggeronLeadConversionTaskCreationUpdate(list<Lead> newlist, map<id,sObject> oldmap)
    {
        list<lead> Convertedleadlist = new list<lead>();
        set<id> ConvertedAccountids = new set<id>();
        set<id> ConvertedContactids = new set<id>();
        set<id> ConvertedOpportunityIds = new set<id>();
        map<id,Account> accmap = new map<id,Account>();
        map<id,Contact> conmap = new map<id,Contact>();
        list<Task> newTask = new list<Task>();
        map<id,Opportunity> oppmap = new map<id,Opportunity>();
       if(newlist !=null)
        {
            for(Lead ld:newlist)
            {
                if(oldmap !=null)
                {
                    lead oldlead = (lead)oldmap.get(ld.id);
                    
                    if(ld.IsConverted==true && oldlead.IsConverted==false)
                    {
                        Convertedleadlist.add(ld);
                        
                        if(ld.ConvertedAccountId !=null)
                        {
                            ConvertedAccountids.add(ld.ConvertedAccountId);
                            
                        }
                        if(ld.ConvertedContactId !=null)
                        {
                            ConvertedContactids.add(ld.ConvertedContactId);
                        }
                        if(ld.ConvertedOpportunityId !=null)
                        {
                          ConvertedOpportunityIds.add(ld.ConvertedOpportunityId);
                        }
                        
                    }
                }
            }
        }
        
        if(Convertedleadlist !=null)
        {
            if(ConvertedAccountids !=null)
            {
                accmap =new map<id,Account>([select id,Name from Account where id in :ConvertedAccountids]);
            }
            if(ConvertedContactids !=null)
            {
                conmap= new map<id,contact>([select id,firstName,LastName,Email,Phone from Contact where id in :ConvertedContactids]);
            }
            if(ConvertedOpportunityIds !=null)
            {
                oppmap = new map<id,Opportunity>([select id,Name,CloseDate from Opportunity where id in:ConvertedOpportunityIds]);
            }
            
            for(lead lds:Convertedleadlist)
            {
                Task tk = new Task();
                tk.Subject='Follow-Up with Converted leads';
                tk.Priority='Normal';
                tk.Status='Not Started';
                tk.ActivityDate=date.today()+7;
                tk.WhoId=lds.ConvertedContactId;
                tk.WhatId=lds.ConvertedOpportunityId;
                
                string taskDescription ='Lead Name :'+' '+ lds.FirstName+' '+lds.LastName+'\n';
                taskDescription +='Lead Email Address:'+' '+ lds.Email +' \n';
                taskDescription +='Lead Phone '+' '+ lds.Phone+ '\n';
                
                if(accmap.containskey(lds.ConvertedAccountId))
                {
                    Account acc= accmap.get(lds.ConvertedAccountId);
                    
                    taskDescription +='Account Name: '+' '+acc.Name+'\n';
                }
                if(conmap.containskey(lds.ConvertedContactId))
                {
                    Contact con=conmap.get(lds.ConvertedContactId);
                    taskDescription +='Contact FirstName and LastName:'+' '+con.FirstName+' '+con.LastName+'\n';
                    taskDescription +='Contact Email :'+' '+con.Email+'\n';
                    taskDescription +='contact Phone: '+' '+ con.Phone+'\n';
                }
                if(oppmap.containskey(lds.ConvertedOpportunityId))
                {
                    Opportunity opp=oppmap.get(lds.ConvertedOpportunityId);
                    taskDescription +='Opportunity Name :'+' '+opp.Name+'\n';
                    taskDescription +='Opportunity Close Date :'+' '+opp.CloseDate+'\n';
                }
                tk.Description=taskDescription;
                newTask.add(tk);
            }
            
        }
        if(newTask !=null)
        {
            DataBase.insert(newTask,False);
        }
    }

}