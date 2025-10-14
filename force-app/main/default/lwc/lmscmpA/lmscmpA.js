import { LightningElement, wire } from 'lwc';
import samplemlms from '@salesforce/messageChannel/tharunmessageing__c';
import { publish,MessageContext } from 'lightning/messageService';

export default class LmscmpA extends LightningElement {

    payload=null;

    @wire(MessageContext) context;

    handlepub(event)
    {
        this.payload=event.target.value;
    }
    handleSave()
    {
        const message={
            lmsData:{
                value:this.payload
            }

        }
        publish(this.context,samplemlms,message)
    }

}