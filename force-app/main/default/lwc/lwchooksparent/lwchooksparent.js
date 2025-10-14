import { LightningElement } from 'lwc';

export default class Lwchooksparent extends LightningElement {


ischild=false;
    constructor(){
        super();
        console.log('These is Parent Constructor');
    }
    connectedCallback()
    {
        console.log('These is Parent connectedCallback');
    }
    renderedCallback()
    {
        console.log('These is Parent renderedCallback');
    }
    errorCallback(error,stack)
    {
        alert(error.message);
        alert(stack);
    }
    name=null;
    valueup(event)
    {
        this.name=event.target.value;

    }
    handlechild()
    {
        this.ischild= !this.ischild;
    }
}