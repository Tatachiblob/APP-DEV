package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Branch;
import model.ComDelivery;
import model.Commissary;
import model.MonthlyInventory;
import model.Stock;
import model.Supplier;
import model.SupplierDRDetails;

public class AuditDAO {

	public static void main(String[] args){
		System.out.println("Beign");
		System.out.println("Supplier DR");
		for(SupplierDRDetails s : getSupplierDRDetails(1000, 1)){
			System.out.println("Commissary: " + s.getCommissary().getComName());
			System.out.println("Supplier: " + s.getSupplier().getSupplierName());
			System.out.println("Stock: " + s.getStock().getName());
			System.out.println("Received Date: " + s.getReceivedDate());
			System.out.println("Received Time: "+ s.getReceivedTime());
			System.out.println("Received Quantity: " + s.getDeliverQty() + s.getStock().getUnit());
			System.out.println("----------------------------------------------------------");
		}
		System.out.println("Commissary DR");
		for(ComDelivery cd : getComDeliveryDetails(1000, 3)){
			System.out.println("Commissary: " + cd.getCommissary().getComName());
			System.out.println("Desination: " + cd.getBranch().getBranchName());
			System.out.println("Creation Date: " + cd.getCreationDate());
			System.out.println("Creation Time: " + cd.getCreationTime());
			System.out.println("Stock : " + cd.getStock().getName());
			System.out.println("Delivery Quantity: " + cd.getDeliverQty());
			System.out.println("----------------------------------------------------------");
		}
		System.out.println("Monthly Inventory");
		for(MonthlyInventory mi : getComMonthlyInventory(1000, 1) ){
			System.out.println("Commissary: " + mi.getCom().getComName());
			System.out.println("Record Date: " + mi.getRecordDate());
			System.out.println("Record Time: " + mi.getRecordTime());
			System.out.println("Stock: " + mi.getStock().getName());
			System.out.println("Actual Qty: " + mi.getActualQty());
			System.out.println("Discrepancy Qty: " + mi.getDiscrepancy());
			System.out.println("----------------------------------------------------------");
		}
		System.out.println(compareDates("2017-07-15", "2017-07-01"));
		System.out.println("End");
	}


	public static ArrayList<SupplierDRDetails> getSupplierDRDetails(int comId, int stockId){
		ArrayList<SupplierDRDetails> delivery = new ArrayList<>();
		String sql = "SELECT		SD.COM_ID, SD.SUP_DR_ID, S.SUPPLIER_ID, S.SUPPLIER_NAME, DATE(SD.RECEIVED_DATE), TIME(SD.RECEIVED_DATE), SDD.STOCK_ID, SDD.DELIVER_QTY "
						  + "FROM			SUPPLIER_DR SD "
						  + "JOIN				SUP_DRDETAILS SDD ON SD.SUP_DR_ID = SDD.SUP_DR_ID "
						  + "JOIN				SUPPLIER S ON SD.SUP_ID = S.SUPPLIER_ID "
						  + "WHERE		SD.COM_ID = ? AND SDD.STOCK_ID = ? "
						  + "AND 			DATE(SD.RECEIVED_DATE) BETWEEN DATE_FORMAT(NOW(), '%Y-%m-01') AND NOW();;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			pStmt.setInt(2, stockId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Commissary com = DepartmentDAO.getComById(rs.getInt(1));
				Supplier sup = SupplierDAO.getSupplierById(rs.getInt(3));
				String receivedDate = rs.getString(5);
				String receivedTime = rs.getString(6);
				Stock stock = StockDAO.getStockById(rs.getInt(7));
				double deliverQty = rs.getDouble(8);
				SupplierDRDetails dr = new SupplierDRDetails();
				dr.setCommissary(com);
				dr.setSupplier(sup);
				dr.setReceivedDate(receivedDate);
				dr.setReceivedTime(receivedTime);
				dr.setStock(stock);
				dr.setDeliverQty(deliverQty);
				delivery.add(dr);
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
		return delivery;
	}


	public static ArrayList<SupplierDRDetails> getSupplierDRDetails(int comId, int stockId, String startDate, String endDate){
		ArrayList<SupplierDRDetails> delivery = new ArrayList<>();
		String sql = "SELECT		SD.COM_ID, SD.SUP_DR_ID, S.SUPPLIER_ID, S.SUPPLIER_NAME, DATE(SD.RECEIVED_DATE), TIME(SD.RECEIVED_DATE), SDD.STOCK_ID, SDD.DELIVER_QTY "
						  + "FROM			SUPPLIER_DR SD "
						  + "JOIN				SUP_DRDETAILS SDD ON SD.SUP_DR_ID = SDD.SUP_DR_ID "
						  + "JOIN				SUPPLIER S ON SD.SUP_ID = S.SUPPLIER_ID "
						  + "WHERE		SD.COM_ID = ? AND SDD.STOCK_ID = ? "
						  + "AND				SD.RECEIVED_DATE BETWEEN ? AND ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			pStmt.setInt(2, stockId);
			pStmt.setString(3, startDate);
			pStmt.setString(4, endDate);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Commissary com = DepartmentDAO.getComById(rs.getInt(1));
				Supplier sup = SupplierDAO.getSupplierById(rs.getInt(3));
				String receivedDate = rs.getString(5);
				String receivedTime = rs.getString(6);
				Stock stock = StockDAO.getStockById(7);
				double deliverQty = rs.getDouble(7);
				SupplierDRDetails dr = new SupplierDRDetails();
				dr.setCommissary(com);
				dr.setSupplier(sup);
				dr.setReceivedDate(receivedDate);
				dr.setReceivedTime(receivedTime);
				dr.setStock(stock);
				dr.setDeliverQty(deliverQty);
				delivery.add(dr);
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
		return delivery;
	}

