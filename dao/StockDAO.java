package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Inventory;
import model.Stock;
import model.Supplier;
public class StockDAO {

	public static ArrayList<Stock> getStockFromSupplier(int supId){
		ArrayList<Stock> stocks = new ArrayList<>();
		String sql = "SELECT STK.STOCK_ID FROM SUPPLIER S JOIN SUP_STK SS ON S.SUPPLIER_ID = SS.SUPPLIER_ID JOIN STOCK STK ON SS.STOCK_ID = STK.STOCK_ID WHERE S.SUPPLIER_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, supId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				stocks.add(getStockById(rs.getInt(1)));
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
		return stocks;
	}

	public static ArrayList<Stock> getStocksfromSupp(int empID, int suppID){
		ArrayList<Stock> stox = new ArrayList<>();
		int com = DepartmentDAO.getComByUserId(empID).getComId();
		String sql = "SELECT CI.stock_id, S.stock_name, CI.current_qty, S.floor_level, S.ceil_level FROM com_inventory CI JOIN stock S ON CI.stock_id = S.stock_id JOIN sup_stk SS ON S.stock_id = SS.stock_id WHERE com_id = ? AND supplier_id = ? ORDER BY S.stock_name;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, com);
			pStmt.setInt(2, suppID);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Stock thisStock = new Stock();
				thisStock.setStockId(rs.getInt(1));
				thisStock.setName(rs.getString(2));
				thisStock.setQty(rs.getInt(3));
				thisStock.setFloorLvl(rs.getDouble(4));
				thisStock.setCeilLvl(rs.getDouble(5));
				stox.add(thisStock);
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
		return stox;
	}

	public static ArrayList<Inventory> getComInventory(int comId){
		ArrayList<Inventory> inventory = new ArrayList<>();
		String sql = "SELECT S.STOCK_ID, CI.CURRENT_QTY FROM COM_INVENTORY AS CI JOIN STOCK AS S ON CI.STOCK_ID = S.STOCK_ID WHERE CI.COM_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, comId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				inventory.add(new Inventory(getStockById(rs.getInt(1)), rs.getDouble(2)));
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

	public static Stock getStockById(int stockId){
		Stock stock = null;
		String sql = "SELECT STOCK_ID, STOCK_NAME, STOCK_UNIT, FLOOR_LEVEL, CEIL_LEVEL FROM STOCK WHERE STOCK_ID = ?";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, stockId);
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
