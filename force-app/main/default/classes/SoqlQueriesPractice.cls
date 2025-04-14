public class SoqlQueriesPractice {
    public void fetchAndDisplay() {
        //Fetch all Accounts that have at least one Opportunity with StageName = 'Closed Won' and Amount > 100,000.
		// Display the Account Name, Industry, and related Opportunity names.
        List<Account> acc = [SELECT Id,Name,Industry,(SELECT Id,Name FROM Opportunities) 
                             FROM Account 
                             WHERE Id IN (SELECT AccountId FROM Opportunity WHERE StageName = 'Closed Won' AND Amount > 100000)];
        if(!acc.isEmpty()) {
            for(Account a : acc) {
                System.debug(a);
            }
        }
        
        //Fetch the total number of Contacts grouped by Account Name where the Contact's Title contains Manager.
		//Display the Account Name and the count of Contacts.
        List<Object> obj = [SELECT Account.Name,Count(Id) ContactCount FROM Contact WHERE Title LIKE '%Manager%' GROUP BY Account.Name];
        if(!obj.isEmpty()) {
            for(Object o : obj) {
                System.debug(o);
            }
        }
        
        //Retrieve all Leads where the Company field is NULL or the Phone field is Blank.
		//Display Lead Name, Email, and Company.
		List<Lead> leads = [SELECT Id,Name,Email,Phone FROM Lead WHERE Email = NULL OR Phone = ''];
        if(!leads.isEmpty()) {
            for(Lead lead : leads) {
                System.debug(lead);
            }
        }
        
        //Fetch all soft-deleted Contacts and display the Contact ID, Name, and Email.
		List<Contact> cons = [SELECT Id,Name,Email FROM Contact WHERE IsDeleted = TRUE ALL ROWS];
        if(!cons.isEmpty()) {
            for(Contact c : cons) {
                System.debug(c);
            }
        }
        
        //Fetch all Cases created in the last 7 days.
		//Display the Case Number, Status, and CreatedDate.
		List<Case> cases = [SELECT Id,CaseNumber,Status,CreatedDate FROM Case WHERE CreatedDate = LAST_N_DAYS:7];
        if(!cases.isEmpty()) {
            for(Case c : cases) {
                System.debug(c);
            }
        }
    }
}