package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;

public class EmployeeDAO {

	public static boolean addNewUser(User newUser, int deptId){
		boolean isAdded = false;
		Connection conn = DatabaseUtils.retrieveConnection();
		String sql = "INSERT INTO EMPLOYEE (USER_NAME, PASSWORD, FIRST_NAME, LAST_NAME,  USER_TYPE, IS_ACTIVE, IS_EMPLOYED) VALUES (?, ?, ?, ?, ?, 0, 0);";

		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, newUser.getUserName());
			pStmt.setString(2, newUser.getPassword());
			pStmt.setString(3, newUser.getFirstName());
			pStmt.setString(4, newUser.getLastName());
			pStmt.setInt(5, newUser.getUserType());

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

	public static int getEmpID(String userName){
		int empId = -1;
		String sql = "SELECT EMP_ID FROM EMPLOYEE WHERE USER_NAME = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, userName);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				empId = rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
			empId = -1;
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return empId;
	}

	public static User getUser(String userName, String password){
		User checkLogin = null;
		Connection conn = DatabaseUtils.retrieveConnection();
		String sql = "SELECT * FROM EMPLOYEE WHERE USER_NAME = ? AND PASSWORD = PASSWORD(?);";

		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, userName);
			pStmt.setString(2, password);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				checkLogin = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
				checkLogin.setIsActive(rs.getBoolean(7));
				checkLogin.setIsEmployed(rs.getBoolean(8));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){
					e.printStackTrace();
					return null;
				}
			}
		}
		return checkLogin;
	}

	public static boolean assignEmplyeeBranch(int deptId, int empId){
		boolean isAssigned = false;
		String sql = "INSERT INTO EMP_BR (BR_ID, EMP_ID) VALUES (?, ?);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, deptId);
			pStmt.setInt(2, empId);
			if(pStmt.executeUpdate() != 0){
				isAssigned = true;
			}
		}catch(Exception e){
			e.printStackTrace();
			isAssigned = false;
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return isAssigned;
	}

	public static boolean assignEmployeeCom(int deptId, int empId){
		boolean isAssigned = false;
		String sql = "INSERT INTO EMP_COM (COM_ID, EMP_ID) VALUES (?, ?);";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, deptId);
			pStmt.setInt(2, empId);
			if(pStmt.executeUpdate() != 0){
				isAssigned = true;
			}
		}catch(Exception e){
			e.printStackTrace();
			isAssigned = false;
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
