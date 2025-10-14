import { LightningElement } from 'lwc';

export default class Spreadopertor extends LightningElement {

    //array

    newarray=['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33'];
    obj={
        name:'Tharun Panguluru',
        age:'23',
        phone:'91788888888',
        city:'Hyderabad',
        address:'Chennai',
        country:'India',
        state:'Telangana',
        zipcode:'500081'
    }
    Spreadopertortesting='Salesforce lwc testing';
    connectedCallback()
    {
       // console.log(this.newarray[0]);
        //console.log(this.newarray[4]);
        //this.newarray.push('400');
        //console.log(this.newarray[33]);

        //console.log(this.obj.name);
        //console.log(this.obj['state']);
        //this.obj.hobbies='cricker';
        //console.log(this.obj.hobbies);

        let newspere=[...this.Spreadopertortesting];

        let obj1={name:"salesforce",age:23}
        let obj2={name:"facebook",age:26,count:56}
        let obj3={...obj1, ...obj2};
        console.log(obj3);

    }

}