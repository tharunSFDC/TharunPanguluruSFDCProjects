@istest
public class OpportunityhelperTest {
    
    /*  
static testmethod void oppapextrigger71testmethod()
{
list<Account> acclist=(list<Account>)DataCreater.creatRecord(Account.sObjectType);
system.debug(acclist[0]);
list<Opportunity>opplist =(list<Opportunity>)DataCreater.creatRecord(Opportunity.sObjectType);
list<Opportunity> oppupdate = new list<Opportunity>();

for(Opportunity opp: opplist)
{
opp.Accountid=acclist[0].id;
oppupdate.add(opp);
}
if(oppupdate !=null)
{
update oppupdate;
}

test.StartTest();
try{
Opportunityhelper.apextrigger71(oppupdate);
}catch(exception ex)
{
system.debug(ex.getmessage());

}
test.Stoptest();



} 

static testmethod void ApexOpportunityShareTrigger65Test()
{
profile p=[select id from profile where name='System Administrator'];

User testuser = new user();
testuser.Alias='testu';
testuser.Email='testuser@gmail.com';
testuser.EmailEncodingKey='UTF-8';
testuser.LastName='Test';
testuser.LanguageLocaleKey='en_US';
testuser.LocaleSidKey='en_US';
testuser.ProfileId=p.id;
testuser.TimeZoneSidKey='America/Los_Angeles';
testuser.Username='testuserunq007PSA@gmail.com';

insert testuser;

list<Opportunity>opplist =(list<Opportunity>)DataCreater.creatRecord(Opportunity.sObjectType);


Deal_Reveiew__c de = new Deal_Reveiew__c ();
de.Name='testing';
de.Opportunity__c=opplist[0].id;

insert de;

map<id,Opportunity> oppmap = new map<id,Opportunity>();

for(opportunity opp: opplist)
{
opp.StageName='Prospecting';
oppmap.put(opp.id,opp);
}
if(oppmap !=null)
{
update oppmap.values();
}
list<Opportunity> oppupdate = new list<Opportunity>();

for(Opportunity opp:opplist)
{
opp.StageName='Closed Won';
opp.OwnerId=testuser.Id;
oppupdate.add(opp);


}
if(oppupdate !=null)
{
update oppupdate;
}        


system.runAs(testuser)
{
test.StartTest();
Opportunityhelper.ApexOpportunityShareTrigger65(oppupdate,oppmap);
test.StopTest();
}

list<Deal_Reveiew__c> dealre =[select id from Deal_Reveiew__c];
list<Deal_Reveiew__Share> dealshare = [select id,ParentId,UserOrGroupId,AccessLevel from Deal_Reveiew__Share];

system.AssertnotEquals(null,dealshare,'The Deal Review Record should created');
system.assertEquals(dealre[0].id,dealshare[0].parentid);


} */
    
    @istest
    public static void openandclosedopportunitysmethod()
    {
        list<Opportunity> opplist1 = new list<Opportunity>();
        map<id,Opportunity> oppomap = new map<id,opportunity>();
        map<id,Opportunity> oppomapupdate = new map<id,opportunity>();
        list<Account> acclist=(list<Account>)DataCreater.creatRecord(Account.sObjectType);
        list<Opportunity>opplist =(list<Opportunity>)DataCreater.creatRecord(Opportunity.sObjectType);
        for(Opportunity oppo:opplist){
            oppo.AccountId=acclist[0].id;
            oppo.StageName='Needs Analysis';
            system.debug(oppo.AccountId);
            opplist1.add(oppo);
        }
        update opplist;
        
        oppomap.put(opplist[0].id,opplist[0]);
        oppomap.put(opplist[1].id,opplist[1]);
        oppomap.put(opplist[2].id,opplist[2]);
        oppomap.put(opplist[3].id,opplist[3]);
        
        for(Opportunity oppo:oppomap.values())
        {
            oppo.StageName='Closed Lost';
            oppomapupdate.put(oppo.id,oppo);
            
        }
        update oppomapupdate.values();
        
        
    
        test.starttest();
        OpportunityHelperClass2.Oppomethodtogetcountof(opplist1,oppomapupdate);
        test.stoptest();
        
        Account accounts=[select id,name,Closed_Opportunitys__c,Open_Opportunitys__c from Account where id=:opplist1[0].AccountId];
        system.assertEquals(accounts.Closed_Opportunitys__c,4,'Expeted 4 closed opportunitys');
        system.assertEquals(accounts.Open_Opportunitys__c,7,'Expeted 7 open opportunitys');
        system.AssertnotEquals(null,accounts.Closed_Opportunitys__c,'The closed oppo shoube have values');
        system.AssertnotEquals(null,accounts.Open_Opportunitys__c,'The open oppo shoube have values');
        
        opplist1.clear();
        
        OpportunityHelperClass2.Oppomethodtogetcountof(opplist1,oppomapupdate);
        
        
    }
    
}