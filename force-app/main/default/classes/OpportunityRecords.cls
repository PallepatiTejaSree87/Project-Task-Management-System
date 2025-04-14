// Fetch all Opportunity records created in the last 30 days.

public class OpportunityRecords {
	List<Opportunity> opp = new List<Opportunity>();
    public void fetchRecords() {
        opp = [SELECT Id,Name,CreatedDate FROM Opportunity WHERE CreatedDate=LAST_N_DAYS:30];
        if(!opp.isEmpty()) {
            for(Opportunity o:opp) {
                System.debug(o);
            }
    	}
        System.debug(opp.size());
    }
}