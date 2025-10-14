import { LightningElement, api } from 'lwc';

export default class Childgetandsetter extends LightningElement {

    usetdetails=null;

    @api get detail()
    {
        return this.usetdetails;

    }
    set detail(data)
    {
        let newage=data.age+2;
        let lastname=data.name+' '+'Panguluru';
        this.usetdetails={...data, age:newage,name:lastname,"dist":"Chittoor"}
    }
}