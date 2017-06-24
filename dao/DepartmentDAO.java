package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Branch;
import model.Commissary;

public class DepartmentDAO {

	public static ArrayList<Branch> getAllBranch(){
		ArrayList<Branch> branches = new ArrayList<>();
		String sql = "SELECT BR_ID, BR_NAME FROM BRANCH;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Branch br = new Branch();
				br.setBranchId(rs.getInt(1));
				br.setBranchName(rs.getString(2));
				branches.add(br);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{

				}catch(Exception e){}
			}
		}
		return branches;
	}

	public static ArrayList<Commissary> getAllCommissary(){
		ArrayList<Commissary> coms = new ArrayList<>();
		String sql = "SELECT COM_ID, COM_NAME FROM COMMISSARY;";
		Connection conn = DatabaseUtils.retrieveConnection();

		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();

			while(rs.next()){
				Commissary com = new Commissary();
				com.setComId(rs.getInt(1));
				com.setComName(rs.getString(2));
				coms.add(com);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return coms;
	}

	public static boolean addNewDepartment(Commissary newCommissary){
		String sql = "INSERT INTO COMMISSARY (COM_ID, COM_NAME, COM_ADDR) VALUES (0, ?, ?);";
		Connection conn = DatabaseUtils.retrieveConnection();
		boolean isInserted = false;
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, newCommissary.getComName());
			pStmt.setString(2, newCommissary.getComAddress());
			int result = pStmt.executeUpdate();
			if(result != 0){
				isInserted = true;
			}
		}catch(Exception e){
			e.printStackTrace();
			isInserted = false;
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){
					isInserted = false;
				}
			}
		}
		return isInserted;
	}

	public static boolean addNewDepartment(Branch newBranch){
		String sql = "INSERT INTO BRANCH (BR_ID, BR_NAME, BR_ADDR, COM_ID) VALUES (0, ?, ?, ?);";
		Connection conn = DatabaseUtils.retrieveConnection();
		boolean isInserted = false;
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, newBranch.getBranchName());
			pStmt.setString(2, newBranch.getBranchAddress());
			pStmt.setInt(3, newBranch.getComId());
			int result = pStmt.executeUpdate();
			if(result != 0){
				isInserted = true;
			}
		}catch(Exception e){
			e.printStackTrace();
			isInserted = false;
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){
					isInserted = false;
				}
			}
		}
		return isInserted;
	}

}
