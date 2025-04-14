// Insert a new Account record with Name = 'Test Account'.
public class InsertAccountRecord {
    public void insertRecord() {
        Account acc = new Account(Name='Test Account1', Rating='Warm');
        Insert acc;
        System.debug('Account inserted with id : ' + acc.Id);
    }
}