//Write an SOQL query to fetch all Account records where the Industry is 'Technology'.

public class IndustryAccounts {
	List<Account> acc = new List<Account>();
    public void getTechnologyAccounts() {
        acc = [SELECT Id,Name,Industry FROM Account WHERE Industry='Technology'];
        if(!acc.isEmpty()) {
            for(Account a:acc) {
                System.debug(a);
            }	
        }
    }
}