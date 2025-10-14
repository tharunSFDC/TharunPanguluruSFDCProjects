public class accounttesting {

    @AuraEnabled
    public static list<Contact> conlist(id accid)
    {
        list<Contact> conlist = new list<Contact>();

        if(String.isNotEmpty(accid) && String.isNotBlank(accid))
        {
            conlist=[select id,Name,Phone,Email,Accountid from Contact where Accountid=:accid];
        }
        return conlist;
    }

    @AuraEnabled(cacheable=true)
    public static list<Account> getaccounts( Integer limitsize, Integer offset)
    {
        list<Account> acclist=[select id,Name from Account limit :limitsize OFFSET: offset];

        return acclist;
    }
    @AuraEnabled(cacheable=true)
    public static integer totalaccountcount()
    {

        integer accountcount= [select count() from Account];
        return accountcount;
    }

}