package model;

import java.io.Serializable;

public class Stock implements Serializable {

	private int stockId;
	private String stockName;
	private String stockUnit;
	private double floorLvl;

	public Stock(){}

	public Stock(String stockName, String stockUnit, double floorLvl){
		this.stockName = stockName;
		this.stockUnit = stockUnit;
		this.floorLvl =floorLvl;
	}

	public Stock(int stockId, String stockName, String stockUnit, double floorLvl){
		this.stockId = stockId;
		this.stockName = stockName;
		this.stockUnit = stockUnit;
		this.floorLvl =floorLvl;
	}

	public int getStockId() {return stockId;}
	public void setStockId(int stockId) {this.stockId = stockId;}
	public String getStockName() {return stockName;}
	public void setStockName(String stockName) {this.stockName = stockName;}
	public String getStockUnit() {return stockUnit;}
	public void setStockUnit(String stockUnit) {this.stockUnit = stockUnit;}
	public double getFloorLvl() {return floorLvl;}
	public void setFloorLvl(double floorLvl) {this.floorLvl = floorLvl;}

}
