package dao;

import java.sql.Connection;

import model.Supplier;

public class SupplierDAO {

	public static boolean addNewSupplier(Supplier newSupplier){
		boolean isAdded = false;
		String sql = "";
		Connection conn = DatabaseUtils.retrieveConnection();

		return isAdded;
	}

}
