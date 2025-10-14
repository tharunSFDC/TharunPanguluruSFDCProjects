public  class empupdateClass {

    @AuraEnabled
    public static list<Employee__c> EmployeeRecordsView(){

            list<Employee__c> EmployeeList =[SELECT Id, Name, Education__c, 
            Job_Title__c, Email__c, Skills__c,Expected_Salary__c, 
            Application_Status__c,Phone__c FROM Employee__c];

            return EmployeeList;
            

    }
    @AuraEnabled
    public static void EmployeeRecordsUpdateApproved(Id Applicationid){
        try {

            Employee__c Approvedemp1 =[select id,Application_Status__c from Employee__c where id=:Applicationid];
            Approvedemp1.Application_Status__c='Approved';
            update Approvedemp1;
           
        } catch (Exception e) {
            system.debug(e.getMessage());
        }
    }

    @AuraEnabled
    public static void EmployeeRecordsUpdateRejected(id Applicationid){
        try {
            Employee__c Rejectedemp1 =[select id,Application_Status__c from Employee__c where id=:Applicationid];
            Rejectedemp1.Application_Status__c='Rejected';
            update Rejectedemp1;
            
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }
}