@istest
public class MarketplaceHelperClassTest {
    @testsetup
    public static void TestDatafortheMarketPlaceMethods()
    {
        
        Account acc = new Account();
        acc.Name='TestingAccount';
        acc.Description='tharun';
        
        insert acc;
        
        Asset ass = new Asset();
        ass.Name='Testingasset';
        ass.AccountId=acc.id;
        
        Insert ass;
        
        list<Marketplace__c> marketplacelist = new list <Marketplace__c>();
        
        for(integer i=0; i<=3; i++)
        {
            Marketplace__c ma = new Marketplace__c();
            ma.Name='TestingMarketPlace 00'+i;
            ma.Asset__c=ass.Id;
            marketplacelist.add(ma);
            
        }
        
        if(!marketplacelist.isempty())
        {
            Database.SaveResult[] results= Database.Insert(marketplacelist,false);
        }
 
    }
    
    @istest
    public static void testMethod001()
    {
        list<Marketplace__c> malist = [select id,Name,Asset__c from Marketplace__c];
        map<id,Marketplace__c> mamap = new map<id,Marketplace__c>([select id,Name,Asset__c from Marketplace__c]);
        Account acc=[select id,Name,Description from Account];
        map<id,asset> assmap= new map<id,asset>([select id,Name,AccountId from Asset]);

        
        
        test.StartTest();
        MarketplaceHelperClass.afterInsertAndUpdate(malist,mamap);
        Test.StopTest();
        
        Account acc1=[select id,Name,Description,Active_Marketplace__c from Account where Name ='TestingAccount'];
        system.debug(acc1.Name);
        system.debug(acc1.Active_Marketplace__c);
        
        
        
    }

}