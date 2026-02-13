import { LightningElement, wire } from 'lwc';
import {getObjectInfo, getPicklistValues} from 'lightning/uiObjectInfoApi';
import CAR_OBJECT from '@salesforce/schema/Car__c';
import CATEGORY_FIELD from '@salesforce/schema/Car__c.Category__c';
import MAKE_FIELD from '@salesforce/schema/Car__c.Make__c';

// lightning Message Services Channel
import CARS_FILTERED_MESSAGE from '@salesforce/messageChannel/carsFiltered__c';
import {publish, MessageContext} from 'lightning/messageService';

const CATEGORY_ERROR='An error occurred while loading car categories. Please try again later.';
const MAKE_ERROR='An error occurred while loading car makes. Please try again later.';
export default class CarFilter extends LightningElement {
    timer;
    filter={
        searchkey:'',
        maxPrice:999999
    }

    @wire(MessageContext) messagecontext;
    CATEGORY_ERROR=CATEGORY_ERROR;
    MAKE_ERROR=MAKE_ERROR;
    @wire(getObjectInfo,{objectApiName:CAR_OBJECT})
    carObjectInfo;
    @wire(getPicklistValues,{
        recordTypeId:'$carObjectInfo.data.defaultRecordTypeId',
        fieldApiName:CATEGORY_FIELD,
    }) categories
    @wire(getPicklistValues,{
        recordTypeId:'$carObjectInfo.data.defaultRecordTypeId',
        fieldApiName:MAKE_FIELD,
    }) maketype
    handleSearchKey(event){
        this.filter={...this.filter,"searchkey":event.target.value};
        this.sandDatatoCarList();
    }
    handlePriceChange(event){
        this.filter={...this.filter,"maxPrice":event.target.value};
        this.sandDatatoCarList();
    }
    handlecheckbox(event){
        if(!this.filter.categories){
            const categories = this.categories.data.values.map(item=>item.value);
            const maketype = this.maketype.data.values.map(item=>item.value);
            this.filter= {...this.filter, categories, maketype};
        }
        const{name, value} = event.target.dataset;
        console.log('name', name);
        console.log('value', value);
       if(event.target.checked){
            if(!this.filter[name].includes(value)){
                this.filter[name] = [...this.filter[name], value]
            }
        }else{
            this.filter[name] = this.filter[name].filter(item=>item !==value);
        } 

       this.sandDatatoCarList();
    }
    sandDatatoCarList(){
        window.clearTimeout(this.timer);
        this.timer = window.setTimeout(()=>{
            publish(this.messagecontext,CARS_FILTERED_MESSAGE,{filters:this.filter});

        },400)
        
    }
}