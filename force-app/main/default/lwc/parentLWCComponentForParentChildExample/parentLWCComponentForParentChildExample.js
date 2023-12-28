import { LightningElement, api } from 'lwc';

export default class ParentLWCComponentForParentChildExample extends LightningElement {
    tempVariable;
    constructor(){
        super();
        console.log('call recieved from constructor');
    }
    connectedCallback(){
        console.log('call recieved from connectedCallback');
    }
    renderedCallback(){
        console.log('call recieved from renderedCallback');
    }
    disconnectedCallback(){
        console.log('call recieved from disconnectedCallback');
    }
    handleInputChange(event) {
        console.log('key press');
        this.tempVariable = event.detail.value;
    }
    selectedNavHandler(event) {
        this.tempVariable = event.detail;
    }
}