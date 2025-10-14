import { LightningElement, wire } from 'lwc';
import propertyslist from '@salesforce/apex/propertysClass.propertyslist';
import { NavigationMixin } from 'lightning/navigation';

export default class Displayspropertysimages extends NavigationMixin(LightningElement) {

    listpropertystodisplay=[];
    viewType='List';


    connectedCallback()
    {
        propertyslist().then(result=>{
            this.listpropertystodisplay=result;
            console.log(this.listpropertystodisplay);
        }).catch(error =>{
            console(error.body.message);
        });

    }
    handlevalue(event)
    {
        this.viewType=event.target.value;
        console.log(this.viewType);

    }
    get options()
    {
        return[
            {label:'List',value:'List'},
            {label:'Picture',value:'pictures'}
        ]
    }
    get islistview()
    {
        return this.viewType ==='List';
    }
    get ispictureview()
    {
        return this.viewType ==='pictures';
    }
    handleid(event)
    {
        var proid=event.target.value;

        this[NavigationMixin.Navigate](
            {
                type: "standard__webPage",
                attributes: {
                    url: "https://ddm00000awnvduaj-dev-ed.develop.lightning.force.com/" + proid,
                },
            },
            true, // Replaces the current page in your browser history with the URL
        );

    }
}