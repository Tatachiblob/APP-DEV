package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Branch;
import model.Commissary;
import model.User;

public class DepartmentDAO {

	public static boolean updateEmpComToDate(int empId){
		boolean set = false;
		String sql = "UPDATE EMP_COM SET TO_DATE = NOW() WHERE TO_DATE IS NULL AND EMP_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, empId);
			int result = pStmt.executeUpdate();
			if(result != 0){
				set = true;
			}
		}catch(Exception e){
			e.printStackTrace();
			set = false;
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return set;
	}

	public static boolean updateEmpBrToDate(int empId){
		boolean set = false;
		String sql = "UPDATE EMP_BR SET TO_DATE = NOW() WHERE TO_DATE IS NULL and EMP_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, empId);
			int result = pStmt.executeUpdate();
			if(result != 0){
				set = true;
			}
		}catch(Exception e){
			e.printStackTrace();
			set = false;
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return set;
	}

	public static ArrayList<Branch> getAllBranch(){
		ArrayList<Branch> branches = new ArrayList<>();
		String sql = "SELECT BR_ID, BR_NAME, BR_ADDR FROM BRANCH;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Branch br = new Branch();
				br.setBranchId(rs.getInt(1));
				br.setBranchName(rs.getString(2));
				br.setBranchAddress(rs.getString(3));
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
		String sql = "SELECT COM_ID, COM_NAME, COM_ADDR FROM COMMISSARY;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				Commissary com = new Commissary();
				com.setComId(rs.getInt(1));
				com.setComName(rs.getString(2));
				com.setComAddress(rs.getString(3));
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

	public static Commissary getComById(String deptId){
		Commissary com = null;
		String sql = "SELECT COM_ID, COM_NAME, COM_ADDR FROM COMMISSARY WHERE PASSWORD(COM_ID) = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, deptId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				com = new Commissary(rs.getInt(1), rs.getString(2), rs.getString(3));
			}
		}catch(Exception e){
			e.printStackTrace();
			com = null;
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return com;
	}

	public static Commissary getComById(int deptId){
		Commissary com = null;
		String sql = "SELECT COM_ID, COM_NAME, COM_ADDR FROM COMMISSARY WHERE COM_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, deptId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				com = new Commissary(rs.getInt(1), rs.getString(2), rs.getString(3));
			}
		}catch(Exception e){
			e.printStackTrace();
			com = null;
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return com;
	}

	public static Branch getBrById(String deptId){
		Branch br = null;
		String sql = "SELECT BR_ID, BR_NAME FROM BRANCH WHERE PASSWORD(BR_ID) = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, deptId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				br = new Branch();
				br.setBranchId(rs.getInt(1));
				br.setBranchName(rs.getString(2));
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
		return br;
	}

	public static Branch getBrById(int deptId){
		Branch br = null;
		String sql = "SELECT BR_ID, BR_NAME FROM BRANCH WHERE BR_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, deptId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				br = new Branch();
				br.setBranchId(rs.getInt(1));
				br.setBranchName(rs.getString(2));
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
		return br;
	}

	public static ArrayList<User> employedUserDepartment(Commissary com){
		ArrayList<User> emps = new ArrayList<>();
		String sql = "SELECT EMP_ID FROM EMP_COM WHERE COM_ID = ? AND	TO_DATE IS NULL;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, com.getComId());
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				User emp = EmployeeDAO.getEmpById(rs.getInt(1));
				emps.add(emp);
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
		return emps;
	}

	public static ArrayList<User> employedUserDepartment(Branch br){
		ArrayList<User> emps = new ArrayList<>();
		String sql = "SELECT EMP_ID FROM EMP_BR WHERE BR_ID = ? AND	TO_DATE IS NULL;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, br.getBranchId());
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				User emp = EmployeeDAO.getEmpById(rs.getInt(1));
				emps.add(emp);
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
		return emps;
	}

	public static Branch getBranchByUserId(int empId){
		Branch br = null;
		ArrayList<Branch> branches = getAllBranch();
		String sql = "SELECT BR_ID FROM EMP_BR WHERE EMP_ID = ? AND TO_DATE IS NULL;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, empId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				br = new Branch();
				br.setBranchId(rs.getInt(1));
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
		for(Branch b : branches){
			if(b.getBranchId() == br.getBranchId())
				br = b;
		}
		return br;
	}

	public static Commissary getComByUserId(int empId){
		Commissary com = null;
		ArrayList<Commissary> coms = getAllCommissary();
		String sql = "SELECT COM_ID FROM EMP_COM WHERE EMP_ID = ? AND TO_DATE IS NULL;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, empId);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				com = new Commissary();
				com.setComId(rs.getInt(1));
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
		for(Commissary c : coms){
			if(c.getComId() == com.getComId())
				com = c;
		}
		return com;
	}
}