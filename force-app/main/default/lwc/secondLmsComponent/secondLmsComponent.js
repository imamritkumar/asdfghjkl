import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { publish,subscribe, unsubscribe, createMessageContext, releaseMessageContext } from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/MyMessageChannel__c";

const actions = [
    { label: 'Show details', name: 'show_details' },
    { label: 'Delete', name: 'delete' },
    { label: 'Edit', name: 'edit' },
];

export default class SecondLmsComponent extends NavigationMixin(LightningElement) {
    context = createMessageContext();
    subscription = null;
    selectedData = [];
    realDate;
    fields;
    object;
    dataDisplay = false;
    connectedCallback(){
        this.subscription = null;
        this.subscription = subscribe(this.context, SAMPLEMC, (message) => {
            this.fields = [];
            this.realDate = [];
            // this.fields = message.fields;
            for(let fld of message.fields){
                this.fields.push(fld);
            }
            if(this.fields.length > 0){
                this.fields.push({type:'action', typeAttributes: { rowActions: actions } });
            }
            this.realDate = message.data;
            this.object = message.object;
            this.selectedData = message.selected;
            this.dataDisplay = message.display;
        });
    }

    handleRowAction(event){
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        const id = event.detail.row.Id;
        switch (actionName) {
            // case 'delete':
            //     this.deleteRow(row);
            //     break;
            case 'show_details':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: id,
                        actionName: 'view',
                    },
                })
                break;
            case 'edit':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: id,
                        objectApiName: this.object,
                        actionName: 'edit'
                    }
                });
                break;
            default:
        }
    }
    deleteRow(row) {
        const { id } = row;
        const index = this.findRowIndexById(id);
        if (index !== -1) {
            this.realDate = this.realDate.slice(0, index).concat(this.realDate.slice(index + 1));
        }
    }
    findRowIndexById(id) {
        let ret = -1;
        this.data.some((row, index) => {
            if (row.id === id) {
                ret = index;
                return true;
            }
            return false;
        });
        return ret;
    }
}