package db;

import java.sql.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;


public class DBClose {

	public static void close(Connection conn, Statement psmt, ResultSet rs) {
		//사용순서와 반대로 close 함
		try {
			if(rs != null) {
				psmt.close();
			}
			if(psmt != null) {
				psmt.close();
			}
			if(conn != null) {	
				conn.close();
			}
		} catch (SQLException e) {				
			e.printStackTrace();
		}			
	}
	
	
	
}
