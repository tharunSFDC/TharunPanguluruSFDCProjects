public class ContactFactory implements DataFactory {
    
    public list<sObject> getrecord()
    {
        list<Contact> conlist = new list<Contact>();
        
        
        for(integer i=0;i<=10;i++)
        {
            Contact con = new Contact();
            con.FirstName='testing'+i;
            con.LastName='sampleteing'+i;
            con.Email='tharun@gmail.com';
            conlist.add(con);
        }
        
        return conlist;
        
    }
    public list<sObject> createRecord()
    {
        list<Contact> insertcontact =getrecord();
        
        if(insertcontact !=null)
        {
            insert insertcontact;
        }
        
        return insertcontact;
        
    }

}