public class CaseTriggerHandler {
    //Create a trigger on the Case object that sets the Priority to High if the Case Reason is Performance.
    public static void setPriority(List<Case> cases) {
        for(Case c : cases) {
            if(c.Reason == 'Performance') {
                c.Priority = 'High';
            }
        }        
    }
    
    //Trigger on the Case object that sends an email notification to the owner when a case is closed.
    public static void sendEmailWhenClosed(List<Case> cases){
		List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        List<Case> caseListWithEmails = [SELECT Id,Status,Owner.Email,Owner.Name FROM Case WHERE Id IN: cases];
        for(Case c:caseListWithEmails){
            if(c.Status == 'Resolved') {
                String senderName = c.Owner.Name;
                String body = '<b>Dear '+senderName+'<b><br></br>'+'The case is closed';
                Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{c.Owner.Email});
                email.setSubject('Case is closed');
                email.setHtmlBody(body);
                emails.add(email);
            }
        }        
        if(!emails.isEmpty()) {
        	Messaging.sendEmail(emails);
        }
    }
    
    //Implement a solution that automatically updates the description field of an 
    //Account whenever the status field of a related Case record is changed. 
    //The updated description should include the Case Number and Status of the Case.
    public static void updateAccoutDescription(List<Case> cases){
        List<Account> accountsToUpdate = new List<Account>();
        List<Id> relatedAccIds = new List<Id>();
        for(Case c:cases){
            if(c.AccountId!=null){
                relatedAccIds.add(c.AccountId);
            }
        }
        Map<Id,Account> relatedAccounts = new Map<Id,Account>([SELECT Id,Description FROM Account WHERE Id IN: relatedAccIds]);
        for(Case c:cases){
            if(c.AccountId!=null){
                Account acc=relatedAccounts.get(c.AccountId);
                String caseStatus='Case Number : '+c.CaseNumber+' , Status = '+c.Status;
                acc.Description=caseStatus;	
                accountsToUpdate.add(acc);
            }
        }
        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
    }
}