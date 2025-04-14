trigger CaseTrigger on Case (before insert, after insert, before update, after update) {
    if(Trigger.isInsert && Trigger.isBefore) {
    	CaseTriggerHandler.setPriority(Trigger.new);
    }
    
    if(Trigger.isUpdate && Trigger.isBefore) {
    	CaseTriggerHandler.setPriority(Trigger.new);
    }
    
    if((Trigger.isInsert && Trigger.isAfter) || (Trigger.isUpdate && Trigger.isAfter)) {
        CaseTriggerHandler.sendEmailWhenClosed(Trigger.new);
        CaseTriggerHandler.updateAccoutDescription(Trigger.New);
    }
}