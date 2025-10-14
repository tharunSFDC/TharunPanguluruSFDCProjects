import { LightningElement, api } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class Deleteproducts extends NavigationMixin(LightningElement) {

    @api
    recordId;

    handledelete() {
        deleteRecord(this.recordId).then(res => {

            //alert('Product Record Deleted Successfully');
            const event = new ShowToastEvent({
                title: 'Product Record Deleted Successfully',
                message: 'Deleted',
                variant: 'warning',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);

        }).catch(error => {
            const event = new ShowToastEvent({
                title: 'Product Record not Deleted Successfully',
                message: 'Not Deleted',
                variant: 'warning',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);


        });
        this[NavigationMixin.Navigate](
            {
                type: "standard__webPage",
                attributes: {
                    url: "https://ddm00000awnvduaj-dev-ed.develop.lightning.force.com/lightning/n/Product_Catalog",
                },
            },
            true, // Replaces the current page in your browser history with the URL
        );

    }



}