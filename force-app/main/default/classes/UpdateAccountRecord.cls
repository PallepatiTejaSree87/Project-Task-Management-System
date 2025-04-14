// Update the Phone field of an Account record where Name = 'Test Account1'.

public class UpdateAccountRecord {
    public void updateRecord() {
        Account acc= [SELECT Id,Name,Phone FROM Account WHERE Name='Test Account1' LIMIT 1];
        acc.Phone='9876543210';
        Update acc;
    }
}