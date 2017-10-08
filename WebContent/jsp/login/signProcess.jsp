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
	
	//아이디 중복체크
	private int idCheck(String userId){
		int check=0;
		Connection conn=this.getConnection();
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
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		
		return check;
	}
	
	//회원가입
	private void signUp(String id, String pw, String name, String email){
		Connection conn=this.getConnection();
		PreparedStatement pstmt=null;
		
		try{
			String sql="insert into CM_USER values (?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			this.close(pstmt);
			this.close(conn);
		}
	}
	
	//로그인
	private int signIn(String id, String pw){
		int check=0;
		Connection conn=this.getConnection();
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
			this.close(rs);
			this.close(pstmt);
			this.close(conn);
		}
		
		return check;
	}
	%>
	
	<%
		request.setCharacterEncoding("UTF-8");
		String process=request.getParameter("process");
		String userId=request.getParameter("userId");
		String userPw=request.getParameter("userPw");
		
		String msg="";
		String url="";
		
		if(process.equals("signup")){		// 회원가입
			if(idCheck(userId)==0){	// 중복된 아이디가 없는 경우 회원가입 함수 실행
				String userNm=request.getParameter("userNm");
				String email=request.getParameter("email");
				signUp(userId, userPw, userNm, email);
				
				msg="환영합니다!";
				url="signIn.jsp";
			}else{ // 중복된 아이디가 있어 회원가입 불가
				msg="가입할 수 없는 아이디입니다.";
				url="signUp.jsp";
			}
		}else{   // 로그인
			int loginCheck=signIn(userId, userPw);
			if(loginCheck==0){
				msg="아이디와 비밀번호를 확인해주세요.";
				url="signIn.jsp";
			}else{
				request.setAttribute("user_id", userId);
				msg="로그인 성공!";
				url="../board/boardList.jsp";
			}
			
		}
%>

<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>