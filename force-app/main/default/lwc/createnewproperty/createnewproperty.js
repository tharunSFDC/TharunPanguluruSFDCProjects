import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';


export default class Createnewproperty extends NavigationMixin(LightningElement) {


    name;
    state;
    city;
    country;
    price;
    image;
    room;
    bath;

    getdata(event) {
        var input = event.target.name;
        if (input == 'Name') {
            this.name = event.target.value;
        } else if (input == 'state') {
            this.state = event.target.value;
        } else if (input == 'city') {
            this.city = event.target.value;
        } else if (input == 'country') {
            this.country = event.target.value;
        } else if (input == 'price') {
            this.price = event.target.value;
        } else if (input == 'image') {
            this.image = event.target.value;
            // console.log(this.image);
        } else if (input == 'rooms') {
            this.room=event.target.value;
        }
        else if (input == 'bath') {
            this.bath=event.target.value;
        }
    }
    handlesave(event) {
        const fields = {
            Name: this.name,
            State__c: this.state,
            City__c: this.city,
            Country__c: this.country,
            Sales_Price__c: this.price,
            Thumbnail__c: this.image,
            Number_of_Rooms__c: this.room,
            Baths__c:this.bath
        };

        const recordInput = { apiName: 'Property__c', fields };

        createRecord(recordInput).then(result => {
            const event = new ShowToastEvent({
                title: 'Property Record Created Successfully',
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
            console.log(erros.body.message);
            const evt = new ShowToastEvent({
                title: 'Faild to create the Property Record',
                message: 'Some unexpected error',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);

        });


    }
    handlereset() {
        this.template.querySelectorAll('lightning-input ').forEach(element => {
            element.value = null;
        });

    }



}