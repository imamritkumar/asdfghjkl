import { LightningElement, api } from 'lwc';

export default class ChildLWCComponentForParentChildExample extends LightningElement {
    @api tempVarible;
    constructor(){
        super();
        console.log('call recieved from child constructor');
    }
    connectedCallback(){
        console.log('call recieved from child connectedCallback');
    }
    renderedCallback(){
        console.log('call recieved from child renderedCallback');
    }
    disconnectedCallback(){
        console.log('call recieved from child disconnectedCallback');
    }
    handleNavSelection(event) {
        this.tempVarible = event.detail.value;
        event.preventDefault();
        const selectEvent = new CustomEvent('selection', { detail: this.tempVarible });
        // Fire the custom event
        this.dispatchEvent(selectEvent);
    }
}