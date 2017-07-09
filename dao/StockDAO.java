package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Stock;
public class StockDAO {
    public static boolean addNewStock(Stock newStock){
		boolean isAdded = false;
		Connection conn = DatabaseUtils.retrieveConnection();
		String sql = "INSERT INTO STOCK (STOCK_NAME, STOCK_UNIT, FLOOR_LEVEL) VALUES (?, ?, ?);";

		try{
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, newStock.getName());
			pStmt.setString(2, newStock.getUnit());
			pStmt.setFloat(3, newStock.getFloorLvl());

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
}
