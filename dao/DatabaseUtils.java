package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DatabaseUtils {

	private static final String DRIVER_NAME = "com.mysql.jdbc.Driver";
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/db_appdev_updated";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "yuta";

	public static Connection retrieveConnection(){
		Connection conn = null;
		try{
			Class.forName(DRIVER_NAME);
			conn = DriverManager.getConnection(JDBC_URL, DB_USER, "");
			return conn;
		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}

	public static String getPasswordFunc(String text){
		String password = text;
		Connection conn = retrieveConnection();
		String sql = "SELECT PASSWORD(?);";
		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, text);
			ResultSet rs = pStmt.executeQuery();
			while(rs.next()){
				password = rs.getString(1);
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
		return password;
	}


	public static void main(String[] args){
		Connection conn = retrieveConnection();
	}
}
