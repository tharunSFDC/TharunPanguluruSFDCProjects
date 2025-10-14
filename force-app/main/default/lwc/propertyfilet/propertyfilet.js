import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import FILTERSCHANGEMC from '@salesforce/messageChannel/FiltersChange__c';

const DELAY = 350;
const MAX_PRICE = 1200000;

export default class PropertyFilter extends LightningElement {
    city = '';
    salesprice = MAX_PRICE;
    numberofrooms = 0;
    minBathrooms = 0;

    @wire(MessageContext)
    messageContext;

    handleReset() {
        this.city = '';
        this.salesprice = 0;
        this.numberofrooms = 0;
        this.minBathrooms = 0;
        this.fireChangeEvent();
    }

    handleSearchKeyChange(event) {
        this.city = event.detail.value;
        this.fireChangeEvent();
    }

    handleMaxPriceChange(event) {
        this.salesprice = event.detail.value;
        this.fireChangeEvent();
    }

    handleMinBedroomsChange(event) {
        this.numberofrooms = event.detail.value;
        this.fireChangeEvent();
    }

    handleMinBathroomsChange(event) {
        this.minBathrooms = event.detail.value;
        this.fireChangeEvent();
    }

    fireChangeEvent() {
        // Debouncing this method: Do not actually fire the event as long as this function is
        // being called within a delay of DELAY. This is to avoid a very large number of Apex
        // method calls in components listening to this event.
        window.clearTimeout(this.delayTimeout);
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.delayTimeout = setTimeout(() => {
            const filters = {
                city: this.city,
                salesprice: this.salesprice,
                numberofrooms: this.numberofrooms,
                minBathrooms: this.minBathrooms
            };
            publish(this.messageContext, FILTERSCHANGEMC, filters);
        }, DELAY);
    }
}