import { LightningElement, wire } from 'lwc';
import samplemlms from '@salesforce/messageChannel/tharunmessageing__c';
import { subscribe , unsubscribe,MessageContext, APPLICATION_SCOPE } from 'lightning/messageService';

export default class Lmscmpb extends LightningElement {
    messagereceived=null;
    newsub=null;

    @wire(MessageContext)context;

    connectedCallback()
    {
        this.Subscribemessage();
    }
    Subscribemessage()
    {
        this.newsub=subscribe(this.context,samplemlms,(message)=>{this.handleMessage(message)}, {scope:APPLICATION_SCOPE})
    }
    handleMessage(message)
    {
        this.messagereceived=message.lmsData.value? message.lmsData.value:'No Message have Received'
    }
    handleun()
    {
        unsubscribe(this.newsub)
        this.newsub=null;


    }
}