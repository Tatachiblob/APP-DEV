package model;

import java.io.Serializable;
import java.util.Date;

public class Account implements Serializable {

	protected String userName;
	protected String password;
	protected Date activationDate;

	public Account(){}

	public Account(String userName, String password){
		this.userName = userName;
		this.password = password;
	}

	public String getUserName(){return userName;}
	public void setUserName(String userName){this.userName =userName;}
	public String getPassword(){return password;}
	public void setPassword(String password){this.password = password;}
	public Date getActivationDate(){return activationDate;}
	public void setActivationDate(Date activationDate){this.activationDate = activationDate;}

}
