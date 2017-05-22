package model;

import java.io.Serializable;
import java.util.HashMap;

public class Commissary extends Department implements Serializable {

	private String comAddr;
	private HashMap<String, Account> clerks;

	public Commissary(){}

	public Commissary(String deptName, String comAddr){
		super(deptName);
		this.comAddr = comAddr;
		this.clerks = new HashMap<>();
	}

	public Commissary(int deptId, String deptName, String comAddr){
		super(deptId, deptName);
		this.comAddr = comAddr;
		this.clerks = new HashMap<>();
	}

	public String getComAddr(){return comAddr;}
	public void setComAddr(String comAddr){this.comAddr = comAddr;}
	public HashMap<String, Account> getClerks(){return clerks;}
	public void setClerks(HashMap<String, Account> clerks){this.clerks = clerks;}

}
