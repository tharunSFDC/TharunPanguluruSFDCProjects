import { LightningElement, api } from 'lwc';

export default class Parentcmp1 extends LightningElement {

    @api passtochild=[
        {src:"https://www.lightningdesignsystem.com/assets/images/carousel/carousel-01.jpg",header:"first Card",description:"First card description"},
        {src:"https://www.lightningdesignsystem.com/assets/images/carousel/carousel-02.jpg",header:"Second Card",description:"Second card description"},
        {src:"https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg",header:"Third Card",description:"Third card description"}

    ]

    hanlesave()
    {
        this.template.querySelector('c-childcmp2').resetmethod();
    }

}