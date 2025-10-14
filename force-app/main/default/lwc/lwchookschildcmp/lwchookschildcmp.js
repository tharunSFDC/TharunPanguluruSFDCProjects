import { LightningElement } from 'lwc';

export default class Lwchookschildcmp extends LightningElement {

    constructor(){
        super();
        console.log('These is Child Constructor');
    }
    connectedCallback(){
        console.log('These is Child connectedCallback');
        throw new Error('these is error message');
    }
    renderedCallback(){
        console.log('These is child renderedCallback');
    }
    disconnectedCallback()
    {
        alert('The child Cmp is Removed from the Dom and disconnectedCallback Called');
    }
}