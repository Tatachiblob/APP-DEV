package model;

import java.io.Serializable;

public class MonthlyInventory implements Serializable {

	private Commissary com;
	private String recordDate;
	private String recordTime;
	private Stock stock;
	private double actualQty;
	private double discrepancy;

	public MonthlyInventory(){}

	public Commissary getCom() {return com;}
	public void setCom(Commissary com) {this.com = com;}
	public String getRecordDate() {return recordDate;}
	public void setRecordDate(String recordDate) {this.recordDate = recordDate;}
	public String getRecordTime() {return recordTime;}
	public void setRecordTime(String recordTime) {this.recordTime = recordTime;}
	public Stock getStock() {return stock;}
	public void setStock(Stock stock) {this.stock = stock;}
	public double getActualQty() {return actualQty;}
	public void setActualQty(double actualQty) {this.actualQty = actualQty;}
	public double getDiscrepancy() {return discrepancy;}
	public void setDiscrepancy(double discrepancy) {this.discrepancy = discrepancy;}

}
