public class oppdata {

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> fetchdata()
    {
        List<Opportunity> opplist=[select id,Name,StageName,Amount from Opportunity limit 5];

        return opplist;
    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> fetchdata1(string sortby, string sortdirection)
    {

        string query='select id,Name,StageName,Amount from Opportunity where Amount !=null';

        if(sortby !=null && sortdirection !=null)
        {

            query += ' order by  '+ sortby +' '+ sortdirection + ' limit 5 ';
        }

        return Database.query(query);
    }

}