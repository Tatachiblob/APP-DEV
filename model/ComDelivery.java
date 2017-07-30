package model;

import java.io.Serializable;

public class ComDelivery implements Serializable {

	private int comDrId;
	private Commissary commissary;
	private Branch branch;
	private String creationDate;
	private String creationTime;
	private Stock stock;
	private double deliverQty;

	public ComDelivery(){}

	public int getComDrId() {return comDrId;}
	public void setComDrId(int comDrId) {this.comDrId = comDrId;}
	public Commissary getCommissary() {return commissary;}
	public void setCommissary(Commissary commissary) {this.commissary = commissary;}
	public Branch getBranch() {return branch;}
	public void setBranch(Branch branch) {this.branch = branch;}
	public String getCreationDate() {return creationDate;}
	public void setCreationDate(String creationDate) {this.creationDate = creationDate;}
	public String getCreationTime() {return creationTime;}
	public void setCreationTime(String creationTime) {this.creationTime = creationTime;}
	public Stock getStock() {return stock;}
	public void setStock(Stock stock) {this.stock = stock;}
	public double getDeliverQty() {return deliverQty;}
	public void setDeliverQty(double deliverQty) {this.deliverQty = deliverQty;}

}
