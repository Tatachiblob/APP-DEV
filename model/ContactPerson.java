package model;

import java.io.Serializable;

public class ContactPerson implements Serializable {

	private int contactId, supplierId;
	private String contactName, contactInfo;
	private boolean isContactable;

	public ContactPerson(){}

	public ContactPerson(int supplierId, String contactName, String contactInfo){
		this.supplierId = supplierId;
		this.contactName = contactName;
		this.contactInfo = contactInfo;
		this.isContactable = true;
	}

	public ContactPerson(int contactId, int supplierId, String contactName, String contactInfo, boolean isContactable){
		this.contactId = contactId;
		this.supplierId = supplierId;
		this.contactName = contactName;
		this.contactInfo = contactInfo;
		this.isContactable = isContactable;
	}

	public int getContactId() {return contactId;}
	public void setContactId(int contactId) {this.contactId = contactId;}
	public int getSupplierId() {return supplierId;}
	public void setSupplierId(int supplierId) {this.supplierId = supplierId;}
	public String getContactName() {return contactName;}
	public void setContactName(String contactName) {this.contactName = contactName;}
	public String getContactInfo() {return contactInfo;}
	public void setContactInfo(String contactInfo) {this.contactInfo = contactInfo;}
	public boolean isContactable() {return isContactable;}
	public void setContactable(boolean isContactable) {this.isContactable = isContactable;}

}
