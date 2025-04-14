public class LeadTriggerHandler {
	//Write a trigger on the Lead object that updates the Company field to N/A if it is blank during record creation.
    public static void updateCompanyFieldIfBlank(List<Lead> leads) {
        for(Lead l : leads) {
            if(l.Company == NULL) {
                l.Company = 'N/A';
            }
        }
    }
    
    //Auto-Assign Lead owner Based on Region
    public static void autoAssignOwner(List<Lead> leads){
		User us1=[SELECT Id,Title,State from User where Title='Sales rep1' AND State='Telangana' AND isActive=true limit 1];
        User us2=[SELECT Id,Title,State from User where Title='Sales rep2' AND State='AP' AND isActive=true limit 1];
        for(Lead lead:leads){
            if(lead.State == 'Telangana'){
                lead.OwnerId=us1.Id;
            } else if(lead.State == 'AP'){
                lead.OwnerId=us2.Id;
            }
        }
    }
}