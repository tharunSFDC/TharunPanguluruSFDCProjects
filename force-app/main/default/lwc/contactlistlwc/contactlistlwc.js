import { LightningElement,api, wire } from 'lwc';
import contactmethod from '@salesforce/apex/contactlistclass.contactmethod';

export default class Contactlistlwc extends LightningElement {

    @api contactidsfromparetn;
    newlistcontacts=null;
    errorlissr=null;

    hanleSave()
    {
        contactmethod({contactid:this.contactidsfromparetn}).then(res=>
        {
            this.newlistcontacts=res;
            console.log(this.newlistcontacts);
        }
        ).catch(err=>{
            this.errorlissr=err.body.message;
            console.log(this.errorlissr);
        });

    }

    
}