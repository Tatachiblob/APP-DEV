package model;

import java.io.Serializable;

public class InventoryStatus implements Serializable {

	private String deptName, stockName, stockUnit, stockStatus;
	private double currentQty;

	public InventoryStatus(){}

	public InventoryStatus(String deptName, String stockName, double currentQty, String stockUnit, String stockStatus){
		this.deptName = deptName;
		this.stockName = stockName;
		this.currentQty = currentQty;
		this.stockUnit =stockUnit;
		this.stockStatus = stockStatus;
	}

	public String getDeptName() {return deptName;}
	public void setDeptName(String deptName) {this.deptName = deptName;}
	public String getStockName() {return stockName;}
	public void setStockName(String stockName) {this.stockName = stockName;}
	public String getStockUnit() {return stockUnit;}
	public void setStockUnit(String stockUnit) {this.stockUnit = stockUnit;}
	public String getStockStatus() {return stockStatus;}
	public void setStockStatus(String stockStatus) {this.stockStatus = stockStatus;}
	public double getCurrentQty() {return currentQty;}
	public void setCurrentQty(double currentQty) {this.currentQty = currentQty;}

}
