import { LightningElement } from 'lwc';
import tmep1 from './tmep1.html';
import temp2 from './temp2.html';
import rendernotahookinlwc from './rendernotahookinlwc.html';

export default class Rendernotahookinlwc extends LightningElement {

    isselected=null;

    render()
    {
        return this.isselected === 'Signup' ? temp2 :
               this.isselected === 'Signin' ? tmep1 :
               rendernotahookinlwc

    }
    handlesignup(event)
    {
        this.isselected=event.target.label;

    }
    handlescu(event)
    {
        console.log('Thes user is Sccuessfully logined');
    }

}