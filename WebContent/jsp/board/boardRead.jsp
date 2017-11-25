<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="co.kr.ucs.service.BoardService"%>
<%@ page import="co.kr.ucs.bean.BoardBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
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
	String url="jdbc:oracle:thin:localhost:1521:orcl";
	String id="hj";
	String pw="hyejin";
	
	int seq=Integer.parseInt(request.getParameter("seq"));
	
	BoardService board=new BoardService();
	List<BoardBean> list=board.selectContents(seq);
	
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
				<%if(list!=null){ 
				BoardBean boardtext=list.get(0);%>
				<tr>
					<th>작성자</th>
					<td><%=boardtext.getRegId() %></td>
					<th>작성일</th>
					<td><%=boardtext.getRegDate()%></td>
				</tr>
				
				<tr>
					<th>제목</th>
					<td colspan="3" style="text-align: left;"><%=boardtext.getTitle()%></td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td colspan="3" style="text-align: left; height: 300px; vertical-align: top;"><%=boardtext.getContents()%></td>
				</tr><tr><%} %>
			</table>
			
			<div class="btns">
				<input type="button" value="뒤로" onclick="location.href='boardList.jsp'"/>
			</div>
		</form>
	</div>
</body>
</html>