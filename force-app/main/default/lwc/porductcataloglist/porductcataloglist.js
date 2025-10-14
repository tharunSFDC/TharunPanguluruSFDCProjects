import { LightningElement ,api, wire } from 'lwc';
import ProductsCatalogMethod from '@salesforce/apex/lwcproductclasscatalog.ProductsCatalogMethod';


export default class Porductcataloglist extends LightningElement {


    @api
    productsids;

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