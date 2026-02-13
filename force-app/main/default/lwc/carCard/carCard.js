import { LightningElement, wire } from 'lwc';
//lightning Message Services Channel
import CAR_SELELCTED_MESSAGE from '@salesforce/messageChannel/carselected__c';
import { unsubscribe, subscribe, MessageContext } from 'lightning/messageService';
//car fields import
import CAR_OBJECT from '@salesforce/schema/Car__c';
import NAME_FIELD from '@salesforce/schema/Car__c.Name';
import PICTURE_URL_FIELD from '@salesforce/schema/Car__c.Picture_URL__c';
import CATEGORY_FIELD from '@salesforce/schema/Car__c.Category__c';
import MAKE_FIELD from '@salesforce/schema/Car__c.Make__c';
import MRP_FIELD from '@salesforce/schema/Car__c.MRP__c';
import FUEL_FIELD from '@salesforce/schema/Car__c.Fuel_Type__c';
import SEATS_FIELD from '@salesforce/schema/Car__c.Number_of_Seats__c';
import CONTROL_FIELD from '@salesforce/schema/Car__c.Control__c';
import { NavigationMixin } from "lightning/navigation";

import { getFieldValue } from 'lightning/uiRecordApi';
export default class CarCard extends NavigationMixin(LightningElement) {

    // exposing fields to make them available in HTML
    categoryfield = CATEGORY_FIELD;
    makefield = MAKE_FIELD;
    mrpfield = MRP_FIELD;
    fuelfield = FUEL_FIELD;
    seatsfield = SEATS_FIELD;
    controlfield = CONTROL_FIELD;
    recordId;
    // car fields displayed with specific format
    carName;
    carPictureUrl;
    unsubscribecarselected;

    @wire(MessageContext) messagecontext;
    handlerecordloaded(event) {
        const { records } = event.detail;
        const recorddata = records[this.recordId];
        this.carName = getFieldValue(recorddata, NAME_FIELD);
        this.carPictureUrl = getFieldValue(recorddata, PICTURE_URL_FIELD);
    }
    connectedCallback() {
        this.handlesucbcription();
    }
    handlesucbcription() {
        this.unsubscribecarselected = subscribe(this.messagecontext, CAR_SELELCTED_MESSAGE, (message) => this.handlerecordid(message));
    }
    handlerecordid(message) {
        this.recordId = message.carselected;
        console.log('recordId', this.recordId);
    }
    disconnectedCallback() {
        unsubscribe(this.unsubscribecarselected);
    }
    handleonclick() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: CAR_OBJECT.objectApiName,
                actionName: 'view'
            }
        })

    }
}