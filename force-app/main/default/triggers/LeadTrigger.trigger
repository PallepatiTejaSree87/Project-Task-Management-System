trigger LeadTrigger on Lead (before insert) {
    if(Trigger.isInsert && Trigger.isBefore) {
    	LeadTriggerHandler.updateCompanyFieldIfBlank(Trigger.new);
        LeadTriggerHandler.autoAssignOwner(Trigger.New);
    }
    
    if(Trigger.isUpdate && Trigger.isBefore) {
        LeadTriggerHandler.autoAssignOwner(Trigger.New);
    }
}