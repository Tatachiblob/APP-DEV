package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Branch;

import model.ContactPerson;
import model.Stock;

public class BranchDAO {

	public static boolean addNewBranch(Branch newBranch){
		boolean isAdded = false;
		String sql = ";";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{

		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{

				}catch(Exception e){}
			}
		}
		return isAdded;
	}

	public static Branch getBranchByName(String branchName){
		Branch branch = null;
		String sql = "SELECT * FROM branch WHERE br_name = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, branchName);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				branch = new Branch(rs.getInt(1),rs.getInt(4),rs.getString(2),rs.getString(3));
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
		return branch;
	}
        
        public static Branch getBranchofBranchManager(int empID){
		Branch branch = new Branch();
		String sql = "SELECT B.BR_ID, B.BR_NAME, B.BR_ADDR FROM EMP_BR EB JOIN BRANCH B ON EB.BR_ID = B.BR_ID WHERE EB.EMP_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, empID);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
                            branch.setBranchId(rs.getInt(1));
                            branch.setBranchName(rs.getString(2));
                            branch.setBranchAddress(rs.getString(3));
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
		return branch;
	}

	public static Branch getBranchById(int branchID){
		Branch branch = null;
		String sql = "SELECT * FROM branch WHERE br_id = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, branchID);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				branch = new Branch(rs.getInt(1),rs.getInt(4),rs.getString(2),rs.getString(3));
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
		return branch;
	}

	public static ArrayList<Branch> getAllBranch(){
		ArrayList<Branch> branches = new ArrayList<>();
		String sql = "SELECT * FROM BRANCH;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();
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
        
        public static ArrayList<Branch> getAllBranchofCom(int comID){
		ArrayList<Branch> branches = new ArrayList<>();
		String sql = "SELECT * FROM BRANCH WHERE COM_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
                        pStmt.setInt(1, comID);
			ResultSet rs = pStmt.executeQuery();
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
        
        public static ArrayList<Stock> getStocksbyBranchID(int branchID){
		ArrayList<Stock> stocks = new ArrayList<>();
		String sql = "SELECT BI.STOCK_ID, BI.current_qty, S.ceil_level, S.floor_level, S.stock_name, S.stock_unit FROM br_inventory BI JOIN stock S ON BI.stocK_id = S.stock_id WHERE BI.br_id = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
                        //Get all stocks of PASSED BRANCH
			PreparedStatement pStmt = conn.prepareStatement(sql);
                        pStmt.setInt(1, branchID);
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
        public static ArrayList<Stock> getStocksbyBranchManager(int empID){
		ArrayList<Stock> stocks = new ArrayList<>();
		String sql = "SELECT BI.STOCK_ID, BI.CURRENT_QTY, S.STOCK_NAME, S.STOCK_UNIT, S.FLOOR_LEVEL, S.CEIL_LEVEL FROM EMP_BR EB"
                             + "JOIN BR_INVENTORY BI ON EB.BR_ID = BI.BR_ID JOIN STOCK S ON BI.STOCK_ID = S.STOCK_ID WHERE EB.EMP_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
                        //Get all stocks of PASSED BRANCH
			PreparedStatement pStmt = conn.prepareStatement(sql);
                        pStmt.setInt(1, empID);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Stock thisStock = new Stock();
				thisStock.setStockId(rs.getInt(1));
                                thisStock.setQty(rs.getInt(2));
                                thisStock.setName(rs.getString(3));
                                thisStock.setUnit(rs.getString(4));
                                thisStock.setFloorLvl(rs.getInt(5));
                                thisStock.setCeilLvl(rs.getInt(6));
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

}
