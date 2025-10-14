public class pdfpagecontroller {
    public string pdfText{get;set;}
    public pdfpagecontroller() {

        pdfText= String.escapeSingleQuotes(
            ApexPages.currentPage().getParameters().get('pdfText')
        );

    }
}