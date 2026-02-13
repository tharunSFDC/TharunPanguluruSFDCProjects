import { LightningElement , api, wire} from 'lwc';

import OPPORTUNITY_AMOUNT from '@salesforce/schema/Opportunity.Amount';
import {getRecord} from 'lightning/uiRecordApi';

export default class Applydiscountoppoty extends LightningElement {
    @api recordId;
    discountpercent=0;
    finalamount=0;
    orginalamount=0;
    startflowflag;

    @wire(getRecord,{recordId:'$recordId',fields:[OPPORTUNITY_AMOUNT]}) oppofianlamount({data}){
        if(data){
            this.finalamount=Math.round(data.fields.Amount.value);
            this.orginalamount=this.finalamount;
        }
    }
    
    handleDiscount(event){
        this.discountpercent= Number(event.target.value);
        this.finalamount= Math.round(this.orginalamount - (this.orginalamount * this.discountpercent / 100));

    }
    applyDiscountValue(event){
        this.startflowflag=true;

    }
    handleStatusChange(event){
        const status=event.detail.status;
        if(status === 'FINISHED'){
            this.startflowflag=false;
        }
    }

    get flowinput(){

        return [
         {
            name:'opportunityid',
            type: 'String',
            value: this.recordId
        },
        {
            name: 'discountvalue',
            type: 'Number',
            value: this.discountpercent

        },
        {
            name: 'finalamount',
            type: 'Number',
            value: this.finalamount
        }

        ]
    }

}