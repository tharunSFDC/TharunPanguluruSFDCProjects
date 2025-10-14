import { LightningElement, api, wire } from 'lwc';
import ProductsCatalogMethod from '@salesforce/apex/lwcproductclasscatalog.ProductsUpdate';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import PRODUCT_NAME from '@salesforce/schema/Product2.Name';
import PRO_CODE from '@salesforce/schema/Product2.ProductCode';
import PRODUCT_FAMILY from '@salesforce/schema/Product2.Family';
import PROCUT_ACTIVE from '@salesforce/schema/Pricebook2.IsActive';
import PRODUCT_COST from '@salesforce/schema/Product2.Product_Cost__c';
import PRODUCT_DESCRIPTION from '@salesforce/schema/Product2.Description';
import PRO_URL from '@salesforce/schema/Product2.Product_image__c';
import PRO_id from '@salesforce/schema/Product2.Id';

export default class Editproductsdetails extends LightningElement {

    @api
    recordId;

    prodcutsName = null;
    prodcutsIsActive = null;
    prodcutsProductCode = null;
    prodcutsProductFamily = null;
    prodcutsProductCost = null;
    prodcutsurl = null;
    prodcutdes = null;

    alldata = null;


    @wire(ProductsCatalogMethod, { poids: '$recordId' })
    productslist({ data, error }) {
        if (data) {
            this.prodcutsName = data.Name;
            this.prodcutsProductCode = data.ProductCode;
            this.prodcutsProductFamily = data.Family;
            this.prodcutsIsActive = data.IsActive;
            this.prodcutsProductCost = data.Product_Cost__c;
            this.prodcutsurl = data.Product_image__c;
            this.prodcutdes = data.Description;
            this.alldata = data;
            console.log(this.alldata);
            console.log(this.prodcutsName);
        } else if (error) {
            this.productserros = error;
            console.log(this.productserros);
        }
    }



    getdata(event) {
        var input = event.target.name;
        if (input == 'name') {
            this.prodcutsName = event.target.value;

        } else if (input == 'code') {
            this.prodcutsProductCode = event.target.value;
        } else if (input == 'family') {
            this.prodcutsProductFamily = event.target.value;
        } else if (input == 'active') {
            this.prodcutsIsActive = event.target.checked;
        } else if (input == 'cost') {
            this.prodcutsProductCost = event.target.value;
        } else if (input == 'des') {
            this.prodcutdes = event.target.value;
        } else if (input == 'image') {
            this.prodcutsurl = event.target.value;
        }
    }
     handleSave(event) {

        const fields = {};

        fields[PRO_id.fieldApiName] = this.recordId;
        fields[PRODUCT_NAME.fieldApiName] = this.prodcutsName;
        fields[PRO_CODE.fieldApiName] = this.prodcutsProductCode;
        fields[PRODUCT_FAMILY.fieldApiName] = this.prodcutsProductFamily;
        fields[PROCUT_ACTIVE.fieldApiName] = this.prodcutsIsActive;
        fields[PRODUCT_COST.fieldApiName] = this.prodcutsProductCost;
        fields[PRODUCT_DESCRIPTION.fieldApiName] = this.prodcutdes;
        fields[PRO_URL.fieldApiName] = this.prodcutsurl;

        const recordInput = { fields };

        updateRecord(recordInput).then(res => {
            const event = new ShowToastEvent({
                title: 'Product Record Updated Successfully',
                message: 'updated',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
        }).catch(errors => {
            const event = new ShowToastEvent({
                title: 'Product Record Not Updated Successfully',
                message: 'notupdate',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
            console.log(errors.body.message);
        });
        //Alert has been closed

    }
}