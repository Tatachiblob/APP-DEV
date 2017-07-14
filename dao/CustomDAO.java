package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.InventoryStatus;

public class CustomDAO {

	public static ArrayList<InventoryStatus> getComInventoryStatus(int comId){
		ArrayList<InventoryStatus> stats = new ArrayList<>();
		String sql = "SELECT C.COM_NAME, S.STOCK_NAME, CI.CURRENT_QTY, S.STOCK_UNIT, CASE WHEN CI.CURRENT_QTY = 0 THEN 'Out of Stock' WHEN CI.CURRENT_QTY > 0 AND CI.CURRENT_QTY <= S.FLOOR_LEVEL THEN 'Low In Stock' WHEN CI.CURRENT_QTY > S.FLOOR_LEVEL AND CI.CURRENT_QTY <= S.CEIL_LEVEL THEN 'In Stock' WHEN CI.CURRENT_QTY > S.CEIL_LEVEL THEN 'Over Stock' END AS STOCK_STATUS FROM COM_INVENTORY AS CI JOIN STOCK AS S ON CI.STOCK_ID = S.STOCK_ID JOIN COMMISSARY AS C ON CI.COM_ID = C.COM_ID WHERE CI.COM_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				stats.add(new InventoryStatus(rs.getString(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5)));
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
		return stats;
	}

	public static ArrayList<InventoryStatus> getBrInventoryStatus(int brId){
		ArrayList<InventoryStatus> stats = new ArrayList<>();
		String sql = "SELECT B.BR_NAME, S.STOCK_NAME, BR.CURRENT_QTY, S.STOCK_UNIT,CASE WHEN BR.CURRENT_QTY = 0 THEN 'Out of Stock' WHEN BR.CURRENT_QTY > 0 AND BR.CURRENT_QTY <= S.FLOOR_LEVEL THEN 'Low In Stock' WHEN BR.CURRENT_QTY > S.FLOOR_LEVEL AND BR.CURRENT_QTY <= S.CEIL_LEVEL THEN 'In Stock' WHEN BR.CURRENT_QTY > S.CEIL_LEVEL THEN 'Over Stock' END AS STOCK_STATUS FROM BR_INVENTORY AS BR JOIN STOCK AS S ON BR.STOCK_ID = S.STOCK_ID JOIN BRANCH AS B ON BR.BR_ID = B.BR_ID WHERE BR.BR_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, brId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				stats.add(new InventoryStatus(rs.getString(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5)));
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
		return stats;
	}

	public static void main(String[] args){
		for(InventoryStatus is : getComInventoryStatus(1000)){
			System.out.println("COM_NAME: " + is.getDeptName());
			System.out.println("STOCK_NAME: " + is.getStockName());
			System.out.println("CURRENT_QTY: " + is.getCurrentQty());
			System.out.println("STOCK_UNIT: " + is.getStockUnit());
			System.out.println("STOCK_STATUS: " + is.getStockStatus());
			System.out.println("----------------------------------------------------------");
		}
		System.out.println("++++++++++++++++++++++++++++++++++++++++");
		for(InventoryStatus is : getBrInventoryStatus(1100)){
			System.out.println("BR_NAME: " + is.getDeptName());
			System.out.println("STOCK_NAME: " + is.getStockName());
			System.out.println("CURRENT_QTY: " + is.getCurrentQty());
			System.out.println("STOCK_UNIT: " + is.getStockUnit());
			System.out.println("STOCK_STATUS: " + is.getStockStatus());
			System.out.println("----------------------------------------------------------");
		}
	}
}
