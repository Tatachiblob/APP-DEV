package model;

import java.io.Serializable;
import java.util.HashMap;

public class Branch extends Department implements Serializable {

	private String branchAddr;
	private HashMap<String, Account> managers;

	public Branch(){}

	public Branch(String deptName, String branchAddr){
		super(deptName);
		this.branchAddr = branchAddr;
		this.managers = new HashMap<>();
	}

	public Branch(int deptId, String deptName, String branchAddr){
		super(deptId, deptName);
		this.branchAddr = branchAddr;
		this.managers = new HashMap<>();
	}

	public String getBranchAddr(){return branchAddr;}
	public void setBranchAddr(String branchAddr){this.branchAddr = branchAddr;}
	public HashMap<String, Account> getClerks(){return managers;}
	public void setClerks(HashMap<String, Account> managers){this.managers = managers;}

}
