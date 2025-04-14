public class UserTriggerHandler {
	//As a part of managing user access in the Salesforce system, 
	//BNR Company needs to ensure that when a user who owns multiple Account records is deactivated, 
	//the ownership of those Accounts is transferred to the manager of the deactivated user. 
	//Implement a solution to achieve this requirement.
    public static void reassignAccountOwner(List<User> users){
        Map<Id,Id> inactiveUsers = new Map<Id,Id>();
        for(User u:users){
            if(u.isActive == false){
                inactiveUsers.put(u.Id,u.ManagerId);
            }    
        }
        updateOwner(inactiveUsers);
	}
    
    @future
    public static void updateOwner(Map<Id,Id> inactiveUsers){
        List<Account> acctsToUpdate = new List<Account>();
        List<Account> userAccounts = [SELECT Id, OwnerId FROM Account WHERE OwnerId IN: inactiveUsers.keySet()];
        for(Account acc:userAccounts){
        	acc.OwnerId = inactiveUsers.get(acc.OwnerId);
            acctsToUpdate.add(acc);
        }
        if(!acctsToUpdate.isEmpty()){
            update acctsToUpdate;
        }
    }
}