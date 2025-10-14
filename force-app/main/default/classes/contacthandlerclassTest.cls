@isTest
private class contacthandlerclassTest {
    
    @isTest
    static void apexTriggerhandlermethodtest() {
        
        
        account acct= new account(Name='test');
        insert acct;
        contact con1= new contact(lastname='test',accountid=acct.id,pr__c=false);
        contact con2= new contact(lastname='test12',accountid=acct.id,pr__c=true);
        list<contact> conlist = new list<contact>{con1,con2};
            insert conlist;
        
        test.starttest();
        conlist[0].pr__c=true;
        conlist[1].pr__c=false;
        update conlist;
        test.stoptest();
        
        contact conup=[select id,pr__c from contact where id=:conlist[1].id];
        system.assertEquals(false,conup.pr__c);
        
    }
}