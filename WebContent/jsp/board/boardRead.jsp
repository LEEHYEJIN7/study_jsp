<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">	
 	body{ font-size:14px; }
	
	#box{
		width:800px;
		margin:200px auto;
		border:0px red solid;
	}
	
	table{
		border:1px solid #cccccc;
		border-spacing:0px;
		width:100%;
	}
	table tr th, td{
		height: 40px; text-align: center; padding-left: 5px; padding-right: 15px;
		border: 1px solid #cccccc;
	}
	
	.btns{
		text-align:center; margin-top: 15px;
	}
	
</style>
<%
	String url="jdbc:oracle:thin:@220.76.203.39:1521:UCS";
	String id="UCS_STUDY";
	String pw="qazxsw";
	
	int seq=Integer.parseInt(request.getParameter("seq"));
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	Connection conn=DriverManager.getConnection(url, id, pw);
	
	String sql = "SELECT b.seq, b.title, u.user_nm, b.reg_date, b.contents FROM board b, cm_user u where b.seq=? and u.user_id=b.reg_id";
	PreparedStatement pstmt=conn.prepareStatement(sql);
	pstmt.setInt(1, seq);
	ResultSet rs = pstmt.executeQuery();
	
%>
</head>
<body>
	<div id="box">
		<h2>◎ 게시판 입력</h2>
		<form name="boardForm">
			<table>
				<colgroup>
					<col width="150px"/>
					<col width="*"/>
					<col width="150px"/>
					<col width="*"/>
				</colgroup>
				<%if(rs.next()){ %>
				<tr>
					<th>작성자</th>
					<td><%=rs.getString("user_nm") %></td>
					<th>작성일</th>
					<td><%=rs.getDate("reg_date")%></td>
				</tr>
				
				<tr>
					<th>제목</th>
					<td colspan="3" style="text-align: left;"><%=rs.getString("title")%></td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td colspan="3" style="text-align: left; height: 300px; vertical-align: top;"><%=rs.getString("contents")%></td>
				</tr><tr><%} %>
			</table>
			
			<div class="btns">
				<input type="button" value="뒤로" onclick="location.href='boardList.jsp'"/>
			</div>
		</form>
	</div>
</body>
</html>