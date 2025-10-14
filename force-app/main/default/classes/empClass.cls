public class empClass {

    @AuraEnabled
    public static void methodName(Employee__c emp){
        try {
            insert emp;
            
        } catch (Exception e) {
            system.debug(e.getMessage());
        }
    }

}