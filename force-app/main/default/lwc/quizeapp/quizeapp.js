import { LightningElement } from 'lwc';

export default class Quizeapp extends LightningElement {
    selected=null;
    correctanswers=null;
    ishow=null;
    myquestion=[

        {
            id:"Question1",
            question:"Which one of the following is not a template loop",
            answers:{
                a:"for:each",
                b:"iterator",
                c:"map loop"
            },
            correcranswer:"c"
        },
        {
            id:"Question2",
            question:"Which one of the following is invlaid file in LWC",
            answers:{
                a:"js",
                b:"css",
                c:"apex"
            },
            correcranswer:"c"

        },
        {
            id:"Question3",
            question:"Which one of the following is not a template loop",
            answers:{
                a:"for:each",
                b:"iterator",
                c:"map loop"
            },
            correcranswer:"c"
        }
    ];

    get isstyles()
    {
        return `slds-text-heading_large ${this.myquestion.length === this.correctanswers ? 'slds-text-color_success':'slds-text-color_error'}`
    }
    

    get allnotselected()
    {
        return (Object.keys(this.selected).length === this.myquestion.length)
    }

    handledata(event)
    {
        const {name, value} =event.target;

        this.selected={...this.selected,[name]:value}

    }
    handleSave(event)
    {
        event.preventDefault();
        let correct =this.myquestion.filter(item =>this.selected[item.id] === item.correcranswer)
        this.correctanswers=correct.length;
        this.ishow=true;
        console.log(this.correctanswers);


    }
    handlerest()
    {
        this.correctanswers=null;
        this.selected=null;
        this.ishow=false;

    }


}