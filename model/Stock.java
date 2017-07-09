package model;

import java.io.Serializable;

public class Stock implements Serializable {

	private float floorLvl;
	private String name, unit;

	public Stock(){}

	public Stock(String name, String unit, float floorLvl){
		this.name = name;
                this.unit = unit;
                this.floorLvl = floorLvl;
	}

	public String getName() {return name;}
	public void setName(String newName) {this.name = newName;}
        public String getUnit() {return unit;}
        public void setUnit(String newUnit){this.unit = newUnit;}
        public float getFloorLvl() {return floorLvl;}
        public void setFloorLvl(float lvl) {this.floorLvl = lvl;}

}
