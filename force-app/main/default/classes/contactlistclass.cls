public  class contactlistclass {

    @AuraEnabled
    public static list<Contact> contactmethod(id contactid){

        set<id> conids = new set<id>();
        conids.add(contactid);
        return [select id,LastName from Contact where id in:conids limit 10];
    }
}