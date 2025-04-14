public class OpportunityTriggerHandler {
    //Implement an Apex trigger to prevent the deletion of an Opportunity if it is closed won and 
    //has any related Activities status as not closed
	public static void preventRecordDeletion(List<Opportunity> opp, Map<Id,Opportunity> oppOldMap) {
        List<Id> oppIds = new List<Id>();
        for(Opportunity o : opp) {
            oppIds.add(o.Id);
        }
        List<Task> relatedTasks = new List<Task>([SELECT Id FROM Task WHERE WhatId IN: oppIds AND Status <> 'Completed']);
        for(Opportunity o : opp) {
            if(o.StageName == 'Closed Won' && !relatedTasks.isEmpty()) {
                o.addError('Opp is closed won and related tasks are also not closed so this record can\'t be deleted');
            }
            else if(o.StageName == 'Closed Won') {
                o.addError('You can\'t delete this record as the stage is Closed Won');
            }
            else if(!relatedTasks.isEmpty()) {
                o.addError('Related tasks are not completed yet, so this record can\'t be deleted');
            }
        }
    }
}