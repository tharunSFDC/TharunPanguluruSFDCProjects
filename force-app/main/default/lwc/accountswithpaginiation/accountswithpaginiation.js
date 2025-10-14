import { LightningElement } from 'lwc';
import getaccounts from '@salesforce/apex/accounttesting.getaccounts';
import totalaccountcount from '@salesforce/apex/accounttesting.totalaccountcount';

columns=[
    {label:'Id',filedName:'Id'},
    {label:'AccountName', filedName:'Name'}
];

export default class Accountswithpaginiation extends LightningElement {
    columns=columns;
    activeaccounts=[];
    totalaccounts=0;
    currentpage=1;
    pagesize=6;
    totalpages=0;

    connectedCallback(){
        this.fetchaccounts();
        this.fetchaccountscount();
    }
    fetchaccounts()
    {
        getaccounts({
            pagesize:this.pagesize,
            pagenumber:this.currentpage
        }).then(data =>{
            this.activeaccounts=data;
        }).catch(error =>{
            console.log(error.body.message);
        });

    }
    fetchaccountscount()
    {
        totalaccountcount().then(data =>{
            this.totalaccounts=data;
            this.totalpages=Math.ceil(this.totalaccounts/this.pagesize);
        }).catch(error =>{
            console.log(error.body.message);
        })
    }
    handlepervious()
    {
        if(this.currentpage >1)
        {
            this.currentpage--;
            this.fetchaccounts();
        }

    }
    handlenext()
    {
        if(this.currentpage < this.totalpages)
        {
            this.currentpage++;
            this.fetchaccounts();
        }

    }
}