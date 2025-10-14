import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Toastmessagetesting extends LightningElement {
    handleone() {
        this.showTast("Success", "{0} Contact Created Succesfully {1}", "success")
    }
    handletwo() {
        this.showTast("Success", "Contact not Created ", "error")

    }
    handlethree() {
        this.showTast("Success", "Contact not created haveing problem", "warning")

    }
    handlefour() {
        this.showTast("Success", "Please fill the Contact Details", "info")

    }

    showTast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant,
            messageData:[
                'Salesforce',{
                    url:'https://www.youtube.com/',
                    label:'Click Here'
                }
            ]
        })
        this.dispatchEvent(event);
    }
}