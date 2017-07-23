package model;

import java.io.Serializable;

public class Stock implements Serializable {

	private int stockId;
	private double floorLvl, ceilLvl;
	private String name, unit;
	private int qty;

	public Stock(){}

	public Stock(String name, String unit, double floorLvl, double ceilLvl){
		this.name = name;
		this.unit = unit;
		this.floorLvl = floorLvl;
		this.ceilLvl = ceilLvl;
	}

	public Stock(int stockId, String name, String unit, double floorLvl, double ceilLvl){
		this.stockId = stockId;
		this.name = name;
		this.unit = unit;
		this.floorLvl = floorLvl;
		this.ceilLvl = ceilLvl;
	}

	public int getStockId(){return stockId;}
	public void setStockId(int stockId){this.stockId = stockId;}
	public String getName() {return name;}
	public void setName(String newName) {this.name = newName;}
	public String getUnit() {return unit;}
	public void setUnit(String newUnit){this.unit = newUnit;}
	public double getFloorLvl() {return floorLvl;}
	public void setFloorLvl(double floorLvl) {this.floorLvl = floorLvl;}
	public double getCeilLvl(){return ceilLvl;}
	public void setCeilLvl(double ceilLvl){this.ceilLvl = ceilLvl;}
	public int getQty(){return qty;}
	public void setQty(int qty){this.qty = qty;}

}
