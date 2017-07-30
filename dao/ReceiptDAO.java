package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.ComDelivery;
import model.Inventory;
import model.PurchaseOrder;
import model.SupplierDRDetails;

public class ReceiptDAO {

	public static PurchaseOrder getPODetails(int poId, int comId){
		PurchaseOrder po = null;
		for(PurchaseOrder p : getAllPo(comId)){
			if(p.getPoId() == poId){
				po = p;
			}
		}
		ArrayList<Inventory> poDetails = new ArrayList<>();
		String sql = "SELECT		PD.STOCK_ID, PD.REQUEST_QTY "
						  + "FROM			PURCHASE_ORDER PO "
						  + "JOIN				PO_DETAILS PD ON PO.PO_ID = PD.PO_ID "
						  + "WHERE		PO.PO_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, poId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				poDetails.add(new Inventory(StockDAO.getStockById(rs.getInt(1)), rs.getDouble(2)));
			}
			po.setPoDetails(poDetails);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{

				}catch(Exception e){}
			}
		}
		return po;
	}

	public static ArrayList<PurchaseOrder> getAllPo(int comId){
		ArrayList<PurchaseOrder> allPo = new ArrayList<>();
		String sql = "SELECT		PO_ID, COM_ID, SUPPLIER_ID, DATE(CREATION_DATE), TIME(CREATION_DATE) "
						  + "FROM			PURCHASE_ORDER "
						  + "WHERE		COM_ID = ? "
						  + "ORDER BY	3, 4;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				PurchaseOrder po = new PurchaseOrder();
				po.setPoId(rs.getInt(1));
				po.setCom(DepartmentDAO.getComById(rs.getInt(2)));
				po.setSupplier(SupplierDAO.getSupplierById(rs.getInt(3)));
				po.setCreationDate(rs.getString(4));
				po.setCreationTime(rs.getString(5));
				allPo.add(po);
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
		return allPo;
	}

	public static ArrayList<PurchaseOrder> getAllPo(int comId, String startDate, String endDate){
		ArrayList<PurchaseOrder> allPo = new ArrayList<>();
		String sql = "SELECT		PO_ID, COM_ID, SUPPLIER_ID, DATE(CREATION_DATE), TIME(CREATION_DATE) "
				  + "FROM			PURCHASE_ORDER "
				  + "WHERE		COM_ID = ? "
				  + "AND				CREATION_DATE BETWEEN ? AND ? "
				  + "ORDER BY	3, 4;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			pStmt.setString(2, startDate);
			pStmt.setString(3, endDate);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				PurchaseOrder po = new PurchaseOrder();
				po.setPoId(rs.getInt(1));
				po.setCom(DepartmentDAO.getComById(rs.getInt(2)));
				po.setSupplier(SupplierDAO.getSupplierById(rs.getInt(3)));
				po.setCreationDate(rs.getString(4));
				po.setCreationTime(rs.getString(5));
				allPo.add(po);
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
		return allPo;
	}

	public static ArrayList<Inventory> getSpecificComDr(int comDrId){
		ArrayList<Inventory> deliveryDetails = new ArrayList<>();
		String sql = "SELECT		S.STOCK_ID, DELIVER_QTY, S.STOCK_NAME "
						  + "FROM			COM_DRDETAILS CD "
						  + "JOIN				STOCK S ON CD.STOCK_ID = S.STOCK_ID "
						  + "WHERE		COM_DR_ID = ? "
						  + "ORDER BY	S.STOCK_NAME;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comDrId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				deliveryDetails.add(new Inventory(StockDAO.getStockById(rs.getInt(1)), rs.getDouble(2)));
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
		return deliveryDetails;
	}

	public static ArrayList<ComDelivery> getAllComDelivery(int comId){
		ArrayList<ComDelivery> allComDr = new ArrayList<>();
		String sql = "SELECT		COM_DR_ID, DESTINATION_BR, DATE(CREATION_DATE), TIME(CREATION_DATE) "
						  + "FROM			COMMISSARY_DR "
						  + "WHERE		COM_ID = ? "
						  + "ORDER BY	2,3";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				ComDelivery dr = new ComDelivery();
				dr.setComDrId(rs.getInt(1));
				dr.setBranch(DepartmentDAO.getBrById(rs.getInt(2)));
				dr.setCreationDate(rs.getString(3));
				dr.setCreationTime(rs.getString(4));
				allComDr.add(dr);
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
		return allComDr;
	}

	public static ArrayList<Inventory> getSupplierDeliveryDetails(int supDrId){
		ArrayList<Inventory> deliveryDetails = new ArrayList<>();
		String sql = "SELECT		SD.SUP_DR_ID, S.STOCK_ID, SD.DELIVER_QTY, S.STOCK_NAME "
						 + "FROM			STOCK S "
						 + "JOIN				SUP_DRDETAILS SD ON S.STOCK_ID = SD.STOCK_ID "
						 + "WHERE 		SD.SUP_DR_ID = ? "
						 + "ORDER BY	S.STOCK_NAME;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, supDrId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				deliveryDetails.add(new Inventory(StockDAO.getStockById(rs.getInt(2)), rs.getDouble(3)));
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
		return deliveryDetails;
	}

	public static ArrayList<SupplierDRDetails> getAllSupplierDRByComId(int comId){
		ArrayList<SupplierDRDetails> allDr = new ArrayList<>();
		String sql = "SELECT 		SUP_DR_ID, SUP_ID, DATE(RECEIVED_DATE), TIME(RECEIVED_DATE) "
						 + "FROM 			SUPPLIER_DR "
						 + "WHERE 		COM_ID = ? "
						 + "ORDER BY	3, 4";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				SupplierDRDetails s = new SupplierDRDetails();
				s.setDrId(rs.getInt(1));
				s.setSupplier(SupplierDAO.getSupplierById(rs.getInt(2)));
				s.setReceivedDate(rs.getString(3));
				s.setReceivedTime(rs.getString(4));
				allDr.add(s);
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
		return allDr;
	}

}
