public class AccountTriggerHandler {
    //Create a trigger on the Account object that prevents insertion of accounts with a BillingCountry set to USA.
    public static void preventUsaAccountInsertion(List<Account> acc) {
        for(Account a : acc) {
            if(a.BillingCountry == 'USA') {
                a.BillingCountry.addError('Account with billing country USA can\'t be created');
            }
        }
    }
    
    //Trigger on the Account object that prevents insertion of duplicate Account names.
    public static void preventDuplicateInsertion(List<Account> acc) {
    	List<Account> accounts = [SELECT Id,Name FROM Account];
        for(Account a : acc) {
            for(Account ac : accounts) {
                if((a.Id != ac.Id) && (a.Name == ac.Name)) {
                    a.Name.addError('Duplicate names not allowed');
                }
            }
        }
    }
    
    //prevent deletion of high-value accounts
    public static void preventDeletion(List<Account> acc) {
        for(Account a:acc){
            if(a.AnnualRevenue>=1000000){
                a.addError('High-value records can\'t be deleted');
            }
        }
    }
    
    //count of related contacts
    public static void noOfContacts(List<Account> acc) {
        Map<Id,List<Contact>> accountContactMap = new Map<Id,List<Contact>>();
        List<Contact> cons = [SELECT Id,AccountId FROM Contact WHERE AccountId IN: acc];
        for(Contact c:cons) {
            if(!accountContactMap.containsKey(c.AccountId)) {
                accountContactMap.put(c.AccountId,new List<Contact>());
            }
            accountContactMap.get(c.AccountId).add(c);
        }
        for(Account a:acc) {
            List<Contact> cs = accountContactMap.get(a.Id);
            a.Number_of_contacts__c=cs.size();
        }
    }
    
    //Auto-Populate a Field Based on Another Field
    public static void autoPopulateCountryRegion(List<Account> acc){
        for(Account a: acc){
            if(a.BillingCountry=='USA'){
                a.Country_Region__c='North America';
            } else if(a.BillingCountry=='India'){
                a.Country_Region__c='Asia';
            }
        }        
    }
    
    //Update Related Contacts When Account Name Changes
    public static void updateRelatedContactRecords(List<Account> acc,Map<Id,Account> accMap){
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Account a:acc){
            if(a.Name!=accMap.get(a.Id).Name) {
                for(Contact con:[SELECT Id,Name FROM Contact WHERE AccountId=:a.Id]){
                    con.Company__C=a.Name;
                    contactsToUpdate.add(con);
                }
            }
        }
        if(!contactsToUpdate.isEmpty()){
            update contactsToUpdate;
        }
    }
    
    //Develop an Apex trigger on the Opportunity object that automatically updates the Opportunity's phone field 
    //whenever the related Account's phone field changes. 
    //The trigger should ensure that the Opportunity's phone field 
    //reflects the most recent value of the Account's phone field.
    public static void updateRelatedOppPhone(List<Account> accs,Map<Id,Account> accMap,Map<Id,Account> newMap){
        List<Opportunity> listToUpdate = new List<Opportunity>();
        List<Id> accIds = new List<Id>();
        for(Account acc:accs){
            if(acc.Phone!=null && acc.Phone!=accMap.get(acc.Id).Phone){
            	accIds.add(acc.Id);	
            }
        }
        if(!accIds.isEmpty()){
            List<Opportunity> relatedOpps=[SELECT Id, Phone__c, AccountId FROM Opportunity WHERE AccountId IN :accIds];
            for(Opportunity opp:relatedOpps){
                Account acc=newMap.get(opp.AccountId);
                opp.Phone__c=acc.Phone;
                listToUpdate.add(opp);
            }
        }
        update listToUpdate;
    }
    
    //If the user is trying to update Account number more than two times then prevent the user to update.
    public static void updateAccountNumber(List<Account> accounts, Map<Id,Account> accOldMap){
        for(Account acc:accounts){
            if(acc.AccountNumber != accOldMap.get(acc.Id).AccountNumber) {
                acc.Account_Number_Updated_Count__c = (acc.Account_Number_Updated_Count__c==null) ? 1 : acc.Account_Number_Updated_Count__c+1;
            }
            if(acc.Account_Number_Updated_Count__c>2){
                acc.AccountNumber.addError('Account Number can\'t be updated more than 2 times');
            }
        }
    }
}