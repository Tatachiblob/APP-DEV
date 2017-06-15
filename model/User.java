package model;

import java.io.Serializable;

public class User implements Serializable {

	private int empId;
	private String userName, password, firstName, lastName;
	private int userType;

	public User(){}

	public User(String userName, String password, String firstName, String lastName, int userType){
		this.userName = userName;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		this.userType = userType;
	}

	public User(int empId, String userName, String password, String firstName, String lastName, int userType){
		this.setEmpId(empId);
		this.userName = userName;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		this.userType = userType;
	}

	public int getEmpId() {return empId;}
	public void setEmpId(int empId) {this.empId = empId;}
	public String getUserName() {return userName;}
	public void setUserName(String userName) {this.userName = userName;}
	public String getPassword() {return password;}
	public void setPassword(String password) {this.password = password;}
	public String getFirstName() {return firstName;}
	public void setFirstName(String firstName) {this.firstName = firstName;}
	public String getLastName() {return lastName;}
	public void setLastName(String lastName) {this.lastName = lastName;}
	public int getUserType() {return userType;}
	public void setUserType(int userType) {this.userType = userType;}

}
