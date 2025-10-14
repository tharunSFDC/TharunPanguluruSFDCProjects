import { LightningElement, api } from 'lwc';

export default class Childcmp2 extends LightningElement {

    val=30;

    handlechange(event)
    {
        this.val=event.target.value;
    }

    @api resetmethod()
    {
        this.val=100;
    }
}