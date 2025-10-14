import { LightningElement, wire } from 'lwc';
import fetchdata1 from '@salesforce/apex/oppdata.fetchdata1';

const columns=[
    {label:'Id',fieldName:'Id', type:'text', sortable:true},
    {label:'Name',fieldName:'Name', type:'text',sortable:true},
    {label:'StageName',fieldName:'StageName', type:'text',sortable:true},
    {label:'Amount',fieldName:'Amount', type:'Number',sortable:true}
]

export default class Serversidesortingcmp extends LightningElement {


    tableopp=[];
    opperror=[];
    columns=columns;
    sortbyfield='Name';
    sortdirection='asc';

    @wire(fetchdata1,{sortby:'$sortbyfield',sortdirection:'$sortdirection'}) wiredata({data, error})
    {
        if(data)
        {
            this.tableopp=data;
            console.log(this.tableopp);

        }else if(error)
        {
            this.opperror=data;
            console.log(this.opperror);

        }
    }



    handlesort(event)
    {
        this.sortbyfield=event.detail.fieldName;
        console.log(this.sortbyfield);
        this.sortdirection=event.detail.sortDirection;
        console.log(this.sortdirection);


    }





}