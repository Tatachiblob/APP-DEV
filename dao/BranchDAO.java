package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Branch;

import model.ContactPerson;

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

}
