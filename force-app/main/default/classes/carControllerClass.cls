public with sharing class carControllerClass {

    public class filters{
        @AuraEnabled
        public string searchKey {get;set;}
        @AuraEnabled
        public Decimal maxPrice {get;set;}
        @AuraEnabled
        public string[] categories {get;set;}
        @AuraEnabled
        public string[] makeType {get;set;}

    }
    @AuraEnabled(cacheable=true)
    public static list<Car__c> carmethod(filters filtershere){
        string key, whereClause='';
        Decimal maxPrice;
        string[] categories, makeType, criteria = new list<string>{};
        if(filtershere != null){
            maxPrice= filtershere.maxPrice;
            categories= filtershere.categories;
            makeType= filtershere.makeType;
            if(!String.isempty(filtershere.searchKey)){
                key= '%'+ filtershere.searchKey + '%';
                criteria.add('Name LIKE :key');
            }
            if(filtershere.maxPrice >=0){
                criteria.add('MRP__c <= :maxPrice');
            }
            if(filtershere.categories != null){
                criteria.add('Category__c IN :categories');
            }
            if(filtershere.makeType != null){
                criteria.add('Make__c IN :makeType');
            }
            if(criteria.size()>0){
                whereClause= ' WHERE ' + String.join(criteria, ' AND ');
            }
        }
        String query= 'SELECT Id, Name, MRP__c, Description__c, Category__c, Picture_URL__c FROM Car__c' + whereClause + ' WITH SECURITY_ENFORCED ORDER BY Name';
        return Database.query(query);

    }
    @AuraEnabled(cacheable=true)
    public static Car__c[] getSimilarCars(Id carId, String[] makeType){
        return [SELECT id,name,MRP__c, Description__c, Category__c, Picture_URL__c FROM Car__c WHERE Make__c IN :makeType AND Id != :carId LIMIT 10];
    }
}