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
	
	String pageNumber=request.getParameter("pageNumber");
	if(pageNumber==null) pageNumber="1";	
	int currentPage=Integer.parseInt(pageNumber);
	
	int pageBlock=10; // 하단에 보여질 페이지 수 (1~10)
	int boardSize=10; // 페이지에 보여지는 게시물 수 (10개)
	int startRow=(currentPage-1)*boardSize+1;
	int endRow=currentPage*boardSize;

	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	Connection conn=DriverManager.getConnection(url, id, pw);
	
	String sql = "SELECT * FROM (SELECT ROWNUM AS rnum, A.* FROM (SELECT * FROM BOARD ORDER BY SEQ DESC) A) b WHERE b.rnum >=? AND b.rnum <=?";
	PreparedStatement pstmt=conn.prepareStatement(sql);
	pstmt.setInt(1, startRow);
	pstmt.setInt(2, endRow);
	ResultSet rs = pstmt.executeQuery();
	
	String sql2="select count(*) from board";
	pstmt=conn.prepareStatement(sql2);
	ResultSet rs2=pstmt.executeQuery();
	int count=0;
	if(rs2.next()) count=rs2.getInt(1);	// 총 게시물 수
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
					<input type="button" id="writeBtn" value="글쓰기" onclick="location.href='boardWrite.jsp'"/>
			</form>
		</div>
		
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
		<%
		while(rs.next()){

			int seq= rs.getInt("seq");
			String title = rs.getString("title");
			String reg_id = rs.getString("reg_id");
			String reg_date = rs.getString("reg_date");
		
		%>
				<tr>
					<td><%=seq %></td>
					<td><a href='boardRead.jsp?seq=<%=seq%>'><%=title %></a></td>
					<td><%=reg_id %></td>
					<td><%=reg_date %></td>
				</tr>		
			<%
			}
			%>		
			</table>
		</div>
		
		<div class="page">		
		<%
			int lastPage=(int)(count/boardSize)+1;
			int startPage=((int)((currentPage-1)/pageBlock)*pageBlock)+1;	// 현재 페이지를 pageBlock으로 나누고(나머지 버림) pageBlock 곱하기 +1 한 것이 현재 페이지의 페이징 시작점
			int endPage=startPage+pageBlock-1;
			if(endPage>lastPage) endPage=lastPage; //endPage가 가장 마지막 페이지보다 클 때
		%>
			<a href="boardList.jsp?pageNumber=1" class="paging"> << </a>
			<a href="boardList.jsp?pageNumber=<%=startPage-pageBlock %>" class="paging"> < </a>
			<%for(int i=startPage; i<=endPage; i++){ %>
				<a href="boardList.jsp?pageNumber=<%=i %>"><%=i %></a>
			<%} %>		
			<a href="boardList.jsp?pageNumber=<%=startPage+pageBlock %>" class="paging"> > </a>
			<a href="boardList.jsp?pageNumber=<%=lastPage%>" class="paging"> >> </a>
			
		</div>
	</div>
</body>
</html>