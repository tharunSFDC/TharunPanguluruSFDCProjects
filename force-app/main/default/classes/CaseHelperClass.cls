public class CaseHelperClass{
    public static string userid;
    public static string Queueid;
    public static string storid;
    
    // Scenario: Update the Case Count on Account Based on Case Record Type.
    /* You are working on a Salesforce org where Accounts can have muitiple cases related them. These Cases can be of different types, such as:
Technical Support
Customer Complaint\
Each Of these id defined using record type on the case object your client wants to track the number of cases for each type directly on the Account
record using two custom number fields
Technical Support Cases( Number field on Account)
Customer Complaint Cases( Nubmer field on Account)*/
    public static void caseCountUpdateonAccount(list<Case> newlist, map<id,sObject> oldmap){
        set<id> accountids= new set<id>();
        set<id> recordtypeids = new set<id>();
        Id recordTypePersonCustomer = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Customer_Complaint').getRecordTypeId();
        Id recordTypePersonTecnical = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Technicall_Support').getRecordTypeId();
        recordtypeids.add(recordTypePersonCustomer);
        recordtypeids.add(recordTypePersonTecnical);
        Integer TechnicalCasesCount=0;
        Integer CustomerComplaintCount=0;
        
        if(!newlist.isempty())
        {
            
            for(case ca:newlist)
            {
                if(ca.AccountId !=null)
                {
                    accountids.add(ca.AccountId);
                }
                Case oldcase=(Case)oldmap.get(ca.id);
                if(ca.AccountId != oldcase.AccountId && oldcase.AccountId !=null)
                {
                    accountids.add(ca.AccountId);
                    accountids.add(oldcase.AccountId);
                }
            }
        }
        
        if(newlist.isempty())
        {
            return;
        }
        if(!accountids.isempty())
        {
            list<Account> accupdate = new list<Account>();
            map<id,integer> technicalsupport = new map<id,integer>();
            map<id,integer> customercom = new map<id,Integer>();
            list<AggregateResult> agrresult=[select AccountId,RecordTypeId,Count(id) casecount from Case where AccountId in :accountids Group By AccountId,RecordTypeId];
            
            if(!agrresult.isempty())
            {
                for(AggregateResult agg:agrresult)
                {
                    id accid=(id)agg.get('AccountId');
                    id recordids=(id)agg.get('RecordTypeId');
                    integer count=(integer)agg.get('casecount');
                    
                    if(recordids == recordTypePersonTecnical)
                    {
                        technicalsupport.put(accid,count);
                    }else if(recordids == recordTypePersonCustomer)
                    {
                        customercom.put(accid,count);
                    }
                }
            }
            
            if(!customercom.isempty() && !technicalsupport.isempty())
            {
                for(id accounts:accountids)
                {
                    Account acc = new Account();
                    acc.id = accounts;
                    acc.Technical_Support_Cases__c=technicalsupport.containsKey(accounts) ? technicalsupport.get(accounts):0;
                    acc.Customer_Complaint_Cases__c=customercom.containsKey(accounts) ? customercom.get(accounts):0;
                    accupdate.add(acc);
                }
            }
            
            if(!accupdate.isempty())
            {
                Database.SaveResult[] Result =Database.Update(accupdate,false);
                system.debug(result);
            }
            
            
        }
        
    }
    public static void customNotificationsDeveipertoCaseonStatus(list<Case> newlist, map<id,sObject> oldmap)
    {
        if(!newlist.isempty())
        {
            for(Case ca:newlist)
            {
                if(!oldmap.isempty())
                {
                    Case oldcaserecord=(Case)oldmap.get(ca.id);
                    
                    if(ca.Status=='Escalated' && oldcaserecord.Status !='Escalated' && 
                       ca.Priority=='High' && oldcaserecord.Priority !='High')
                    {
                        storid=ca.OwnerId;
                        if(storid.startsWith('005'))
                        {
                            userid=ca.OwnerId;
                        }else if(storid.StartsWith('00G'))
                        {
                            Queueid=ca.OwnerId;
                        }
                        
                    }
                }
            }
        }
        DeliverCustomNotification(newlist);
        
    }
    public static void DeliverCustomNotification(list<Case> newlist)
    {
        if(Queueid !=null || userid!=null)
        {
            set<string> useridslist = new set<string>();
            map<id,User> usermap = new map<id,User>([select id,managerId,FirstName,LastName from User where id =:userid]);
            map<id,Groupmember> groupmap = new map<id,Groupmember>([select id,UserorGroupId from Groupmember where GroupId =:Queueid]);
            CustomNotificationType notificationType =  [SELECT Id, DeveloperName FROM CustomNotificationType WHERE DeveloperName='Send_New_Custom_Notification_to_Manager_and_Queue_Members'];
            if(!usermap.isempty())
            {
                for(user us:usermap.values())
                {
                    useridslist.add(us.Id);
                    useridslist.add(us.ManagerId);
                }
            }
            
            if(!groupmap.isempty())
            {
                for(Groupmember gp:groupmap.values())
                {
                    useridslist.add(gp.UserOrGroupId);
                    
                }
                
            }
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            
            // Set the contents for the notification
            notification.setTitle('Apex Custom Notification');
            notification.setBody('The notifications are coming from INSIDE the Apex!'+'Case Number '+newlist[0].CaseNumber);
            
            // Set the notification type and target
            notification.setNotificationTypeId(notificationType.Id);
            notification.setTargetId(newlist[0].id);
            
            try{
                notification.send(useridslist);
                
            }catch(Exception e)
            {
                system.debug('The Error Occured While Generating the Custom Message'+e.getmessage());
            }
          
        }
    }
    
    public static void Casehandlertrigger(list<Case> caslist){
        
        set<string> emails = new set<string>();
        map<string,contact> conmap = new map<string,contact>();
        list<Contact> insertconlist = new list<Contact>();
        map<string,id> emailtocontactmap = new map<string,id>();
        
        if(caslist !=null)
        {
            for(Case ca:caslist)
            {
                if(ca.Supplied_Email__c !=null)
                {
                    emails.add(ca.Supplied_Email__c);
                }
            }
        }
        if(emails !=null)
        {
            list<Contact> conlist = [select id,Email from Contact where email in :emails];
            
            if(conlist !=null)
            {
                for(contact con:conlist)
                {
                    conmap.put(con.Email, con);
                }
            }
            
            for(Case ca:caslist)
            {
                if(conmap.containsKey(ca.Supplied_Email__c))
                {
                    Contact con=conmap.get(ca.Supplied_Email__c);
                    emailtocontactmap.put(con.Email, con.id);
                    
                }
                else {
                    Contact newcon = new Contact();
                    newcon.FirstName='testing';
                    newcon.LastName='sampltesting';
                    newcon.Phone='02357860935';
                    newcon.email=ca.Supplied_Email__c;
                    insertconlist.add(newcon);
                }
            }
            if(insertconlist !=null)
            {
                insert insertconlist;
                
                for(contact newcon:insertconlist)
                {
                    emailtocontactmap.put(newcon.Email,newcon.id);
                    
                }
            }
            
            for(Case csr:caslist)
            {
                if(emailtocontactmap.containsKey(csr.Supplied_Email__c))
                {
                    csr.contactid=emailtocontactmap.get(csr.Supplied_Email__c);
                    
                }
            }
        }
    }
}