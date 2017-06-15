package model;

import java.io.Serializable;

public class Branch implements Serializable {

	private int branchId, comId;
	private String branchName, branchAddress;

	public Branch(){}

	public Branch(int comId, String branchName, String branchAddress){
		this.comId = comId;
		this.branchName = branchName;
		this.branchAddress = branchAddress;
	}

	public Branch(int branchId, int comId, String branchName, String branchAddress){
		this.branchId = branchId;
		this.comId = comId;
		this.branchName = branchName;
		this.branchAddress = branchAddress;
	}

	public int getBranchId() {return branchId;}
	public void setBranchId(int branchId) {this.branchId = branchId;}
	public int getComId() {return comId;}
	public void setComId(int comId) {this.comId = comId;}
	public String getBranchName() {return branchName;}
	public void setBranchName(String branchName) {this.branchName = branchName;}
	public String getBranchAddress() {return branchAddress;}
	public void setBranchAddress(String branchAddress) {this.branchAddress = branchAddress;}

}
