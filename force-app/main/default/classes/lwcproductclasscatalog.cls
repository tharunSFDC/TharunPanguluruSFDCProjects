public with sharing class lwcproductclasscatalog {

    @AuraEnabled(cacheable=true)
    public static list<Product2> ProductsCatalogMethod(){

       // set<id> setpoeids = new set<id>();
        //setpoeids.add(proids);

        list<Product2> productlist =[select id,Name,IsActive,ProductCode,
        Product_Cost__c,Family,Description,	Product_image__c from Product2 ];

        return productlist;
    }

     @AuraEnabled(cacheable=true)
     public static Product2 ProductsUpdate(string poids){

        string recordids;

        if(poids !=null)
        {
            recordids=poids;

        }

        Product2 prolist;

        try {
            prolist =[select id,Name,IsActive,ProductCode,Product_Cost__c,Family,Description,Product_image__c from Product2 where id =:recordids];
        //return prolist;
        } catch (Exception e) {
            System.debug(e.getMessage());
            
        }
        return prolist;

}

}