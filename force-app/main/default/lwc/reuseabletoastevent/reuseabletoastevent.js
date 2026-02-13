import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Reuseabletoastevent extends LightningElement {
    @api toastTitle;
    @api toastMessage;
    @api toastVariant;
    @api toastMode;

    @api invoke(){
        this.dispatchEvent(new ShowToastEvent({
            title: this.toastTitle,
            message: this.toastMessage,
            variant: this.toastVariant,
            mode: this.toastMode
        }));
    }
}