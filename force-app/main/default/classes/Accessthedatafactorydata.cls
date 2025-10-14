public class Accessthedatafactorydata {
    
    public static void testData()
    {
        list<Account> accountData =(list<Account>)datacreater.creatRecord(Account.sObjectType);
        if(accountData !=null)
        {
            for(Account acc:accountdata)
            {
                system.debug('Account Name ===>: '+ acc.Name);
            }
        }
        list<Contact> contactdata =(list<contact>)datacreater.creatRecord(Contact.sObjectType);
        if(contactdata !=null)
        {
            for(Contact con:contactdata)
            {
                system.debug('Contact FirstName and LastName ===>: '+ con.FirstName + ' ' + con.LastName);
            }
        }
        list<Lead> leadsData=(list<Lead>)DataCreater.creatRecord(Lead.sObjecttype);
        
        if(leadsData !=null)
        {
            for(Lead ld :leadsData)
            {
                system.debug('lead Name and lead Soruce ====>: '+ ' ' + ld.Firstname+ ' '+ ld.LastName + ' ' + ld.LeadSource);
            }
        }
    }

}