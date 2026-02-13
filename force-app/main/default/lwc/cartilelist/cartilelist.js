import { LightningElement, api } from 'lwc';

export default class Cartilelist extends LightningElement {
    @api cars={};

    handleClick(){
        this.dispatchEvent(new CustomEvent('carselected',{
            detail:this.cars.Id
        }));
    }
}