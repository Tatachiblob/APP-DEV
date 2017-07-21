package model;

import java.io.Serializable;
import java.util.ArrayList;

public class RequisitionOrder implements Serializable {

	private int reqId;
	private Branch branch;
	private ArrayList<Inventory> reqDetails;

	public RequisitionOrder(){}

	public RequisitionOrder(int reqId, Branch branch){
		this.reqId = reqId;
		this.branch = branch;
	}

	public int getReqId() {return reqId;}
	public void setReqId(int reqId) {this.reqId = reqId;}
	public Branch getBranch() {return branch;}
	public void setBranch(Branch branch) {this.branch = branch;}
	public ArrayList<Inventory> getReqDetails() {return reqDetails;}
	public void setReqDetails(ArrayList<Inventory> reqDetails) {this.reqDetails = reqDetails;}

}
