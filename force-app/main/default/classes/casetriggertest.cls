@istest
public class casetriggertest {
    
    @istest
    public static void testBeforeinsert()
    {
        list<Case> caselist = new list<Case>();
        Case newcase = new Case();
        newcase.Subject='repair';
        newcase.Origin='Phone';
        newcase.Supplied_Email__c='tharuncse508@gmail.com';
        caselist.add(newcase);
        insert caselist;
        
        casehandlerClass.Casehandlertrigger(caselist);
    }

}