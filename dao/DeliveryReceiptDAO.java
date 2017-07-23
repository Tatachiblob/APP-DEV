package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Inventory;

public class DeliveryReceiptDAO {

	public static boolean addNewDeliveryReceipt(int supplierId, int comId){
		boolean isAdded = false;
		String sql = "INSERT INTO SUPPLIER_DR VALUES (0, ?, ?, 0);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, supplierId);
			pStmt.setInt(2, comId);
			int result = pStmt.executeUpdate();
			if(result != 0){
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

	public static int getLatestDrID(){
		int drId = -1;
		String sql = "SELECT MAX(SUP_DR_ID) FROM SUPPLIER_DR;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				drId = rs.getInt(1);
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
		return drId;
	}

	public static boolean insertDeliveryDetails(int supplierDrId, ArrayList<Inventory> details){
		boolean isAdded = false;
		String sql = "INSERT INTO SUP_DRDETAILS VALUES (?, ?, ?);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			int ctr = 0;
			PreparedStatement pStmt = conn.prepareStatement(sql);
			for(Inventory i : details){
				pStmt.setInt(1, supplierDrId);
				pStmt.setInt(2, i.getStock().getStockId());
				pStmt.setDouble(3, i.getQuantity());
				if(pStmt.executeUpdate() != 0){
					ctr++;
				}
			}
			if(ctr == details.size())
				isAdded = true;
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

}
