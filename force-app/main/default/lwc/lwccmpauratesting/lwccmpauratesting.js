import { LightningElement, api } from 'lwc';

export default class Lwccmpauratesting extends LightningElement {

    @api title='These message form the lwc';

    handlesend(){

        const newevent=new CustomEvent('sendmessage',{
            detail:{
                "messaage":"Hello from the lwc"
            }
        });
        this.dispatchEvent(newevent);

    }

}