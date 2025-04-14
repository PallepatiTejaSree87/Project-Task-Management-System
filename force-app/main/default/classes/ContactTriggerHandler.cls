public class ContactTriggerHandler {
	//Write a trigger on the Contact object that automatically sets the Email field to test@example.com if it is left blank during insertion.
    public static void autoFillEmailIfBlank(List<Contact> con) {
        for(Contact c : con) {
            if(c.Email == NULL) {
                c.Email='test@example.com';
            }
        }
    }
    
    //Trigger on the Contact object that automatically creates a related Task record when a Contact is inserted. The Subject of the task should be Follow-up Call.
    public static void createTask(List<Contact> con) {
        List<Task> tasks = new List<Task>();
        for(Contact c : con) {
            Task t = new Task();
            t.Subject = 'Follow-up Call';
            t.ActivityDate = System.today()+2;
            t.WhoId = c.Id;
            t.OwnerId = UserInfo.getUserId();
            t.Status = 'Not Started';
            tasks.add(t);
        }
        insert tasks;    
    }
    
    // When the amount field is updated then update the total amount field of the related account
    public static void updateTotalAmountField(List<Contact> cons, Map<Id,Contact> oldCons) {
        Decimal changeInAmount;
        List<Account> accToUpdate = new List<Account>();
        Set<Id> accIds = new Set<Id>();
        for (Contact con : cons) {
            if (con.AccountId != null) {
                accIds.add(con.AccountId);
            }
        }
        Map<Id, Account> relatedAccounts = new Map<Id, Account>([SELECT Id, Total_Amount__c FROM Account WHERE Id IN :accIds]);
        for (Contact con : cons) {
            if (con.AccountId != null) {
                Account acc = relatedAccounts.get(con.AccountId);
                if (!oldCons.containsKey(con.Id) && acc != null) {
                    acc.Total_Amount__c = (acc.Total_Amount__c == null) ? con.Amount__c : acc.Total_Amount__c + con.Amount__c;
                    accToUpdate.add(acc);
                }
                if (oldCons.containsKey(con.Id) && oldCons.get(con.Id).Amount__c != null && con.Amount__c != oldCons.get(con.Id).Amount__c) {
                    if (acc != null) {
                        changeInAmount = con.Amount__c - oldCons.get(con.Id).Amount__c;
                        acc.Total_Amount__c = (acc.Total_Amount__c == null) ? changeInAmount : acc.Total_Amount__c + changeInAmount;
                        accToUpdate.add(acc);
                    }
                }
            }
        }
        if (!accToUpdate.isEmpty()) {
            update accToUpdate;
        }
	}
}