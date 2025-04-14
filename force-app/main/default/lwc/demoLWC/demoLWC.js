import { LightningElement, track } from 'lwc';

export default class DemoLWC extends LightningElement {
    @track isVisibility = true;
    toggleVisibility() {
        this.isVisibility = !this.isVisibility;
    }

    @track count = 0;
    handleClick() {
        this.count++;
    }
    get evenOrOdd() {
        return this.count % 2 === 0;
    }
}