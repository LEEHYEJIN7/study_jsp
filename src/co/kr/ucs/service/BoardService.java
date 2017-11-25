package co.kr.ucs.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import co.kr.ucs.dao.DBManager;

public class BoardService {
	//게시물 등록	
	public int insertText(String title, String userId, String content){
		Connection conn=DBManager.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int check=0;
		try{
			String sql="Insert into board values((select max(seq)+1 from board), ?, ?, ?, sysdate, ?, sysdate)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, userId);
			pstmt.setString(4, userId);
			
			check=pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(pstmt);
			DBManager.close(conn);
		}
		
		return check;
	}	
	
	//리스트 조회
	
	
	//게시물 조회
}