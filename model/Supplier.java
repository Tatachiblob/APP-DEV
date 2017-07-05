package model;

import java.io.Serializable;

public class Supplier implements Serializable {

	private int supplierId;
	private String supplierName, companyContact;
	private boolean isActive;

	public Supplier(){}

	public Supplier(String supplierName, String companyContact){
		this.supplierName = supplierName;
		this.companyContact = companyContact;
		this.isActive = true;
	}

	public Supplier(int supplierId, String supplierName, String companyContact){
		this.supplierId = supplierId;
		this.supplierName = supplierName;
		this.companyContact = companyContact;
		this.isActive = true;
	}

	public int getSupplierId() {return supplierId;}
	public void setSupplierId(int supplierId) {this.supplierId = supplierId;}
	public String getSupplierName() {return supplierName;}
	public void setSupplierName(String supplierName) {this.supplierName = supplierName;}
	public String getCompanyContact(){return companyContact;}
	public void setCompanyContact(String companyContact){this.companyContact = companyContact;}
	public boolean getIsActive(){return isActive;}
	public void setIsActive(boolean isActive){this.isActive = isActive;}

}
