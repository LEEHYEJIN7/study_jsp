package co.kr.ucs.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBManager {
		private final static String url = "jdbc:oracle:thin:@220.76.203.39:1521:UCS";
		private final static String id  = "UCS_STUDY";
		private final static String pw  = "qazxsw";
	
		//DB연결
		public static Connection getConnection(){
			Connection conn=null;
			
			try{
				/*String url="jdbc:oracle:thin:localhose:1521:orcl";
				String id="hj";
				String pw="hyejin";*/
				
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn=DriverManager.getConnection(url,id,pw);
			}catch(Exception e){
				e.printStackTrace();
			}
			
			return conn;
		}
		
		//close : Connection, PreparedStatement, ResultSet close
		public static void close(Connection conn){
			if(conn!=null){
				try{
					conn.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
		}
		
		public static void close(PreparedStatement pstmt){
			if(pstmt!=null){
				try{
					pstmt.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
		}
		
		public static void close(ResultSet rs){
			if(rs!=null){
				try{
					rs.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
		}
		
		public static String getUrl() {
			return url;
		}

		public static String getId() {
			return id;
		}

		public static String getPw() {
			return pw;
		}
}
