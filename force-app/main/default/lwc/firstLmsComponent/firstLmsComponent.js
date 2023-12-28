import { LightningElement } from 'lwc';
import getObjects from '@salesforce/apex/FirstLmsClass.getObjects';
import getFields from '@salesforce/apex/FirstLmsClass.getFields';
import getRecords from '@salesforce/apex/FirstLmsClass.getData';
import { publish,subscribe,unsubscribe,createMessageContext,releaseMessageContext } from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/MyMessageChannel__c";

export default class FirstLmsComponent extends LightningElement {

    context = createMessageContext();

    objectList;
    fieldList;
    SelectObject;
    SelectedFields;
    listOfFieldMap;
    spinner = true;
    fieldsDisplay = false;
    dataDisplay = false;
    data;

    UIData;

    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;

    pageSize = 5;

    start = 0;
    lastSize = 0;

    totalPage=1;
    currentPage=1;

    selectedRows=[];
    allSelectedRows = [];
    allSelectedData = [];
    connectedCallback(){

        getObjects().then(result=>{
            this.objectList = [];
            // for(let key in result) {
            //     if (result.hasOwnProperty(key)) { // Filtering the data in the loop
            //         this.objectList.push({label: result[key], value: key});
            //     }
            // }
            Object.keys(result).forEach(key=>{
                this.objectList.push({label: result[key], value: key});
            })
            this.objectList.sort((a,b)=>a.label.localeCompare(b.label));
            this.spinner = !this.spinner;
        }).catch(error=>{
            console.log(error);
        })
    }

    getFieldshandle(event){
        this.spinner = !this.spinner;
        this.fieldsDisplay = false;
        this.dataDisplay = false;
        this.SelectObject = event.detail.value;
        getFields({obj:this.SelectObject}).then(result =>{
            this.fieldList = [];
            Object.keys(result).forEach(ele=>{
                this.fieldList.push({label: result[ele].label, value:result[ele].value, type:result[ele].type, isSortable:result[ele].Sortable });
            }) 
            this.fieldList.sort((a,b)=>a.label.localeCompare(b.label));
            this.fieldsDisplay = true;
            this.spinner = !this.spinner;
        })
        .catch((error)=>{
            console.log(error);
        })
    }
    getSelectFields(event){
        this.spinner = !this.spinner;
        this.dataDisplay = false;
        this.listOfFieldMap = [];
        this.SelectedFields = event.detail.value;
        for (let value of this.SelectedFields) {
            const index = this.fieldList.findIndex(x => x.value === value );
            this.listOfFieldMap.push({label:this.fieldList[index].label, fieldName:this.fieldList[index].value, type:this.fieldList[index].type, sortable:this.fieldList[index].isSortable});
        }
        
        let query = 'SELECT '+this.SelectedFields+' FROM '+this.SelectObject;
        getRecords({query:query}).then((result)=>{
            this.data = result;
            this.dataSize();
            this.dataDisplay = true;
            this.spinner = !this.spinner;   
        })
        .catch((error)=>{
            console.log(error);
        })

        
    }


    onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.UIData];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.UIData = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }

    sortBy(field, reverse, primer) {
        const key = primer
            ? function (x) {
                  return primer(x[field]);
              }
            : function (x) {
                  return x[field];
              };

        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }
    get options() {
        return [
            { label: 5, value: 5 },
            { label: 10, value: 10 },
            { label: 15, value: 15 },
        ];
    }
    handleChange(event) {
        this.pageSize = event.detail.value;
        this.currentPage = 1;
        this.dataSize();
    }
    changeRecords(event){
        if(event.target.title == 'First'){
            this.currentPage = 1;
        }else if(event.target.title == 'Previous'){
            let page = this.currentPage-1;
            this.currentPage = page >= 1 ? page : this.currentPage;
        }else if(event.target.title == 'Next'){
            let page = this.currentPage+1;
            this.currentPage = page <= this.totalPage ? page : this.currentPage;
        }else if(event.target.title == 'Last'){
            this.currentPage = this.totalPage;
        }
        this.dataSize();
    }
    dataSize(){
        this.totalPage = Math.ceil(this.data.length/this.pageSize);
        if(this.currentPage == this.totalPage && this.currentPage == 1){
            this.start = 0;
            this.lastSize = this.data.length - 1;
        }else if(this.currentPage != this.totalPage){
            this.start = (this.currentPage - 1) * this.pageSize;
            this.lastSize = (this.currentPage * this.pageSize) - 1;
        }else if(this.currentPage == this.totalPage && this.currentPage != 1){
            this.start = (this.currentPage - 1) * this.pageSize;
            this.lastSize = this.data.length  - 1;
        }
        this.UIData = [];
        for(let i=this.start; i<= this.lastSize; i++){
            this.UIData.push(this.data[i]);
        }
        this.selectedRows = [...this.allSelectedRows];
    }
    getSelectedName(event){
        let updatedItemsSet = new Set();
        // List of selected items we maintain.
        let selectedItemsSet = new Set(this.selectedRows);
        // List of items currently loaded for the current view.
        let loadedItemsSet = new Set();

        this.UIData.map((ele) => {
            loadedItemsSet.add(ele.Id);
        });

        if (event.detail.selectedRows) {
            event.detail.selectedRows.map((ele) => {
                updatedItemsSet.add(ele.Id);
            });

            // Add any new items to the selectedRows list
            updatedItemsSet.forEach((id) => {
                if (!selectedItemsSet.has(id)) {
                    selectedItemsSet.add(id);
                }
            });

            loadedItemsSet.forEach((id) => {
                if (selectedItemsSet.has(id) && !updatedItemsSet.has(id)) {
                    // Remove any items that were unselected.
                    selectedItemsSet.delete(id);
                }
            });
        }
        this.selectedRows = [...selectedItemsSet];
        console.log(this.selectedRows);
        this.allSelectedRows = [...this.selectedRows];
    }
    getDatahandle(){
        this.allSelectedData = [];
        for(let key of this.selectedRows) {
            let index = this.data.findIndex(item => item.Id === key);
            this.allSelectedData.push(this.data[index]);
        }
        const message = {selected: this.selectedRows, data: this.allSelectedData, fields: this.listOfFieldMap, display: true, object: this.SelectObject};
        publish(this.context, SAMPLEMC, message);
    }
    
}