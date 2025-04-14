// merge operation demo
public class MergeOperationDemo {
    public void mergeOpeartion() {
        List<Account> acc = new List<Account>{new Account(Name='Amec Inc',Rating='Hot'), new Account(Name='Amec',Rating='Warm')};
        insert acc;
        Account masterAcc = [SELECT Id,Name FROM Account WHERE Name='Amec Inc'];
        Account mergeAcc = [SELECT Id,Name FROM Account WHERE Name='Amec'];
        merge masterAcc mergeAcc;
    }
}