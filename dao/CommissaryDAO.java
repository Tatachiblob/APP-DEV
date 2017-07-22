package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import model.Branch;
import model.Commissary;

import model.Stock;
import model.Supplier;
public class CommissaryDAO {

        public static ArrayList<Branch> getAssignedBranches(int empID){
		ArrayList<Branch> branches = new ArrayList<>();
                String getCOM = "SELECT com_id FROM emp_com WHERE emp_id = ?;";
		String sql = "SELECT * FROM BRANCH WHERE COM_ID = ?;";
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
				Branch thisBranch = new Branch(rs.getInt(1),rs.getInt(4),rs.getString(2),rs.getString(3));
				branches.add(thisBranch);
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
        
        public static Commissary getCommissaryofEmployee(int empID){
		String sql = "SELECT C.com_id, C.com_name, C.com_addr FROM emp_com EC JOIN commissary C ON EC.com_id = C.com_id WHERE EC.emp_id = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
                Commissary thisCom = new Commissary();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
                        pStmt.setInt(1, empID);
			ResultSet rs = pStmt.executeQuery();
                        
			while(rs.next()){
				thisCom.setComId(rs.getInt(1));
                                thisCom.setComName(rs.getString(2));
                                thisCom.setComAddress(rs.getString(3));
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
		return thisCom;
	}
        
        public static int getMaxCommissaryInventoryID(){
		String sql = "SELECT MAX(COM_INVENTORY_ID) FROM COM_MONTHLY_INVENTORY";
		Connection conn = DatabaseUtils.retrieveConnection();
                int i = 0;
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();
                        
			while(rs.next()){
				i = rs.getInt(1);
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
		return i + 1;
	}
        
        public static boolean inventoryCount(int comID){
                boolean hasUpdated = false;
		String sql = "INSERT INTO COM_MONTHLY_INVENTORY (COM_ID) VALUES(?);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
                        pStmt.setInt(1, comID);
			hasUpdated = pStmt.execute();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return hasUpdated;
	}
        
        public static boolean inventoryCountItems(int cominvID, int stockID, int qty, int dqty, int adjustqty, int comID){
                boolean hasUpdated = false;
		String sql = "INSERT INTO MONTHLY_DETAILS VALUES(?,?,?,?);";
                String sqlcomInv = "UPDATE COM_INVENTORY SET CURRENT_QTY = ? WHERE STOCK_ID = ? AND COM_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
                        //Make changes monthly details table
			PreparedStatement pStmt = conn.prepareStatement(sql);
                        pStmt.setInt(1, cominvID);
                        pStmt.setInt(2, stockID);
                        pStmt.setInt(3, qty);
                        pStmt.setInt(4, dqty);
                        
			hasUpdated = pStmt.execute();
                        
                        //Make changes to com inventory table
                        pStmt = conn.prepareStatement(sqlcomInv);
                        pStmt.setInt(1, adjustqty);
                        pStmt.setInt(2, stockID);
                        pStmt.setInt(3, comID);
                        
                        hasUpdated = pStmt.execute();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return hasUpdated;
	}
        
        public static ArrayList<Stock> getStocks(int empID){
		ArrayList<Stock> stocks = new ArrayList<>();
                String getCOM = "SELECT com_id FROM emp_com WHERE emp_id = ?;";
		String sql = "SELECT CI.stock_id, CI.current_qty, S.ceil_level, S.floor_level, S.stock_unit, S.stock_name FROM com_inventory CI JOIN stock S ON CI.stock_id = S.stock_id WHERE com_id = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
                        //Get commissary ID
                        PreparedStatement pStmt = conn.prepareStatement(getCOM);
                        pStmt.setInt(1, empID);
			ResultSet rs = pStmt.executeQuery();
                        int comID = 0;
			
                        while(rs.next()){
				comID = rs.getInt(1);
			}
                        //Get all stocks of current commissary
			pStmt = conn.prepareStatement(sql);
                        pStmt.setInt(1, comID);
			rs = pStmt.executeQuery();
			while(rs.next()){
				Stock thisStock = new Stock();
				thisStock.setStockId(rs.getInt(1));
                                thisStock.setQty(rs.getInt(2));
                                thisStock.setCeilLvl(rs.getInt(3));
                                thisStock.setFloorLvl(rs.getInt(4));
                                thisStock.setUnit(rs.getString(5));
                                thisStock.setName(rs.getString(6));
				stocks.add(thisStock);
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
        
        public static ArrayList<Stock> getStocksbyComID(int comID){
		ArrayList<Stock> stocks = new ArrayList<>();
		String sql = "SELECT CI.stock_id, CI.current_qty, S.ceil_level, S.floor_level, S.stock_name, S.stock_unit FROM com_inventory CI JOIN stock S ON CI.stocK_id = S.stock_id WHERE CI.com_id = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
                        //Get all stocks of PASSED BRANCH
			PreparedStatement pStmt = conn.prepareStatement(sql);
                        pStmt.setInt(1, comID);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Stock thisStock = new Stock();
				thisStock.setStockId(rs.getInt(1));
                                thisStock.setQty(rs.getInt(2));
                                thisStock.setCeilLvl(rs.getInt(3));
                                thisStock.setFloorLvl(rs.getInt(4));
                                thisStock.setName(rs.getString(5));
                                thisStock.setUnit(rs.getString(6));
				stocks.add(thisStock);
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
 
        public static boolean sendStock(int empID, int qty, int stockID, int brID, int drID){
		boolean isAdded = false;
		Connection conn = DatabaseUtils.retrieveConnection();
                String getCOM = "SELECT com_id FROM emp_com WHERE emp_id = ?;";
		String sqlUpdateBranch = "UPDATE br_inventory SET current_qty = current_qty + ? WHERE br_id = ? AND stock_id = ?;";
                String sqlUpdateCom = "UPDATE com_inventory SET current_qty = current_qty - ? WHERE com_id = ? AND stock_id = ?;";
                String sqlDRdetail = "INSERT INTO com_drdetails values(?,?,?);";
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
                        pStmt = conn.prepareStatement(sqlDRdetail);
                        pStmt.setInt(1, drID);
                        pStmt.setInt(2, stockID);
                        pStmt.setInt(3, qty);
                        int drAdded = pStmt.executeUpdate();
                        if(drAdded != 0){
                            isAdded = true;
                            }
                        
                        //UPDATE BR_INVENTORY
                        pStmt = conn.prepareStatement(sqlUpdateBranch);
                        pStmt.setInt(1, qty);
                        pStmt.setInt(2, brID);
                        pStmt.setInt(3, stockID);
                        
                        int hasAdded = pStmt.executeUpdate();
                        if(hasAdded != 0){
                            isAdded = true;
                            }
                        
                        //UPDATE COM_INVENTORY
                        pStmt = conn.prepareStatement(sqlUpdateCom);
                        pStmt.setInt(1, qty);
                        pStmt.setInt(2, comID);
                        pStmt.setInt(3, stockID);
                        
                        hasAdded = pStmt.executeUpdate();
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
        
        public static int makeDR(int empID, int branchID){
		
                int drID = 0;
		Connection conn = DatabaseUtils.retrieveConnection();
                String getCOM = "SELECT com_id FROM emp_com WHERE emp_id = ?;";
                String sqldr = "INSERT INTO commissary_dr (com_id,destination_br,creation_date) values(?,?,NOW());";
                String drIDSQL = "SELECT MAX(com_dr_id) FROM commissary_dr;";
                try{
                //Getting the Commissary ID of the current Employee ID
                PreparedStatement pStmt = conn.prepareStatement(getCOM);
                pStmt.setInt(1, empID);
                ResultSet rs = pStmt.executeQuery();
                int comID = 0;
                while(rs.next()){
                    comID = rs.getInt(1);
		}
                
                //INSERT NEW DELIVERY INTO DR TABLE
                pStmt = conn.prepareStatement(sqldr);
                pStmt.setInt(1, comID);
                pStmt.setInt(2, branchID);
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
        
        
}
