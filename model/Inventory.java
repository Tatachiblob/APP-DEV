package model;

import java.io.Serializable;

public class Inventory implements Serializable {

	private Stock stock;
	private double quantity;
	private String status;

	public Inventory(){}

	public Inventory(Stock stock, double quantity){
		this.stock = stock;
		this.quantity = quantity;
	}

	public Stock getStock() {return stock;}
	public void setStock(Stock stock) {this.stock = stock;}
	public double getQuantity() {return quantity;}
	public void setQuantity(double quantity) {this.quantity = quantity;}
	public String getStatus(){return status;}
	public void setStatus(String status){this.status = status;}

}
