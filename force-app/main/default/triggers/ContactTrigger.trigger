trigger ContactTrigger on Contact (before insert, after insert, before  update, after update, before delete, after undelete) {
    if(Trigger.isInsert && Trigger.isBefore) {
    	ContactTriggerHandler.autoFillEmailIfBlank(Trigger.new);
    }
    
    if(Trigger.isInsert && Trigger.isAfter) {
        ContactTriggerHandler.createTask(Trigger.New);
    }
    
    if((Trigger.isInsert && Trigger.isAfter) || (Trigger.isUpdate && Trigger.isAfter)){
        ContactTriggerHandler.updateTotalAmountField(trigger.new,trigger.oldMap);
        Set<Id> accounts = new Set<Id>();
        for(Contact c:Trigger.new) {
            if(c.AccountId != null){
                accounts.add(c.AccountId);
            }
        }
        if(!accounts.isEmpty()){
            List<Account> accToUpdate = [SELECT Id,Number_of_contacts__c FROM Account WHERE Id IN: accounts];
            AccountTriggerHandler.noOfContacts(accToUpdate);
            update accToUpdate;
        }
    }
    
    if(Trigger.isDelete && Trigger.isAfter) {
        Set<Id> accounts = new Set<Id>();
        for(Contact c:Trigger.old) {
            if(c.AccountId != null){
                accounts.add(c.AccountId);
            }
        }
        if(!accounts.isEmpty()){
            List<Account> accToUpdate = [SELECT Id,Number_of_contacts__c FROM Account WHERE Id IN: accounts];
            AccountTriggerHandler.noOfContacts(accToUpdate);
            update accToUpdate;
        }
    }
}