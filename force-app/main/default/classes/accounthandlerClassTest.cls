@isTest
private class accounthandlerClassTest {

@isTest
    static void testAccountMethod() {


        Account ac1= new Account(name='test');
        ac1.Status__c=true;
        ac1.BillingCity='City';
        insert ac1;

        Contact con= new Contact(lastname='testcontact',AccountId=ac1.id,isactive__c=true);
        insert con;

        Account ac2= new Account(name='test2');
        ac2.Status__c=false;
        ac2.BillingCity='City2';
        insert ac2;


        map<id,Account> accmpa=new map<id,Account>([select id,name,status__c from Account]);

        Test.startTest();
        accounthandlerClass.AccountMethod(new list<Account>{ac1,ac2}, accmpa);
        Test.stopTest();

        System.assertEquals(true, ac1.Status__c);
        System.assertEquals(false, ac2.Status__c);
    }
}