// Upsert operation
public class UpsertOperationDemo {
    public void upsertOperation() {
        Account acc = new Account(Name='Test Account5', Rating='Hot');
        acc.Name = 'Test Account6';
        Upsert acc;
    }
}