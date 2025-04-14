//Write a future method that updates the Phone field of all Contact records with a specific AccountId.

public class FutureUpdateContact {
	@future
    public static void updateRelatedContactPhone(List<Id> acctIds){
        List<Contact> conToUpdate = new List<Contact>();
        List<Contact> cons = new List<Contact>([SELECT Id, Phone, AccountId FROM Contact WHERE AccountId IN: acctIds]);
        Map<Id,Account> accMap = new Map<Id,Account>([SELECT Id, Phone FROM Account WHERE Id IN: acctIds]);
        for(Contact con:cons){
            Account acc = accMap.get(con.AccountId);
            con.Phone=acc.Phone;
            conToUpdate.add(con);
        }
        if(!conToUpdate.isEmpty()){
            update conToUpdate;
        }
    }
}