package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Branch;
import model.Inventory;
import model.InventoryStatus;

public class CustomDAO {

	public static boolean addNewComDR(int comId, int brId){
		boolean isAdded = false;
		String sql = "INSERT INTO COMMISSARY_DR(COM_DR_ID, COM_ID, DESTINATION_BR, CREATION_DATE) VALUES (0, ?, ?, 0);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			pStmt.setInt(2, brId);
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

	public static int getLatestComDR(){
		int comDrId = -1;
		String sql = "SELECT MAX(COM_DR_ID) FROM COMMISSARY_DR;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				comDrId = rs.getInt(1);
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
		return comDrId;
	}

	public static void insertComDRDetails(int comDrId, ArrayList<Inventory> deliveryDetails){
		String sql = "INSERT INTO COM_DRDETAILS(COM_DR_ID, STOCK_ID, DELIVER_QTY) VALUES (?, ?, ?);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comDrId);
			for(Inventory i : deliveryDetails){
				pStmt.setInt(2, i.getStock().getStockId());
				pStmt.setDouble(3, i.getQuantity());
				int result = pStmt.executeUpdate();
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
	}

	public static ArrayList<Branch> getBranchByComID(int comId){
		ArrayList<Branch> branches = new ArrayList<>();
		String sql = "SELECT B.BR_ID FROM BRANCH B JOIN COMMISSARY C ON B.COM_ID = C.COM_ID WHERE C.COM_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				branches.add(DepartmentDAO.getBrById(rs.getInt(1)));
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
		return branches;
	}

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

	public static boolean createRequisition(int brId){
		boolean isCreated = false;
		String sql = "INSERT INTO REQUISITION_ORDER (BR_ID, RECORD_DATE) VALUES (?, NOW());";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, brId);
			if(pStmt.executeUpdate() != 0){
				isCreated = true;
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
		return isCreated;
	}

	//Sole purpose for getting the latest reqId for inserting into Req details.
	public static int getLatestRequisition(){
		int reqId = -1;
		String sql = "SELECT REQ_ID FROM REQUISITION_ORDER WHERE DATE(RECORD_DATE) = DATE(NOW());";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				reqId = rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch (Exception e) {}
			}
		}
		return reqId;
	}

	public static boolean insertRequisitionDetails(int reqId, ArrayList<Inventory> endingInventory){
		boolean isAdded = false;
		int count = 0;
		String sql = "INSERT INTO REQUISITIONDETAILS(REQ_ID, STOCK_ID, QTY_REQUESTED) VALUES (?, ?, ?);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			for(Inventory i : endingInventory){
				pStmt.setInt(1, reqId);
				pStmt.setInt(2, i.getStock().getStockId());
				pStmt.setDouble(3, i.getQuantity());
				if(pStmt.executeUpdate() != 0)
						count++;
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
		if(count == endingInventory.size())
			isAdded = true;
		return isAdded;
		}

}
