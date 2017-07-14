package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Inventory;
import model.Stock;
import model.Supplier;
public class StockDAO {

	public static ArrayList<Inventory> getBranchInventory(int brId){
		ArrayList<Inventory> inventory = new ArrayList<>();
		String sql = "SELECT S.STOCK_NAME, BI.CURRENT_QTY FROM BR_INVENTORY AS BI JOIN STOCK AS S ON BI.STOCK_ID = S.STOCK_ID WHERE BI.BR_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, brId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				inventory.add(new Inventory(getStockByName(rs.getString(1)), rs.getDouble(2)));
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
		return inventory;
	}

	public static Stock getStockByName(String stockName){
		Stock stock = null;
		String sql = "SELECT STOCK_ID, STOCK_NAME, STOCK_UNIT, FLOOR_LEVEL, CEIL_LEVEL FROM STOCK WHERE STOCK_NAME = ?";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, stockName);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				stock = new Stock(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getDouble(5));
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
		return stock;
	}

    public static boolean addNewStock(Stock newStock){
		boolean isAdded = false;
		Connection conn = DatabaseUtils.retrieveConnection();
		String sql = "INSERT INTO STOCK (STOCK_NAME, STOCK_UNIT, FLOOR_LEVEL, CEIL_LEVEL) VALUES (?, ?, ?, ?);";
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, newStock.getName());
			pStmt.setString(2, newStock.getUnit());
			pStmt.setDouble(3, newStock.getFloorLvl());
			pStmt.setDouble(4, newStock.getCeilLvl());
			int hasAdded = pStmt.executeUpdate();
			if(hasAdded != 0){
				isAdded = true;
			}
		}catch(Exception e){
			e.printStackTrace();
			isAdded = false;
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return isAdded;
	}

    public static boolean assignSupplier(Supplier supplier, Stock stock){
    	boolean isAssigned = false;
    	String sql = "INSERT INTO SUP_STK(SUPPLIER_ID, STOCK_ID) VALUES (?, ?);";
    	Connection conn = DatabaseUtils.retrieveConnection();
    	try{
    		PreparedStatement pStmt = conn.prepareStatement(sql);
    		pStmt.setInt(1, supplier.getSupplierId());
    		pStmt.setInt(2, stock.getStockId());
    		if(pStmt.executeUpdate() != 0){
    			isAssigned = true;
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
    	return isAssigned;
    }
}
