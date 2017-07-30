package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Inventory;
import model.RequisitionOrder;

public class RequisitionDAO {

	public static void main(String[] args){
		System.out.println("All Requisition");
		for(RequisitionOrder r : getAllRequisitionByComID(1000)){
			System.out.println("Branch: " + r.getBranch().getBranchName());
			System.out.println("Record Date: " + r.getRecordDate() + " " + r.getRecordTime());
			System.out.println("------------------------------------");
		}
		System.out.println("Specific Requisition Order");
		RequisitionOrder ro = getSpecificRequisition(1);
		for(Inventory i : ro.getReqDetails()){
			System.out.println("Stock: " + i.getStock().getName());
			System.out.println("Quantity: " + i.getQuantity());
			System.out.println("------------------------------------");
		}
	}

	public static RequisitionOrder getSpecificRequisition(int reqId){
		RequisitionOrder req = new RequisitionOrder();
		ArrayList<Inventory> inventory = new ArrayList<>();
		String sql = "SELECT		RO.REQ_ID, RD.STOCK_ID, RD.QTY_REQUESTED "
						  + "FROM			REQUISITION_ORDER RO "
						  + "JOIN				REQUISITIONDETAILS RD ON RO.REQ_ID = RD.REQ_ID "
						  + "WHERE		RO.REQ_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, reqId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Inventory i = new Inventory();
				i.setStock(StockDAO.getStockById(rs.getInt(2)));
				i.setQuantity(rs.getDouble(3));
				inventory.add(i);
			}
			req.setReqDetails(inventory);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return req;
	}

	public static ArrayList<RequisitionOrder> getAllRequisitionByComID(int comId){
		ArrayList<RequisitionOrder> allReq = new ArrayList<>();
		String sql = "SELECT		RO.REQ_ID, B.BR_ID, DATE(RO.RECORD_DATE), TIME(RO.RECORD_DATE) "
						  + "FROM			(SELECT * FROM BRANCH WHERE COM_ID = ?) B "
						  + "JOIN				REQUISITION_ORDER RO ON B.BR_ID = RO.BR_ID "
						  + "ORDER BY	2, 3;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				RequisitionOrder r = new RequisitionOrder();
				r.setReqId(rs.getInt(1));
				r.setBranch(DepartmentDAO.getBrById(rs.getInt(2)));
				r.setRecordDate(rs.getString(3));
				r.setRecordTime(rs.getString(4));
				allReq.add(r);
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
		return allReq;
	}

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
