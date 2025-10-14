public class ContactConsts {
    
    public static final contactconsts INSTANCE = new ContactConsts();
    
    public final string API_NAME= Contact.sObjectType.getdescribe().getName();
    
    public final leadsource LEAD_SOURCE = new leadsource();
    
    PUBLIC class leadsource{
        
        public final string OTHER ='OTHER';
        public final string PARTNER_REFERRAL='PARTNER REFERRAL';
        public final string PHONE_INQUIRY='PHONE INQUIRY';
        public final string PURCHASED_LIST='PURCHASED LIST';
        public final string WEB='WEB';
    }

}