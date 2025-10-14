import { LightningElement, track } from 'lwc';

export default class Lwc1trop extends LightningElement {


    name='tharun Panguluru';
     obj={
        name:'new Tharun Panguluru',
        age:'23',
        skill:'Salesforce'
    }
    userlist=['Tharun','poorna','praveen'];
    num1=10;
    num2=20;

    get userfunction()
    {
        return this.userlist[0];
    }

    get addtionoftow()
    {
        return this.num1+this.num2;
    }
    arr=[1,2,3,4,5,5];
    handlecahge(event)
    {
       // this.name=event.target.value;
        this.obj={... this.obj,'name':event.target.value};


    }
}