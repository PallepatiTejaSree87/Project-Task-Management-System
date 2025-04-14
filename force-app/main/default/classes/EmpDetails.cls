// Create a Map of employee IDs and names. Print all the keys and values using a loop.

public class EmpDetails {
	Map<Integer,String> emp = new Map<Integer,String>();
    
    public EmpDetails() {
    	emp.put(12345,'Teja');
    	emp.put(67890,'Vish');   
    }
    
    public void displayDetails() {
        for(Integer id : emp.keySet()) {
            System.debug('Id : ' + id + ' Name : ' + emp.get(id));
        }
    }
}