import { LightningElement } from 'lwc';
import getaccounts from '@salesforce/apex/accounttesting.getaccounts';

const columns =[
    {label:'Id', fieldName:'Id'},
    {label:'Name',fieldName:'Name'}
];

export default class Displayaccountsdatatable extends LightningElement {

    accounts=[];
    columns=columns;
    rowsize=10;
    rowoffset=0;
    enableinfiniteloading=false;

    connectedCallback()
    {
        this.loaddata();
    }
    async loaddata()
    {
        try{
            const response=await getaccounts({limitsize:this.rowsize,offset:this.rowoffset});
            if(response)
            {
                this.accounts=[...this.accounts, ...response];
                this.enableinfiniteloading=(response.length ==this.rowsize || response.length !=0);
                console.log(this.enableinfiniteloading);
            }
        }
        catch(error){
            console.log(JSON.stringify(error.body.message))

        }
    }

    async onloadmorehandler(event){
        let target=event.target;
        target.isLoading=true;

        this.rowoffset=this.rowoffset+this.rowsize;
        await this.loaddata();

        target.isLoading=false;

    }
}