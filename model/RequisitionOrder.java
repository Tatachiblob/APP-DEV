package model;

import java.io.Serializable;
import java.util.ArrayList;

public class RequisitionOrder implements Serializable {

	private int reqId;
	private Branch branch;
	private ArrayList<Inventory> reqDetails;
	private String recordDate;
	private String recordTime;

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
	public String getRecordDate() {return recordDate;}
	public void setRecordDate(String recordDate) {this.recordDate = recordDate;}
	public String getRecordTime() {return recordTime;}
	public void setRecordTime(String recordTime) {this.recordTime = recordTime;}

}
