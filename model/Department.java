package model;

import java.io.Serializable;

public class Department implements Serializable {

	protected int deptId;
	protected String deptName;

	public Department(){}

	public Department(String deptName){
		this.deptName = deptName;
	}

	public Department(int deptId, String deptName){
		this.deptId = deptId;
		this.deptName = deptName;
	}

	public int getDeptId(){return deptId;}
	public void setDeptId(int deptId){this.deptId = deptId;}
	public String getDeptName(){return deptName;}
	public void setDeptName(String deptName){this.deptName = deptName;}

}
