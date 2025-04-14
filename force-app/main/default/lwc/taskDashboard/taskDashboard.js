import { LightningElement, wire, track } from 'lwc';
import getAllTasks from '@salesforce/apex/TaskDashboardController.getAllTasks';

const COLUMNS = [
    { label: 'Task Name', fieldName: 'Name', sortable: true, type: 'text' },
    { label: 'Project', fieldName: 'projectName', sortable: true, type: 'text' },
    { label: 'Due Date', fieldName: 'Due_Date__c', sortable: true, type: 'date' },
    { label: 'Status', fieldName: 'Status__c', sortable: true, type: 'text' },
    { label: 'Priority', fieldName: 'Priority__c', sortable: true, type: 'text' },
    { label: 'Assigned To', fieldName: 'assignedTo', sortable: true, type: 'text' },
];

export default class TaskDashboard extends LightningElement {
    tasks;
    temptasks = [];
    error;
    columns = COLUMNS;
    ProjectValues = [];
    UserValues = [];
    projectValuesCombo = [];
    userValuesCombo = [];
    @track projectvalue = 'All';
    @track userValue = 'All';

    sortedBy;
    sortedDirection = 'asc';

    @wire(getAllTasks)
    wiredTasks({ error, data }) {
        if (data) {
            this.tasks = data.map(task => ({
                ...task,
                projectName: task.project__r ? task.project__r.Name : '',
                assignedTo: task.Assigned_to__r ? task.Assigned_to__r.Name : ''
            }));
            this.tasks.forEach(task => {
                if (task.project__r && !this.ProjectValues.includes(task.project__r.Name)) {
                    this.ProjectValues.push(task.project__r.Name);
                }
                if (task.Assigned_to__r && !this.UserValues.includes(task.Assigned_to__r.Name)) {
                    this.UserValues.push(task.Assigned_to__r.Name);
                }
            });
            if (this.ProjectValues.length > 0) {
                this.ProjectValues.sort();
                this.projectValuesCombo = this.ProjectValues.map(project => ({ label: project, value: project }));
                this.projectValuesCombo.push({ label: 'All', value: 'All' });
            }
            if (this.UserValues.length > 0) {
                this.UserValues.sort();
                this.userValuesCombo = this.UserValues.map(user => ({ label: user, value: user }));
                this.userValuesCombo.push({ label: 'All', value: 'All' });
            }

            this.temptasks = [...this.tasks];
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.tasks = undefined;
            console.error('Error loading tasks:', error);
        }
    }

    handleChangeuser(event) {
        this.template.querySelector('.project').value = 'All';
        const selectedUser = event.detail.value;
        if (selectedUser === 'All') {
            this.temptasks = [...this.tasks];
        } else {
            this.temptasks = this.tasks.filter(task => task?.Assigned_to__r?.Name === selectedUser);
        }
    }

    handleChangeproject(event) {
        this.template.querySelector('.user').value = 'All';
        const selectedProject = event.detail.value;
        if (selectedProject === 'All') {
            this.temptasks = [...this.tasks];
        } else {
            this.temptasks = this.tasks.filter(task => task?.project__r?.Name === selectedProject);
        }
    }

    handleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.temptasks];

        cloneData.sort((a, b) => {
            let valA = a[sortedBy] ?? '';
            let valB = b[sortedBy] ?? '';
            // Date comparison
            if (valA instanceof Date || valB instanceof Date) {
                valA = new Date(valA);
                valB = new Date(valB);
            }
            return sortDirection === 'asc'
                ? (valA > valB ? 1 : -1)
                : (valA < valB ? 1 : -1);
        });

        this.temptasks = cloneData;
        this.sortedBy = sortedBy;
        this.sortedDirection = sortDirection;
    }
}
