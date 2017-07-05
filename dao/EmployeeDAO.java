package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.User;

public class EmployeeDAO {

	public static boolean setEmployed(int empId){
		boolean setter = false;
		String sql = "UPDATE EMPLOYEE SET IS_EMPLOYED = '0' WHERE EMP_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, empId);
			int result = pStmt.executeUpdate();
			if(result != 0){
				setter = true;
			}
		}catch(Exception e){
			e.printStackTrace();
			setter = false;
		}finally{
			if(conn != null){
				try{
					conn.close();
				}catch(Exception e){}
			}
		}
		return setter;
	}

	public static String passFunction(String text){
		String encrypted = "";
		String sql = "SELECT PASSWORD(?) FROM EMPLOYEE LIMIT 1;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, text);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				encrypted = rs.getString(1);
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
		return encrypted;
	}

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
		String sql = "SELECT EMP_ID FROM EMPLOYEE WHERE USER_NAME = ? AND IS_EMPLOYED = TRUE;";
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

	public static ArrayList<User> getEmps(){
		ArrayList<User> employees = new ArrayList<>();
		String sql = "SELECT EMP_ID, USER_NAME, FIRST_NAME, LAST_NAME, USER_TYPE, IS_ACTIVE, IS_EMPLOYED, PASSWORD FROM EMPLOYEE;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				User emp = new User();
				emp.setEmpId(rs.getInt(1));
				emp.setUserName(rs.getString(2));
				emp.setFirstName(rs.getString(3));
				emp.setLastName(rs.getString(4));
				emp.setUserType(rs.getInt(5));
				emp.setIsActive(rs.getBoolean(6));
				emp.setIsEmployed(rs.getBoolean(7));
				emp.setPassword(rs.getString(8));
				employees.add(emp);
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
		return employees;
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
		String sql = "INSERT INTO EMP_BR (BR_ID, EMP_ID, FROM_DATE) VALUES (?, ?, NOW());";
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
		String sql = "INSERT INTO EMP_COM (COM_ID, EMP_ID, FROM_DATE) VALUES (?, ?, NOW());";
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

	public static boolean setNewEmployeePassword(User loginUser){
		boolean isChanged = false;
		String sql = "UPDATE EMPLOYEE SET PASSWORD = PASSWORD(?) WHERE EMP_ID = ?;";
		String sql2 = "UPDATE EMPLOYEE SET IS_ACTIVE = TRUE WHERE EMP_ID = ?;";
		Connection conn = DatabaseUtils.retrieveConnection();
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, loginUser.getPassword());
			pStmt.setInt(2, loginUser.getEmpId());
			int result = pStmt.executeUpdate();
			if(result != 0){
				pStmt = conn.prepareStatement(sql2);
				pStmt.setInt(1, loginUser.getEmpId());
				int result2 = pStmt.executeUpdate();
				if(result2 != 0){
					isChanged = true;
				}
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
		return isChanged;
	}

}
