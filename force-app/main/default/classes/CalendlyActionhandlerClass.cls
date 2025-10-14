public class CalendlyActionhandlerClass {
    
    public static void CalendlyapexTriggerMethod(list<Calendly__CalendlyAction__c> callist)
    {   
        
        list<User> userlist =[select id,profileId,Email from user where profileid='00edM000006DtGCQA0' and email='jayanth@gmail.com'];
        map<string,Calendly__CalendlyAction__c> calmap = new map<string,Calendly__CalendlyAction__c>();
        list<lead> updateexitinglead = new list<lead>();
        list<lead> insertleads = new list<lead>();
        list<Event> insertEvent = new list<Event>();
        if(callist !=null)
        {
            for(Calendly__CalendlyAction__c ca:callist)
            {
                if(ca.Name =='invitee.created')
                {
                    calmap.put(ca.Calendly__InviteeEmail__c,ca);
                    
                }
            }
        }
        if(calmap !=null)
        {
            list<Lead> leadlist=[select id,
                                 FirstName,
                                 Lastname,
                                 email,
                                 Phone,
                                 MobilePhone,
                                 Company,
                                 OwnerId,
                                 LeadSource 
                                 from Lead where Email in :calmap.keyset() limit 10];
            
            if(!leadlist.isempty())
            {
                for(lead ld:leadlist)
                {
                    Calendly__CalendlyAction__c cal =calmap.get(ld.Email);
                    
                    if(cal !=null)
                    {
                        ld.FirstName=cal.Calendly__InviteeFirstName__c;
                        ld.LastName=cal.Calendly__InviteeLastName__c;
                        ld.Email=cal.Calendly__InviteeEmail__c;
                        ld.Phone=cal.Calendly__Location__c;
                        ld.MobilePhone=ld.Phone;
                        ld.Company='NTT DATA';
                        ld.OwnerId=userlist[0].id;
                        ld.LeadSource='Web';
                        updateexitinglead.add(ld);
                    }
                } 
                
            }else{
                if(leadlist.isempty())
                {
                    for(Calendly__CalendlyAction__c cal:callist)
                    {
                        if(cal.Name =='invitee.created')
                        {
                            lead ld = new lead();
                            ld.FirstName=cal.Calendly__InviteeFirstName__c;
                            ld.LastName=cal.Calendly__InviteeLastName__c;
                            ld.Email=cal.Calendly__InviteeEmail__c;
                            ld.Company='Salesforce';
                            ld.LeadSource='Web';
                            ld.MobilePhone=cal.Calendly__Location__c;
                            ld.Phone=ld.MobilePhone;
                            ld.OwnerId=userlist[0].id;
                            insertleads.add(ld);
                        }                        
                    }
                    
                }
                
            }
            
        }
        
        if(updateexitinglead !=null)
        {
            Database.SaveResult[] result=Database.update(updateexitinglead,false);
            
            for(lead ld:updateexitinglead)
            {
                Calendly__CalendlyAction__c cal =calmap.get(ld.Email);
                
                if(cal.Name=='invitee.created')
                {
                    Event ev = new Event();
                    ev.StartDateTime=cal.Calendly__EventStartTime__c;
                    ev.EndDateTime=cal.Calendly__EventEndTime__c;
                    ev.Subject='Call';
                    ev.WhoId=ld.id;
                    ev.Description=cal.Calendly__EventDescription__c;
                    ev.Location=cal.Calendly__InviteeUuid__c;
                    insertEvent.add(ev);
                    
                }
            }
            
        }
        if(insertleads !=null)
        {
            Database.SaveResult[] result=Database.insert(insertleads,false);
            for(lead ld:insertleads)
            {
                Calendly__CalendlyAction__c cal =calmap.get(ld.Email);
                
                if(cal.Name=='invitee.created')
                {
                    Event ev = new Event();
                    ev.StartDateTime=cal.Calendly__EventStartTime__c;
                    ev.EndDateTime=cal.Calendly__EventEndTime__c;
                    ev.Subject='Call';
                    ev.WhoId=ld.id;
                    ev.Description=cal.Calendly__EventDescription__c;
                    ev.Location=cal.Calendly__InviteeUuid__c;
                    insertEvent.add(ev);
                    
                }
            }
        }
        
        if(insertEvent !=null)
        {
            Database.SaveResult[] result=Database.insert(insertEvent,false);
        }
        
    }
    public static void toCanceltheEvent(list<Calendly__CalendlyAction__c> calist)
    {
        map<string,Calendly__CalendlyAction__c> newmapcal = new map<string,Calendly__CalendlyAction__c>();
        list<Event> eventupdate = new list<Event>();
        if(calist !=null)
        {
            for(Calendly__CalendlyAction__c cal:calist)
            {
                if(cal.Name=='invitee.canceled')
                {
                    if(cal.Calendly__InviteeUuid__c !=null)
                    {
                        newmapcal.put(cal.Calendly__InviteeUuid__c,cal);
                    }
                }
            }
        }
        
        if(newmapcal !=null)
        {
            list<Event> eventlist =[select id,Location from Event where location in : newmapcal.keyset() limit 10];
            
            if(eventlist !=null)
            {
                for(Event ev:eventlist)
                {
                    Calendly__CalendlyAction__c cal = newmapcal.get(ev.location);
                    
                    ev.Subject= cal.Calendly__EventSubject__c;
                    ev.Description=cal.Calendly__EventDescription__c;
                    eventupdate.add(ev);
                    
                }
            }
        }
        if(eventupdate !=null)
        {
            Database.update(eventupdate,false);
        }
    }
}