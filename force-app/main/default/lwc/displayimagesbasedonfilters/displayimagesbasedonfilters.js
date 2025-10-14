import { LightningElement, wire } from 'lwc';
import {
    subscribe,
    unsubscribe,
    MessageContext
} from 'lightning/messageService';
import FILTERSCHANGEMC from '@salesforce/messageChannel/FiltersChange__c';
import propertyfilterlist from '@salesforce/apex/propertysClass.propertyfilterlist';
import { NavigationMixin } from 'lightning/navigation';

export default class Displayimagesbasedonfilters extends NavigationMixin(LightningElement) {


    city = '';
    salesprice = 9999999;
    numberofrooms = 0;
    minBathrooms = 0;

    @wire(MessageContext) messageContext;
    
    @wire(propertyfilterlist,{
        city:'$city',
        salesprice:'$salesprice',
        numberofrooms:'$numberofrooms',
        minBathrooms:'$minBathrooms'


    })properties;

    connectedCallback() {
        this.subscription = subscribe(
            this.messageContext,
            FILTERSCHANGEMC,
            (message) => {
                this.handleFilterChange(message);
            }
        );
    }
    disconnectedCallback() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
    handleFilterChange(filters) {
        this.city = filters.city;
        console.log(this.city);
        this.salesprice = filters.salesprice;
        this.numberofrooms = filters.numberofrooms;
        this.minBathrooms = filters.minBathrooms;
    }
    handleid(event)
    {
        var proid=event.target.value;
        console.log(proid);
        this[NavigationMixin.Navigate](
            {
                type: "standard__webPage",
                attributes: {
                    url: "https://ddm00000awnvduaj-dev-ed.develop.lightning.force.com/" + proid,
                },
            },
            true, // Replaces the current page in your browser history with the URL
        );
    }
}