package co.kr.ucs.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLTimeoutException;

import co.kr.ucs.dao.DBConnectionPool;
import co.kr.ucs.dao.DBConnectionPoolManager;
import co.kr.ucs.dao.DBManager;

public class SignService {
	DBConnectionPoolManager dbPoolManager=DBConnectionPoolManager.getInstance();
	DBConnectionPool dbPool;
	
	public SignService() {
		dbPoolManager.setDBPool(DBManager.getUrl(), DBManager.getId(), DBManager.getPw());
		dbPool=dbPoolManager.getDBPool();
	}
	
	//아이디 중복체크
	public int idCheck(String userId) throws SQLTimeoutException{
		int check=0;
		Connection conn=dbPool.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try{
			String sql="select * from CM_USER where USER_ID=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userId);			
			rs=pstmt.executeQuery();
			
			if(rs.next()) check=1;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dbPool.freeConnection(conn);
			DBManager.close(rs);
			DBManager.close(pstmt);
			DBManager.close(conn);
		}
		
		return check;
	}
	
	//회원가입
	public void signUp(String id, String pw, String name, String email) throws SQLTimeoutException{
		Connection conn=dbPool.getConnection();
		PreparedStatement pstmt=null;
		
		try{
			String sql="insert into CM_USER(user_id, user_pw, user_nm, email) values (?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dbPool.freeConnection(conn);
			DBManager.close(pstmt);
			DBManager.close(conn);
		}
	}
	
	//로그인
	public int signIn(String id, String pw) throws SQLTimeoutException{
		System.out.println("*****SignService.signIn********" + id + ", " + pw);
		int check=0;
		Connection conn=dbPool.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try{
			String sql="select * from CM_USER where USER_ID=? and USER_PW=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);		
			pstmt.setString(2, pw);
			rs=pstmt.executeQuery();
			
			if(rs.next()) check=1;
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dbPool.freeConnection(conn);
			DBManager.close(rs);
			DBManager.close(pstmt);
			DBManager.close(conn);
		}
		
		return check;
	}
		
}
