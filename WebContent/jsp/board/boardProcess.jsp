<%@page import="org.eclipse.jdt.internal.compiler.ast.ThrowStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%!
	//DB연결
	private static Connection getConnection(){
		Connection conn=null;
		
		try{
			String url="jdbc:oracle:thin:@220.76.203.39:1521:UCS";
			String id="UCS_STUDY";
			String pw="qazxsw";
			
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
	
	//게시물 등록	
	public int insertText(String title, String userId, String content){
		Connection conn=this.getConnection();
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
			this.close(pstmt);
			this.close(conn);
		}
		
		return check;
	}
	
%>
<script>

<%
	request.setCharacterEncoding("UTF-8");
	String title=request.getParameter("title");
	String userId=(String)session.getAttribute("user_id");
	String content=request.getParameter("content");
	
	int check=insertText(title, userId, content);
	
	if(check>0){
		%>
		alert("글 등록 성공");
		location.href="boardList.jsp";
	<%
	}else{
	%>
		alert("글 등록 실패");
	<%
	}
%>



</script>