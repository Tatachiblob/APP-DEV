package model;

import java.io.Serializable;

public class Supplier implements Serializable {

	private int supplierId;
	private String supplierName;
	private String contactPerson;
	private String contactInfo;

	public Supplier(){}

	public Supplier(String supplierName, String contactPerson, String contactInfo){
		this.supplierName = supplierName;
		this.contactPerson = contactPerson;
		this.contactInfo = contactInfo;
	}

	public Supplier(int supplierId, String supplierName, String contactPerson, String contactInfo){
		this.supplierId = supplierId;
		this.supplierName = supplierName;
		this.contactPerson = contactPerson;
		this.contactInfo = contactInfo;
	}

	public int getSupplierId() {return supplierId;}
	public void setSupplierId(int supplierId) {this.supplierId = supplierId;}
	public String getSupplierName() {return supplierName;}
	public void setSupplierName(String supplierName) {this.supplierName = supplierName;}
	public String getContactPerson() {return contactPerson;}
	public void setContactPerson(String contactPerson) {this.contactPerson = contactPerson;}
	public String getContactInfo() {return contactInfo;}
	public void setContactInfo(String contactInfo) {this.contactInfo = contactInfo;}

}
