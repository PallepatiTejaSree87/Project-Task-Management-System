@isTest
public class FutureUpdateContactTest {
	@isTest
    public static void testFutureUpdateContact(){
        List<Account> accounts = new List<Account>();
        for(Integer i=1;i<=3;i++){
            accounts.add(new Account(Name='test acc for test '+i, Rating='Cold', Phone='123456789'+String.valueOf(i)));
        }
        insert accounts;
        for(Account a:accounts){
            System.debug(a.Phone);
        }
        List<Contact> contacts = new List<Contact>();
        for(Account acc:accounts){
            contacts.add(new Contact(LastName='test con for test '+acc.Name, AccountId=acc.Id));
        }
        insert contacts;     
        List<Id> accIds = new List<Id>();
        for(Account acc:accounts){
            accIds.add(acc.Id);
        }
        Test.StartTest();
        FutureUpdateContact.updateRelatedContactPhone(accIds);
        Test.StopTest();
        
        List<Contact> updatedContacts = [SELECT Id, Phone, Account.Phone FROM Contact WHERE AccountId IN :accIds];
		System.debug(updatedContacts);
        
        for(Contact updatedContact:updatedContacts){
            System.assertEquals(updatedContact.Account.Phone,updatedContact.Phone,'Phone filed is not updated');
            System.debug(updatedContact.Account.Phone+'.....'+updatedContact.Phone);
        }
    }
}