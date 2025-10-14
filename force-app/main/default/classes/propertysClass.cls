public with sharing class propertysClass {


    @AuraEnabled(cacheable=true)
    public static list<Property__c> propertyslist(){

         list<Property__c> propertlist=[select Thumbnail__c,Name,
                                                Location__c,State__c,City__c,Country__c,
                                                  Number_of_Rooms__c,
                                               Sales_Price__c from Property__c];
      return propertlist;

    }

    @AuraEnabled(cacheable=true)
    public static list<Property__c>  propertyfilterlist(string city, 
                                                          Decimal salesprice, 
                                                          Integer numberofrooms, 
                                                          Integer minBathrooms ) 
    {
      string searchpattern='%'+city+'%';
      list<Property__c> listofpropertys=[select id,Thumbnail__c,Name,Sales_Price__c,City__c,
      Number_of_Rooms__c from Property__c 
      where City__c =:searchpattern or 
      Sales_Price__c=:salesprice or 
      Number_of_Rooms__c=:numberofrooms or 
      Baths__c=: minBathrooms ];

      return listofpropertys;


    }


}