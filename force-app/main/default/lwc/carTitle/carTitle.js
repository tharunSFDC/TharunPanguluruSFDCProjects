import { LightningElement, wire } from 'lwc';
import carmethod from '@salesforce/apex/carControllerClass.carmethod';

// lightning Message Services Channel
import CARS_FILTERED_MESSAGE from '@salesforce/messageChannel/carsFiltered__c';
import CAR_SELELCTED_MESSAGE from '@salesforce/messageChannel/carselected__c';
import {publish, unsubscribe,subscribe, MessageContext} from 'lightning/messageService';

export default class CarTitle extends LightningElement {
    cars=[];
    errros;
    filters={};
    carFilterSubscription;
    @wire(MessageContext) messagecontext;
    @wire(carmethod, {filtershere: '$filters'})
    carmethods({data,error}){
        if(data){
            this.cars=data;
            console.log(this.cars);
        }else if(error){
            this.errros=error;
            console.log(this.errros);
        }
    }
    connectedCallback(){
        this.carFilterSubscription=subscribe(this.messagecontext,CARS_FILTERED_MESSAGE,(message)=>this.handleFilterChanges(message));

    }
    handleFilterChanges(messsage){
        this.filters={...messsage.filters};
        console.log(messsage.filters);
    }
    handlecarselected(event){
       // console.log('Selected Card id:', event.detail);
        publish(this.messagecontext,CAR_SELELCTED_MESSAGE,{carselected:event.detail});
    }
    disconnectedCallback(){
        unsubscribe(this.carFilterSubscription);
    }
}