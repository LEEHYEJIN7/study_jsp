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
	
	a{ text-decoration:none; color:black; }
	
 	body{ font-size:14px; margin:0px; }
	
	#box{
		width:800px;
		margin:200px auto;
		border:0px red solid;
	}
	
	.searchBox{
		width:600px; margin-bottom:10px;
		height:30px; line-height:30px;
	}
	
	.select{
		float:left;	width:150px;
		text-align:center;
		border:1px #cccccc solid;
	}
	
	.searchInput{
		float:left; width:250px;
		text-align:center;
		border:1px #cccccc solid;
		border-left:0px;
	}
	
	select, input[type=text]{ width:90%; height: 20px; }
	
	table{ border:1px #cccccc solid; border-spacing: 0px; width:100%; }
	
	table tr th, td {
		border: 1px solid #cccccc; height: 40px; 
		text-align: left; padding-left: 5px; padding-right: 15px;
	}
	
	#submitBtn{
		height:30px; margin-left:10px;
	}
		
	.page{ margin-top:20px; text-align:center; }
	
	.paging{
		width:40px;
		display:inline-block;
		text-align:center;
		border:1px solid black;
	}
</style>
<%
	String url="jdbc:oracle:thin:@220.76.203.39:1521:UCS";
	String id="UCS_STUDY";
	String pw="qazxsw";

	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	Connection conn=DriverManager.getConnection(url, id, pw);
	
	String sql = "SELECT * FROM BOARD ORDER BY seq DESC";
	PreparedStatement pstmt=conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
%>
</head>
<body>
	<div id="box">
		<h2>◎ 게시판 목록</h2>
		<div class="searchBox">
			<form name="searchForm">
					<div class="select">
						<select id="search">
							<option value="">제목</option>
							<option value="">글번호</option>
							<option value="">내용</option>
							<option value="">제목+내용</option>
						</select>
					</div>
					
					<div class="searchInput">
						<input type="text" id="searchInput"/>
					</div>
					
					<input type="submit" id="submitBtn" value="검색"/>
			</form>
		</div>
		<%
		while(rs.next()){

			int seq= rs.getInt("seq");
			String title = rs.getString("title");
			String mod_id = rs.getString("mod_id");
			String mod_date = rs.getString("mod_date");
		
		%>
		<div class="list">
			<table>
				<colgroup>
					<col width="80px"/>
					<col width="*"/>
					<col width="100px"/>
					<col width="100px"/>
				</colgroup>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
				<tr>
					<td><%=seq %></td>
					<td><%=title %></td>
					<td><%=mod_id %></td>
					<td><%=mod_date %></td>
				</tr>				
			</table>
		</div>
		<%
		}
		%>
		<div class="page">
			<a href="#" class="paging"> << </a>
			<a href="#" class="paging"> < </a>
			<a href="#"> 1 </a>
			<a href="#"> 2 </a>
			<a href="#"> 3 </a>
			<a href="#"> 4 </a>
			<a href="#"> 5 </a>
			<a href="#"> 6 </a>
			<a href="#"> 7 </a>
			<a href="#"> 8 </a>
			<a href="#"> 9 </a>
			<a href="#"> 10 </a>
			<a href="#" class="paging"> > </a>
			<a href="#" class="paging"> >> </a>
			
		</div>
	</div>
</body>
</html>