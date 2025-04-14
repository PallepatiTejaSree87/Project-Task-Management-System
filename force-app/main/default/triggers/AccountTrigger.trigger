trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete) {
    if(Trigger.isInsert && Trigger.isBefore) {
    	AccountTriggerHandler.preventUsaAccountInsertion(trigger.new);
        AccountTriggerHandler.preventDuplicateInsertion(trigger.new);
        AccountTriggerHandler.autoPopulateCountryRegion(trigger.new);
    }
    
    if(Trigger.isInsert && Trigger.isAfter) {
		
    }
    
    if(Trigger.isUpdate && Trigger.isBefore) {
        AccountTriggerHandler.updateAccountNumber(trigger.new, trigger.oldMap);
		AccountTriggerHandler.preventDuplicateInsertion(trigger.new);
        AccountTriggerHandler.autoPopulateCountryRegion(trigger.new);
    }
    
    if(Trigger.isUpdate && Trigger.isAfter) {
    	AccountTriggerHandler.updateRelatedContactRecords(Trigger.new,Trigger.oldMap);
        AccountTriggerHandler.updateRelatedOppPhone(Trigger.new,Trigger.oldMap,Trigger.newMap);
    }
    
    if(Trigger.isDelete && Trigger.isBefore) {
        AccountTriggerHandler.preventDeletion(trigger.old);
    }
}