package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.ContactPerson;
import model.Supplier;

public class SupplierDAO {

	public static boolean addNewSupplier(Supplier newSupplier){
		boolean isAdded = false;
		String sql = "INSERT INTO SUPPLIER(SUPPLIER_NAME, COMPANY_CONTACT_INFO, ACTIVE) VALUES (?, ?, 0);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, newSupplier.getSupplierName());
			pStmt.setString(2, newSupplier.getCompanyContact());
			int result = pStmt.executeUpdate();
			if(result != 0){
				isAdded = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{

				}catch(Exception e){}
			}
		}
		return isAdded;
	}

	public static Supplier getSupplierByName(String supplierName){
		Supplier supplier = null;
		String sql = "SELECT SUPPLIER_ID, SUPPLIER_NAME, COMPANY_CONTACT_INFO FROM SUPPLIER WHERE SUPPLIER_NAME = ? AND ACTIVE = TRUE;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, supplierName);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				supplier = new Supplier(rs.getInt(1), rs.getString(2), rs.getString(3));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return supplier;
	}

	public static Supplier getSupplierById(int supplierId){
		Supplier supplier = null;
		String sql = "SELECT SUPPLIER_ID, SUPPLIER_NAME, COMPANY_CONTACT_INFO FROM SUPPLIER WHERE SUPPLIER_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, supplierId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				supplier = new Supplier(rs.getInt(1), rs.getString(2), rs.getString(3));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return supplier;
	}

	public static boolean addNewSupplierContact(ContactPerson newContact, Supplier supplier){
		boolean isAdded = false;
		String sql = "INSERT INTO SUPPLIER_CONTACT(SUPPLIER_ID, CONTACT_NAME, CONTACT_INFO, IS_CONTACTABLE) VALUES (?, ?, ?, 0);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, supplier.getSupplierId());
			pStmt.setString(2, newContact.getContactName());
			pStmt.setString(3, newContact.getContactInfo());
			if(pStmt.executeUpdate() != 0){
				isAdded = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return isAdded;
	}

	public static ArrayList<Supplier> getAllSupplier(){
		ArrayList<Supplier> suppliers = new ArrayList<>();
		String sql = "SELECT SUPPLIER_ID, SUPPLIER_NAME, COMPANY_CONTACT_INFO FROM SUPPLIER WHERE ACTIVE = TRUE;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Supplier supplier = new Supplier(rs.getInt(1), rs.getString(2), rs.getString(3));
				suppliers.add(supplier);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return suppliers;
	}

}
