package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import model.Stock;
import model.Supplier;
public class StockDAO {

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
        
    public static Stock getStockByID(int stockID){
		Stock stock = null;
		String sql = "SELECT STOCK_ID, STOCK_NAME, STOCK_UNIT, FLOOR_LEVEL, CEIL_LEVEL FROM STOCK WHERE STOCK_ID = ?";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, stockID);
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
        public static ArrayList<Stock> getStocks(int empID){
		ArrayList<Stock> stox = new ArrayList<>();
                String getCOM = "SELECT com_id FROM emp_com WHERE emp_id = ?;";
		String sql = "SELECT CI.stock_id, S.stock_name, CI.current_qty, S.floor_level, S.ceil_level FROM com_inventory CI JOIN stock S ON CI.stock_id = S.stock_id WHERE com_id = ? ORDER BY S.stock_name;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
                        PreparedStatement pStmt = conn.prepareStatement(getCOM);
                        pStmt.setInt(1, empID);
			ResultSet rs = pStmt.executeQuery();
                        int comID = 0;
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        Date date = new Date();
                        System.out.println(dateFormat.format(date));
			
                        while(rs.next()){
				comID = rs.getInt(1);
			}
                    
			pStmt = conn.prepareStatement(sql);
                        pStmt.setInt(1, comID);
			rs = pStmt.executeQuery();
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
         public static ArrayList<Stock> getStocksfromSupp(int empID, int suppID){
		ArrayList<Stock> stox = new ArrayList<>();
                String getCOM = "SELECT com_id FROM emp_com WHERE emp_id = ?;";
		String sql = "SELECT CI.stock_id, S.stock_name, CI.current_qty, S.floor_level, S.ceil_level FROM com_inventory CI JOIN stock S ON CI.stock_id = S.stock_id JOIN sup_stk SS ON S.stock_id = SS.stock_id WHERE com_id = ? AND supplier_id = ? ORDER BY S.stock_name;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
                        PreparedStatement pStmt = conn.prepareStatement(getCOM);
                        pStmt.setInt(1, empID);
			ResultSet rs = pStmt.executeQuery();
                        int comID = 0;
                        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        Date date = new Date();
                        System.out.println(dateFormat.format(date));
			
                        while(rs.next()){
				comID = rs.getInt(1);
			}
                    
			pStmt = conn.prepareStatement(sql);
                        pStmt.setInt(1, comID);
                        pStmt.setInt(2, suppID);
			rs = pStmt.executeQuery();
                        
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
        

        public static boolean receiveStock(int empID, int qty, int stockID, int suppID, int drID){
		boolean isAdded = false;
		Connection conn = DatabaseUtils.retrieveConnection();
                String getCOM = "SELECT com_id FROM emp_com WHERE emp_id = ?;";
		String sqlinventory = "UPDATE com_inventory SET current_qty = current_qty + ? WHERE com_id = ? AND stock_id = ?;";
                String sqldrdetail = "INSERT INTO sup_drdetails values(?,?,?);";
                String sqldrtest = "SELECT * FROM supplier_dr;";
		try{
                        //Getting the Commissary ID of the passed Employee ID
                        PreparedStatement pStmt = conn.prepareStatement(getCOM);
                        pStmt.setInt(1, empID);
                        ResultSet rs = pStmt.executeQuery();
                        int comID = 0;
                        while(rs.next()){
				comID = rs.getInt(1);
			}
                        
                        //INSERT NEW DELIVERY INTO DRDETAILS
                        pStmt = conn.prepareStatement(sqldrdetail);
                        pStmt.setInt(1, drID);
                        pStmt.setInt(2, stockID);
                        pStmt.setInt(3, qty);
                        int drdetAdded = pStmt.executeUpdate();
                        if(drdetAdded != 0){
                            isAdded = true;
                            }
                        
                        //INSERT INTO COM_INVENTORY
                        pStmt = conn.prepareStatement(sqlinventory);
                        pStmt.setInt(1, qty);
                        pStmt.setInt(2, comID);
                        pStmt.setInt(3, stockID);
                        
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
        
        public static int getMaxdrID(int empID, int suppID){
		
                int drID = 0;
		Connection conn = DatabaseUtils.retrieveConnection();
                String getCOM = "SELECT com_id FROM emp_com WHERE emp_id = ?;";
                String sqldr = "INSERT INTO supplier_dr (sup_id,com_id,received_date) values(?,?,NOW());";
                String drIDSQL = "SELECT MAX(sup_dr_id) FROM supplier_dr;";
                try{
                //Getting the Commissary ID of the passed Employee ID
                PreparedStatement pStmt = conn.prepareStatement(getCOM);
                pStmt.setInt(1, empID);
                ResultSet rs = pStmt.executeQuery();
                int comID = 0;
                while(rs.next()){
                    comID = rs.getInt(1);
		}
                
                //INSERT NEW DELIVERY INTO DR TABLE
                pStmt = conn.prepareStatement(sqldr);
                pStmt.setInt(1, suppID);
                pStmt.setInt(2, comID);
                pStmt.executeUpdate();    
                    
                pStmt = conn.prepareStatement(drIDSQL);
                rs = pStmt.executeQuery();
                while(rs.next()){
                    drID = rs.getInt(1);
                    }
                }
                catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
        return drID;
        }
    /*
    public static void main(String[] args){
    	Stock stock = getStockByName("Pork Loin");
    	System.out.println(stock.getStockId());
    }
    */
}
