//Delete all Contact records where Email is null.

public class DeleteContactRecordsAndUndelete {
    List<Contact> cons = new List<Contact>();
    public void deleteAndUndelete() {
        cons = [SELECT Id,Name,Email FROM Contact WHERE Email=Null];
        if(!cons.isEmpty()) {
            for(Contact c:cons) {
                System.debug(c);
            }
            delete cons;
            System.debug('Contacts deleted');
            undelete cons;
            System.debug('Contacts restored');
        }
    }
}