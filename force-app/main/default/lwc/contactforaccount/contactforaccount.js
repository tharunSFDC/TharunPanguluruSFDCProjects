import { LightningElement,api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';

export default class Contactforaccount extends LightningElement {


    @api accountid;

    conlastname=null;
    @api contactid=null;


    handledata(event)
    {
        this.conlastname=event.target.value;

    }

    handlesave()
    {
        console.log(this.accountid);
        const conlist={
            'LastName':this.conlastname,
            'AccountId':this.accountid
        };

        const recordInput = { apiName: 'Contact', fields: conlist };
        createRecord(recordInput).then(res=>{
            this.contactid=res.id;
            console.log(this.contactid);
            
        }).catch(err=>{
            console.log(err.body.message);
        });

    }
}