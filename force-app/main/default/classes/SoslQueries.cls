public class SoslQueries {
    public void soslQueriesExecution() {
        List<List<Object>> res = [FIND 'Test Name' IN Name Fields RETURNING Account(Id,Name), Contact(Id,Name), Opportunity(Id,Name)];
        //List<List<Object>> res = [FIND 'Test Emp' IN Full_Name__c Fields RETURNING Employe__c(Id,Full_Name__c)];
        Integer totalRec = 0;
        if(!res.isEmpty()) {
            for(List<Object> each : res) {
                totalRec += each.size();
                System.debug(each);
            }
        }
        System.debug(totalRec);
    }
}