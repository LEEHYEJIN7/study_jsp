package co.kr.ucs.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import co.kr.ucs.bean.BoardBean;
import co.kr.ucs.dao.DBManager;

public class BoardService {
	//게시물 등록	
	public int insertText(String title, String userId, String content){
		Connection conn=DBManager.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int check=0;
		try{
			String sql="Insert into board(seq, title, CONTENTS, reg_id, reg_date, mod_id, MOD_DATE) values((select nvl(max(seq),0)+1 from board), ?, ?, ?, sysdate, ?, sysdate)";
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
	
	//총 게시물 수 조회
	public int countBoard() {
		Connection conn=DBManager.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			String sql2="select count(*) from board";
			pstmt=conn.prepareStatement(sql2);
			rs=pstmt.executeQuery();
			if(rs.next()) count=rs.getInt(1);	// 총 게시물 수
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(rs);
			DBManager.close(pstmt);
			DBManager.close(conn);
		}
		return count;
	}
	
	//리스트 조회	//////+검색 기능 추가하기
	public List<BoardBean> selectBoardList(int startRow, int endRow){
		Connection conn=DBManager.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardBean> list=new ArrayList<BoardBean>();
		
		try {
			String sql = "SELECT * FROM (SELECT ROWNUM AS rnum, A.* FROM (SELECT * FROM BOARD ORDER BY SEQ DESC) A) b WHERE b.rnum >=? AND b.rnum <=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean board=new BoardBean();
				board.setSeq(rs.getInt("seq"));
				board.setTitle(rs.getString("title"));
				board.setContents(rs.getString("contents"));
				board.setRegId(rs.getString("reg_id"));
				board.setRegDate(rs.getDate("reg_date"));
				board.setModId(rs.getString("mod_id"));
				board.setModDate(rs.getDate("mod_date"));
				list.add(board);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(rs);
			DBManager.close(pstmt);
			DBManager.close(conn);
		}		
		return list;
	}
	
	//게시물 조회
	public List<BoardBean> selectContents(int seq){
		Connection conn=DBManager.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardBean> list=new ArrayList<BoardBean>();
		
		System.out.println("******selectContents************");
		try {
			String sql = "SELECT b.seq, b.title, u.user_nm, b.reg_date, b.contents FROM board b, cm_user u where b.seq=? and u.user_id=b.reg_id";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, seq);
			rs = pstmt.executeQuery();	
			while(rs.next()) {
				BoardBean board=new BoardBean();
				board.setSeq(rs.getInt("seq"));
				board.setTitle(rs.getString("title"));
				board.setRegId(rs.getString("user_nm"));
				board.setRegDate(rs.getDate("reg_date"));
				board.setContents(rs.getString("contents"));
				list.add(board);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(rs);
			DBManager.close(pstmt);
			DBManager.close(conn);
		}
		return list;
	}
}