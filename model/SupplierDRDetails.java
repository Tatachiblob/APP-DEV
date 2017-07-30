package model;

import java.io.Serializable;

public class SupplierDRDetails implements Serializable {

	private int drId;
	private Commissary commissary;
	private Supplier supplier;
	private Stock stock;
	private String receivedDate;
	private String receivedTime;
	private double deliverQty;

	public SupplierDRDetails(){}

	public void setDrId(int drId){this.drId = drId;}
	public int getDrId(){return drId;}
	public Commissary getCommissary() {return commissary;}
	public void setCommissary(Commissary commissary) {this.commissary = commissary;}
	public Supplier getSupplier(){return supplier;}
	public void setSupplier(Supplier supplier){this.supplier = supplier;}
	public Stock getStock(){return stock;}
	public void setStock(Stock stock){this.stock = stock;}
	public String getReceivedDate() {return receivedDate;}
	public void setReceivedDate(String receivedDate) {this.receivedDate = receivedDate;}
	public String getReceivedTime(){return receivedTime;}
	public void setReceivedTime(String receivedTime){this.receivedTime = receivedTime;}
	public double getDeliverQty(){return deliverQty;}
	public void setDeliverQty(double deliverQty){this.deliverQty = deliverQty;}

}
