package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Inventory;
import model.RequisitionOrder;

public class RequisitionDAO {

	public static ArrayList<RequisitionOrder> getYesterDayRequisition(int comId){
		ArrayList<RequisitionOrder> reqOrders = new ArrayList<>();
		String sql = "SELECT RO.REQ_ID, B.BR_ID FROM BRANCH B JOIN REQUISITION_ORDER RO ON B.BR_ID = RO.BR_ID JOIN COMMISSARY C ON B.COM_ID = C.COM_ID WHERE DATE(RO.RECORD_DATE) = DATE(NOW()) - 1 AND C.COM_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				RequisitionOrder ro = new RequisitionOrder();
				ro.setReqId(rs.getInt(1));
				ro.setReqDetails(getOrderDetails(rs.getInt(1)));
				ro.setBranch(DepartmentDAO.getBrById(rs.getInt(2)));
				reqOrders.add(ro);
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
		return reqOrders;
	}

	public static ArrayList<Inventory> getOrderDetails(int reqId){
		ArrayList<Inventory> orderDetails = new ArrayList<>();
		String sql = "SELECT STOCK_ID, QTY_REQUESTED FROM REQUISITIONDETAILS WHERE REQ_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, reqId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Inventory i = new Inventory(StockDAO.getStockById(rs.getInt(1)), rs.getDouble(2));
				orderDetails.add(i);
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
		return orderDetails;
	}

}
