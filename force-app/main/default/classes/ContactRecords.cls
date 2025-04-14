// Retrieve the FirstName and LastName of all Contact records where LastName starts with 'A'.
public class ContactRecords {
	List<Contact> con = new List<Contact>();
    public void displayContacts() {
        con = [SELECT FirstName,LastName FROM Contact WHERE LastName LIKE 'T%'];
        if(!con.isEmpty()) {
            for(Contact c:con) {
                System.debug(c);
            }
        }
        System.debug(con.size());
    }
}