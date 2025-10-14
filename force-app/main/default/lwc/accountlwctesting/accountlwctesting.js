import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';

export default class Accountlwctesting extends LightningElement {


    accname=null;
    @api
    accid=null;

    handledata(event)
    {
        this.accname=event.target.value;
    }

    handlesave()
    {
        const newaccname={
            'Name':this.accname
        };
        const recordInput = { apiName: 'Account', fields: newaccname };
        createRecord(recordInput).then(res =>{
            this.accid=res.id;
            console.log(this.accid);
        }).catch(err=>{
            alert(err.body.message);

        })
    }

    


    
}