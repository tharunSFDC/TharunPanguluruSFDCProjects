import Type from '@salesforce/schema/Account.Type';
import { LightningElement } from 'lwc';
import conlist from '@salesforce/apex/accounttesting.conlist';


const filter={
    criteria:[
        {
            fieldPath:'Industry',
            operator:'eq',
            value:'Energy'
        },
        {
            fieldPath:'Type',
            operator:'eq',
            value:'Customer - Direct'
        },
    ]
}

const columns=[
    {label:'Contact Name',fieldName:'Name',Type:'text'},
    {label:'Contact Phone',fieldName:'Phone',Type:'text'},
    {label:'Contact Email',fieldName:'Email',Type:'text'},

]
;

export default class Recordpicker extends LightningElement {

    accid=null;
   // filter=filter;
    columns=columns;
    contactsdata=[];
    catcherror=[];
    

    handleAccountid(event)
    {
        this.accid=event.detail.recordId;
        console.log(this.accid);
        this.handledata();

    }

    handledata()
    {
        conlist({accid:this.accid}).then(result =>{
            this.contactsdata=result;
        }).catch(error =>{
            this.catcherror=error;
            console.log(this.catcherror);
        });

    }
}