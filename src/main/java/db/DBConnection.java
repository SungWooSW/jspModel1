package db;

import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	public static void initConnection() { // static이니까 언제든지 불러쓸 수 있다.
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버 로드하기
			System.out.println("Driver Loading Success");
		} catch (ClassNotFoundException e) {			
			System.out.println("DB Driver를 찾지 못했습니다");
			e.printStackTrace();
		}	
		
	}
	
	public static Connection getConnection() {
		
		Connection conn = null;	// Connection 객체를 생성
		try {
			// 연결할 url, 데이터베이스 ID, 데이터베이스 PW
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "1234");
			System.out.println("Connection Success");			
		} catch (SQLException e) {			
			System.out.println("db을 연결하지 못했습니다");
			e.printStackTrace();
		}	
		return conn;
	}
	
	
}
