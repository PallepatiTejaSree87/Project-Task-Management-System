trigger OpportunityTrigger on Opportunity (before insert, before delete) {
    if(Trigger.isDelete && Trigger.isBefore) {
    	OpportunityTriggerHandler.preventRecordDeletion(Trigger.old,Trigger.oldMap);
    }
}