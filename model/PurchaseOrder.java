package model;

import java.io.Serializable;
import java.util.ArrayList;

public class PurchaseOrder implements Serializable {

	private int poId;
	private Commissary com;
	private Supplier supplier;
	private String creationDate;
	private String creationTime;
	private ArrayList<Inventory> poDetails;

	public PurchaseOrder(){}

	public int getPoId() {return poId;}
	public void setPoId(int poId) {this.poId = poId;}
	public Commissary getCom() {return com;}
	public void setCom(Commissary com) {this.com = com;}
	public Supplier getSupplier() {return supplier;}
	public void setSupplier(Supplier supplier) {	this.supplier = supplier;}
	public String getCreationDate() {return creationDate;}
	public void setCreationDate(String creationDate) {this.creationDate = creationDate;}
	public String getCreationTime() {return creationTime;}
	public void setCreationTime(String creationTime) {this.creationTime = creationTime;}
	public ArrayList<Inventory> getPoDetails() {return poDetails;}
	public void setPoDetails(ArrayList<Inventory> poDetails) {this.poDetails = poDetails;}

}
