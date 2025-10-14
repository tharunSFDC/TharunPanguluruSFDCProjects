import { LightningElement, api } from 'lwc';
import generatepdf from '@salesforce/apex/pdfController.generatepdf';

export default class Realtimeusecasen01 extends LightningElement {

    @api recordId;
    imageurl='https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'

    invoicdata={
        invno:123,
        invdate:'20-10-2020',
        invtotal:5000,
        invdesc:'This is sample invoice',
        company:'Salesforce',
        address:'AP 517131',
        address2:'Chittoor Andhra Pradesh'
    }

    clientdata={
        clientname:'Kumar Swamy',
        username:'kumarsway007@salesforce.com',
        email:'kumarsway007@salesforce.com'
    }
    services=[
        {name:'Sales Cloud', Price:10},
        {name:'Service Cloud', Price:20},
        {name:'Field Service', Price:30},
        {name:'Community Cloud', Price:40},
        {name:'Sales Cloud', Price:50},
        {name:'Service Cloud', Price:60}
    ]
    get totalPrice()
    {
        return this.services.reduce((total,service)=>{

            return total=total+service.Price;

        },0)
    }

    handlepdf()
    {
        let content= this.template.querySelector('.container');
       // console.log(content.outerHTML)
        console.log(this.recordId);
        let recordids='003dM0000055RpZQAU'

        generatepdf({recordId:recordids, htmldata:content.outerHTML}).then(result =>{
            console.log(result)
            window.open(`https://ddm00000awnvduaj-dev-ed.develop.file.force.com/servlet/servlet.FileDownload?file=${result.Id}`)
        }).catch(error =>{
            console.log(error)
        })
        

    }
}