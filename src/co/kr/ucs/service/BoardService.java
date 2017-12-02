package co.kr.ucs.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLTimeoutException;
import java.util.ArrayList;
import java.util.List;

import co.kr.ucs.bean.BoardBean;
import co.kr.ucs.dao.DBConnectionPool;
import co.kr.ucs.dao.DBConnectionPoolManager;
import co.kr.ucs.dao.DBManager;

public class BoardService {
	DBConnectionPoolManager dbPoolManager=DBConnectionPoolManager.getInstance();
	DBConnectionPool dbPool;
	
	public BoardService() {
		dbPoolManager.setDBPool(DBManager.getUrl(), DBManager.getId(), DBManager.getPw());
		dbPool=dbPoolManager.getDBPool();
	}
	
	//게시물 등록	
	public int insertText(String title, String userId, String content) throws SQLTimeoutException{
		Connection conn=null;
		PreparedStatement pstmt=null;
		int check=0;
		try{
			conn=dbPool.getConnection();
			StringBuffer sb=new StringBuffer();
			sb.append("Insert into board(seq, title, CONTENTS, reg_id, reg_date, mod_id, MOD_DATE) ");
			sb.append("values((select nvl(max(seq),0)+1 from board), ?, ?, ?, sysdate, ?, sysdate)");
			/*String sql="Insert into board(seq, title, CONTENTS, reg_id, reg_date, mod_id, MOD_DATE) "
					+ "values((select nvl(max(seq),0)+1 from board), ?, ?, ?, sysdate, ?, sysdate)";*/
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, userId);
			pstmt.setString(4, userId);
			
			System.out.println("insertText**** " + sb.toString());
			check=pstmt.executeUpdate();
			System.out.println("check**** " + check);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dbPool.freeConnection(conn);
			DBManager.close(pstmt);
			DBManager.close(conn);
		}
		
		return check;
	}	
	
	//총 게시물 수 조회
	public int countBoard() throws SQLTimeoutException {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			conn=dbPool.getConnection();
			String sql2="select count(*) from board";
			pstmt=conn.prepareStatement(sql2);
			rs=pstmt.executeQuery();
			if(rs.next()) count=rs.getInt(1);	// 총 게시물 수
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			dbPool.freeConnection(conn);
			DBManager.close(rs);
			DBManager.close(pstmt);
			DBManager.close(conn);
		}
		return count;
	}
	
	//리스트 조회	//////+검색 기능 추가하기
	public List<BoardBean> selectBoardList(int startRow, int endRow, String search, String searchInput) throws SQLTimeoutException{
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardBean> list=new ArrayList<BoardBean>();	
		
		try {
			conn=dbPool.getConnection();
			StringBuffer sb=new StringBuffer();
			sb.append("SELECT * FROM (SELECT ROWNUM AS rnum, A.* FROM (SELECT * FROM BOARD ");
			
			if(search!=null && searchInput!=null) {
				System.out.println("***검색****");
				if(search.equals("all")) {
					sb.append("WHERE TITLE LIKE '%" + searchInput + "%' OR CONTENTS LIKE '%" + searchInput+"%' ");
				}else if(search.equals("seq")){
					sb.append("WHERE seq=" + Integer.parseInt(searchInput));
				}else {
					sb.append("WHERE "+search+" LIKE '%" + searchInput + "%' ");
				}
			}			
			
			sb.append("ORDER BY SEQ DESC) A) b WHERE b.rnum >=? AND b.rnum <=?");
			
			System.out.println(sb.toString());
			pstmt=conn.prepareStatement(sb.toString());			
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
			dbPool.freeConnection(conn);
			DBManager.close(rs);
			DBManager.close(pstmt);
			DBManager.close(conn);
		}		
		return list;
	}
	
	//게시물 조회
	public List<BoardBean> selectContents(int seq) throws SQLTimeoutException{
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BoardBean> list=new ArrayList<BoardBean>();
		
		System.out.println("******selectContents************");
		try {
			conn=dbPool.getConnection();
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
			dbPool.freeConnection(conn);
			DBManager.close(rs);
			DBManager.close(pstmt);
			DBManager.close(conn);
		}
		return list;
	}
}