package model;

import java.io.Serializable;

public class Commissary implements Serializable {

	protected int comId;
	protected String comName, comAddress;

	public Commissary(){}

	public Commissary(String comName, String comAddress){
		this.comName = comName;
		this.comAddress = comAddress;
	}

	public Commissary(int comId, String comName, String comAddress){
		this.comId = comId;
		this.comName = comName;
		this.comAddress = comAddress;
	}

	public int getComId() {return comId;}
	public void setComId(int comId) {this.comId = comId;}
	public String getComName() {return comName;}
	public void setComName(String comName) {this.comName = comName;}
	public String getComAddress() {return comAddress;}
	public void setComAddress(String comAddress) {this.comAddress = comAddress;}

}
