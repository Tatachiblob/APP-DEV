package model;

import java.io.Serializable;

public class Admin extends Account implements Serializable {

	private String firstName;
	private String lastName;

	public Admin(){}

	public Admin(String userName, String password, String firstName, String lastName){
		super(userName, password);
		this.firstName = firstName;
		this.lastName = lastName;
	}

	public String getFirstName(){return firstName;}
	public void setFirstName(String firstName){this.firstName = firstName;}
	public String getLastName(){return lastName;}
	public void setLastName(String lastName){this.lastName = lastName;}

}
