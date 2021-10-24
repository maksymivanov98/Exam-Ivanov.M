import { LightningElement, track, api, wire } from 'lwc';
import getSensorList from '@salesforce/apex/SensorController.getSensorList';
import getSelectedSensor from '@salesforce/apex/SensorController.getSelectedSensor';
import { NavigationMixin } from "lightning/navigation";

const actionsSensorEvent = [
    { label: 'Edit', name: 'Edit', iconName: 'utility:edit' },
];
const actionsSensor = [
    { label: 'Edit', name: 'Edit', iconName: 'utility:edit' },
    { label: 'View Events', name: 'Viewevents' },
];
const columnsSensor = [
    { label: 'Name', fieldName: 'Name'},
    { label: 'Max Vector Length', fieldName: 'Max_Vectors_Length__c'},
    {
        label: 'Actions',
        type: 'action',
        typeAttributes: { rowActions: actionsSensor, menuAlignment: 'right' },
    }
];

const columnsSensorEvent = [
    { label: 'Name', fieldName: 'Name'},
    { label: 'Modulus Vector Length', fieldName: 'Modulus_Vector_Length__c'},
    { label: 'X', fieldName: 'X__c'},
    { label: 'Y', fieldName: 'Y__c'},
    { label: 'Z', fieldName: 'Z__c'},
    {
        label: 'Actions',
        type: 'action',
        typeAttributes: { rowActions: actionsSensorEvent, menuAlignment: 'right' },
    }
];
export default class SensorComponent extends NavigationMixin(LightningElement) {

    handleRowAction(event) {
        var action = event.detail.action;
        var row = event.detail.row.Id;
        switch (action.name) {
            case 'Edit':
                this[NavigationMixin.Navigate]({
                    type: "standard__recordPage",
                    attributes: {
                        recordId: event.detail.row.Id,
                        actionName: "edit"
                    }
                    
                });
                  //Write Code IF Edit
                break;
            case 'Viewevents':
                getSelectedSensor({idSelected : row })
            .then(result => {
                this.SensorList = result;
                this.columns = columnsSensorEvent;
            })
            .catch(error => {
                this.recordId = null;
            });
                //Write Code IF Viewchild
      
                break;
        }
    }

    @track SensorList;
    columns = columnsSensor;
    @api recordId;
    @wire(getSensorList)



    viewRecord() { 
        getSensorList()
            .then(result => {
                this.SensorList = result;
                this.recordId = null; 
                this.columns = columnsSensor;
            })
            .catch(error => {
                this.error = error;
                console.log(error);
            });
            
    }

}