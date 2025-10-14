public class pdfController {
     
    @AuraEnabled
    public static Attachment generatepdf(id recordId, string htmldata)
    {
        Pagereference page = Page.renderAsPDF;
        page.getParameters().put('pdfText',htmldata);
        system.debug(recordId);
        system.debug(htmldata);

        Contact ca = new Contact(id=recordId);
        Attachment objcontact = new Attachment();
        objcontact.Name='inovice.pdf';
        objcontact.ParentId=ca.id;
        objcontact.Body=page.getContentAsPDF();
        objcontact.IsPrivate=false;

        insert objcontact;

        return objcontact;
    }
}