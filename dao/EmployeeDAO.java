package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;

public class EmployeeDAO {

	public static User getUser(String userName, String password){
		User checkLogin = null;
		Connection conn = DatabaseUtils.retrieveConnection();
		String sql = "SELECT * FROM EMPLOYEE WHERE USER_NAME = ? AND PASSWORD = ?;";

		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, userName);
			pStmt.setString(2, password);
			ResultSet rs = pStmt.executeQuery();

			while(rs.next()){
				checkLogin = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
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

}
