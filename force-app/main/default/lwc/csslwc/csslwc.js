import { LightningElement } from 'lwc';

export default class Csslwc extends LightningElement {


    per=10;

    handledata(event)
    {
        this.per=event.target.value;
    }

    get handlewidth(){

        return `width:${this.per}%`;

    }

}