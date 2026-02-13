import { LightningElement, api, wire } from 'lwc';
import getsmilarcars from '@salesforce/apex/carControllerClass.getSimilarCars';
import {getRecord} from 'lightning/uiRecordApi';
import MAKE_FIELD from '@salesforce/schema/Car__c.Make__c';
import { NavigationMixin } from "lightning/navigation";
export default class Similarcars extends NavigationMixin(LightningElement) {
    @api recordId;
    @api objectApiName;
    similarcars;

    @wire(getRecord,{recordId:'$recordId',fields:[MAKE_FIELD]}) cars;

    fetchSimilarCars(){
        getsmilarcars({
            carId:this.recordId,
            makeType:this.cars.data.fields.Make__c.value
        }).then(result=>{
            this.similarcars=result;

        }).catch(error=>{
            console.log(error);
        })
    }
    handleviewdetails(event){
        this[NavigationMixin.Navigate]({
            type:'standard__recordPage',
            attributes:{
                recordId:event.target.dataset.id,
                objectApiName:this.objectApiName,
                actionName:'view'
            }
        })
    }
}