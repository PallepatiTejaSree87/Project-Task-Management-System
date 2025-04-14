// Write a class BankAccount with instance variables accountNumber and balance. Include a method deposit(amount) to add money and withdraw(amount) to deduct money from balance.
public class BankAccount {
	String accountNumber;
    Decimal balance;
    
    public BankAccount(String accountNumber,Decimal balance) {
        this.accountNumber = accountNumber;
        this.balance = balance;
    }
    
    public void deposit(Decimal amount) {
       balance += amount;
       System.debug('Remaining balance after deposit = ' + balance);
    }
    
    public void withdraw(Decimal amount) {
        balance -= amount;
        System.debug('Remaining balance after withdraw = ' + balance);
    }
}