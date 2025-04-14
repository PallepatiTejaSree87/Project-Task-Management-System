// Create a class Car with attributes brand, model, and price. Add a method getCarDetails() that returns a string with all details.
public class Car {
	String brand;
    String model;
    Decimal price;
    
    public Car(String brand,String model,Decimal price){
        this.brand = brand;
        this.model = model;
        this.price = price;
    }
    
    public String getCarDetails(){
        return 'Brand = ' + brand + ' Model = ' + model + ' Price  = ' + price;
    }
}