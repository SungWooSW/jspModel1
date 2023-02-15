package dao;

import java.sql.*;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {
	// singleton으로 만든다. 어디서든 접근이 가능하도록!
	private static MemberDao dao = null;
	
	private MemberDao() {
		DBConnection.initConnection();
	}
	
	public static MemberDao getInstance() {
		if(dao == null) {
			dao = new MemberDao();
		}
		return dao;
	}
	
	public boolean getId(String id) {
		
		String sql = " select id "
				+ "    from member"
				+ "    where id=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean findid = false;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId success"); // 성공했는지 중간중간 확인되도록 표시
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id); // ? 위치에 id 대입
			System.out.println("2/3 getId success");

			
			rs = psmt.executeQuery();
			System.out.println("3/3 getId success");

			if(rs.next()) {    // 결과 테이블(집합)에 다음 레코드(결과)가 존재한다면,
				findid = true;  // 매개변수 id값과 동일한 id가 존재한다.
			}
			
		} catch (SQLException e) {
			System.out.println("getId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return findid;

	}
	public boolean addMember(MemberDto dto) {
		
		String sql = " insert into member(id, pwd, name, email, auth)  "
				+ "    values(?, ?, ?, ?, 3) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addMember success");
			psmt = conn.prepareStatement(sql);
		
			psmt.setString(1, dto.getId()); // 첫 번째 ?
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail()); // 네 번째 ?
			System.out.println("2/3 addMember success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addMember success");
			
		} catch (SQLException e) {
			System.out.println("addMember fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false; // count > 0이면 회원정보가 추가되어 회원가입 성공
	}
	
	public MemberDto login(String id, String pwd) {
		
		String sql = " select id, name, email, auth  "
				+ "    from member "
				+ "    where id=? and pwd=?  ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto mem = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 login success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id); // where id=? and pwd=? 에서 첫번째 ?
			psmt.setString(2, pwd); // where id=? and pwd=? 에서 두번째 ?
			System.out.println("2/3 login success");

			rs = psmt.executeQuery();
			System.out.println("3/3 login success");
			
			// 매개변수로 받은 id와 pwd와 일치하는 회원정보 객체를 mem이라는 변수가 참조
			// 회원 1명에 대한 정보이므로 if(rs.next)를 사용
			if(rs.next()) {
				String _id = rs.getString("id"); // rs.getString("1") select문(select id, name, email, auth)에서 첫번째
				String _name = rs.getString("name"); // rs.getString("2")
				String _email= rs.getString("email"); // rs.getString("3")
				int _auth= rs.getInt("auth"); // rs.getString("4")
				
				mem = new MemberDto(_id, null, _name, _email, _auth);
			}
			
		} catch (SQLException e) {
			System.out.println("login fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
				
		return mem;
	}
}