	public static ArrayList<ComDelivery> getComDeliveryDetails(int comId, int stockId){
		ArrayList<ComDelivery> comDelivery = new ArrayList<>();
		String sql = "SELECT		CD.COM_DR_ID, CD.COM_ID, CD.DESTINATION_BR, DATE(CD.CREATION_DATE), TIME(CD.CREATION_DATE), CDD.STOCK_ID, CDD.DELIVER_QTY "
						  + "FROM			COMMISSARY_DR CD "
						  + "JOIN				COM_DRDETAILS CDD ON CD.COM_DR_ID = CDD.COM_DR_ID "
						  + "WHERE		CD.COM_ID = ? AND STOCK_ID = ? "
						  + "AND				CD.CREATION_DATE BETWEEN DATE_FORMAT(NOW(), '%Y-%m-01') AND NOW() "
						  + "ORDER BY	DATE(CD.CREATION_DATE), TIME(CD.CREATION_DATE);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			pStmt.setInt(2, stockId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				ComDelivery comDr = new ComDelivery();
				Commissary com = DepartmentDAO.getComById(rs.getInt(2));
				Branch br = DepartmentDAO.getBrById(rs.getInt(3));
				String creationDate = rs.getString(4);
				String creationTime = rs.getString(5);
				Stock stock = StockDAO.getStockById(rs.getInt(6));
				double deliverQty = rs.getDouble(7);
				comDr.setBranch(br);
				comDr.setCommissary(com);
				comDr.setCreationDate(creationDate);
				comDr.setCreationTime(creationTime);
				comDr.setStock(stock);
				comDr.setDeliverQty(deliverQty);
				comDelivery.add(comDr);
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
		return comDelivery;
	}

	public static ArrayList<ComDelivery> getComDeliveryDetails(int comId, int stockId, String startDate, String endDate){
		ArrayList<ComDelivery> comDelivery = new ArrayList<>();
		String sql = "SELECT		CD.COM_DR_ID, CD.COM_ID, CD.DESTINATION_BR, DATE(CD.CREATION_DATE), TIME(CD.CREATION_DATE), CDD.STOCK_ID, CDD.DELIVER_QTY "
						  + "FROM			COMMISSARY_DR CD "
						  + "JOIN				COM_DRDETAILS CDD ON CD.COM_DR_ID = CDD.COM_DR_ID "
						  + "WHERE		CD.COM_ID = ? AND STOCK_ID = ? "
						  + "AND				CD.CREATION_DATE BETWEEN ? AND ? "
						  + "ORDER BY	DATE(CD.CREATION_DATE), TIME(CD.CREATION_DATE);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			pStmt.setInt(2, stockId);
			pStmt.setString(3, startDate);
			pStmt.setString(4, endDate);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				ComDelivery comDr = new ComDelivery();
				Commissary com = DepartmentDAO.getComById(rs.getInt(2));
				Branch br = DepartmentDAO.getBrById(rs.getInt(3));
				String creationDate = rs.getString(4);
				String creationTime = rs.getString(5);
				Stock stock = StockDAO.getStockById(rs.getInt(6));
				double deliverQty = rs.getDouble(7);
				comDr.setBranch(br);
				comDr.setCommissary(com);
				comDr.setCreationDate(creationDate);
				comDr.setCreationTime(creationTime);
				comDr.setStock(stock);
				comDr.setDeliverQty(deliverQty);
				comDelivery.add(comDr);
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
		return comDelivery;
	}

	public static ArrayList<MonthlyInventory> getComMonthlyInventory(int comId, int stockId){
		ArrayList<MonthlyInventory> comMonthly = new ArrayList<>();
		String sql = "SELECT		CMI.COM_INVENTORY_ID, CMI.COM_ID, CMI.YEARMONTH, TIME(CMI.TIME_STAMP), MD.STOCK_ID, MD.ACTUAL_QTY, MD.DISCREPANCY_QTY "
						  + "FROM			COM_MONTHLY_INVENTORY CMI "
						  + "JOIN				MONTHLY_DETAILS MD ON CMI.COM_INVENTORY_ID = MD.COM_INVENTORY_ID "
						  + "WHERE		COM_ID = ? AND STOCK_ID = ? "
						  + "ORDER BY	CMI.YEARMONTH, TIME(CMI.TIME_STAMP);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			pStmt.setInt(2, stockId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				MonthlyInventory month = new MonthlyInventory();
				month.setCom(DepartmentDAO.getComById(rs.getInt(2)));
				month.setRecordDate(rs.getString(3));
				month.setRecordTime(rs.getString(4));
				month.setStock(StockDAO.getStockById(rs.getInt(5)));
				month.setActualQty(rs.getDouble(6));
				month.setDiscrepancy(rs.getDouble(7));
				comMonthly.add(month);
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
		return comMonthly;
	}

	public static boolean compareDates(String startDate, String endDate){
		boolean isCorrect = false;
		String sql = "SELECT (? < ?);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, startDate);
			pStmt.setString(2, endDate);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				isCorrect = rs.getBoolean(1);
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
		return isCorrect;
	}

}
