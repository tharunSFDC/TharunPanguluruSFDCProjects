import { LightningElement , wire} from 'lwc';
import fetchdata from '@salesforce/apex/oppdata.fetchdata';

const columns=[
    {label:'Id',fieldName:'Id', type:'text', sortable:true},
    {label:'Name',fieldName:'Name', type:'text',sortable:true},
    {label:'StageName',fieldName:'StageName', type:'text',sortable:true},
    {label:'Amount',fieldName:'Amount', type:'Number',sortable:true}
]

export default class Clientsidecortingcmp extends LightningElement {


    tableoppo=[];
    oppeerror=[];
    sortedBy;
    sorteddirection;

    columns=columns;


    @wire(fetchdata) wiredata({data,error}){
        if(data){
            this.tableoppo=data;

        }else if(error)
        {
            this.oppeerror=error;

        }
    }

    handlesortevent(event)
    {
        const {fieldName, sortDirection}=event.detail;
        this.sortedBy=fieldName;
        this.sorteddirection=sortDirection;
        this.sortdata(fieldName,sortDirection);

    }
    sortdata(filed,direction)
    {
        let sortresult=[...this.tableoppo];

        sortresult.sort((a,b)=>{
             let valueA=a[filed];
             let valueB=b[filed];

             if(typeof valueA ==='string' && typeof valueB ==='string')
             {
                valueA=valueA.toLowerCase();
                valueB=valueB.toLowerCase();
             }
             if(valueA > valueB)
             {
                return direction ==='asc' ? 1: -1;
             }
             else if(valueA < valueB)
             {
                 return direction ==='asc'? -1 : 1;
             }
             return 0;
        })
        this.tableoppo=sortresult;
    }
}