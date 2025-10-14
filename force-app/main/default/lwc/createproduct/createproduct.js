import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class Createproduct extends NavigationMixin(LightningElement) {


    isactive = true;
    productname = null;
    productcode = null;
    productfamily = null;
    isactive = null;
    productcost = null;
    productdescription = null;
    imageurl = null;

    getdata(event) {
        var input = event.target.name;
        if (input == 'name') {
            this.productname = event.target.value;
        } else if (input == 'code') {
            this.productcode = event.target.value;
        } else if (input == 'family') {
            this.productfamily = event.target.value;

        } else if (input == 'active') {
            this.isactive = event.target.checked;
        } else if (input == 'cost') {
            this.productcost = event.target.value;
            console.log(this.productactive);
        } else if (input == 'des') {
            this.productdescription = event.target.value;
        } else if (input == 'image') {
            this.imageurl = event.target.value;
        }
    }
    handlereset()
    {
        this.template.querySelectorAll('lightning-input').forEach(element =>{
            if(element.type === 'checkbox')
            {
                element.checked = false;
                this.isactive=false;
            }else{
                element.value = null;
                this.productname=null;
                this.productcode=null;
                this.productfamily=null;
                this.productcost=null;
                this.productdescription=null;
                this.imageurl=null;
            }
        });
    }

    handleSave(event) {
        const fields = {
            'Name': this.productname,
            'ProductCode': this.productcode,
            'Family': this.productfamily,
            'IsActive': this.isactive,
            'Description': this.productdescription,
            'Product_Cost__c': this.productcost,
            'Product_image__c': this.imageurl
        };

        const recordInput = { apiName: 'Product2', fields };

        createRecord(recordInput).then(result => {
            const event = new ShowToastEvent({
                title: 'Product Record Created Successfully',
                message: result.Id,
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
            this[NavigationMixin.Navigate](
                {
                    type: "standard__webPage",
                    attributes: {
                        url: "https://ddm00000awnvduaj-dev-ed.develop.lightning.force.com/" + result.id,
                    },
                },
                true, // Replaces the current page in your browser history with the URL
            );
        }).catch(erros => {
            const evt = new ShowToastEvent({
                title: 'Faild to create Product Record',
                message: erros.body.message,
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);

        });
    }

}