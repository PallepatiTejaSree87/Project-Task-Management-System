// Create a class called Student with fields name and age, and define a method displayDetails() to print the details.
public class StudentDisplayDetails {
	String name;
    Integer age;
    public studentDisplayDetails(String name,Integer age){
        this.name=name;
        this.age=age;
    }
    public void displayDetails(){
        System.debug('Name  = ' + name);
        System.debug('Age = ' + age);
    }
}