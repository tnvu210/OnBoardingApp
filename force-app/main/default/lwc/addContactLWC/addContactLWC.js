import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import EMPLOYEENUMBER_FIELD from '@salesforce/schema/Contact.Employee_Number__c';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import LOCATION_FIELD from '@salesforce/schema/Contact.Location__c';
import TRAILHEAD_FIELD from '@salesforce/schema/Contact.Trailhead_Profile__c';
export default class addContactLWC extends LightningElement {

    contactObject = CONTACT_OBJECT;
    name = NAME_FIELD;
    employeenumber = EMPLOYEENUMBER_FIELD;
    title = TITLE_FIELD;
    phone = PHONE_FIELD;
    email = EMAIL_FIELD;
    location = LOCATION_FIELD;
    trailhead = TRAILHEAD_FIELD;

    handleSuccess(event) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Employee created',
                variant: 'success',
            }),
        );
        this.handleReset(event);
    }
    handleReset(event) {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }
}