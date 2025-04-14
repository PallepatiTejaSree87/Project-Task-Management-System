import { LightningElement, track, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class ContactList extends LightningElement {
    contacts;
    error;

    @wire(getContacts)
    wiredContacts({ error, data }) {
        if (data) {
            console.log('data', data);
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            console.log('error', error);
            this.error = error;
            this.contacts = undefined;
        }
    }
}
