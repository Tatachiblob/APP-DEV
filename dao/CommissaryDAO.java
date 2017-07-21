package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import model.Branch;

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
        
        public static ArrayList<Stock> getStocks(int empID){
		ArrayList<Stock> stocks = new ArrayList<>();
                String getCOM = "SELECT com_id FROM emp_com WHERE emp_id = ?;";
		String sql = "SELECT CI.stock_id, CI.current_qty, S.stock_unit, S.stock_name FROM com_inventory CI JOIN stock S ON CI.stock_id = S.stock_id WHERE com_id = ?";
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
                                thisStock.setUnit(rs.getString(3));
                                thisStock.setName(rs.getString(4));
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
