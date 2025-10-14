import { LightningElement, wire } from 'lwc';
import ProductsCatalogMethod from '@salesforce/apex/lwcproductclasscatalog.ProductsCatalogMethod';

export default class Imagetestingcmp1 extends LightningElement {
    
    listofproducts=null;
    listoferrors=null;
    idfromtable=null;
    pageurl='https://ddm00000awnvduaj-dev-ed.develop.lightning.force.com/';
    mainurl=null;


    @wire(ProductsCatalogMethod) products({data,erros})
    {
        if(data)
        {
            this.listofproducts=data;

        }else if(erros)
        {
            this.listoferrors=erros;
        }

    }
    handleview(event)
    {
        this.idfromtable=event.target.value;
        this.pageurl =this.pageurl+this.idfromtable;
        this.mainurl=this.pageurl;
        console.log(this.mainurl);

    }
}