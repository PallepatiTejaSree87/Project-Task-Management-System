trigger UserTrigger on User (before insert, after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        UserTriggerHandler.reassignAccountOwner(Trigger.new);
    }
}