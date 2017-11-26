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
a {
	text-decoration: none;
	color: black;
}

body {
	font-size: 14px;
	margin: 0px;
}

#box {
	width: 800px;
	margin: 200px auto;
	border: 0px red solid;
}

.searchBox {
	width: 600px;
	margin-bottom: 10px;
	height: 30px;
	line-height: 30px;
}

.select {
	float: left;
	width: 150px;
	text-align: center;
	border: 1px #cccccc solid;
}

.searchInput {
	float: left;
	width: 250px;
	text-align: center;
	border: 1px #cccccc solid;
	border-left: 0px;
}

select, input[type=text] {
	width: 90%;
	height: 20px;
}

table {
	border: 1px #cccccc solid;
	border-spacing: 0px;
	width: 100%;
}

table tr th, td {
	border: 1px solid #cccccc;
	height: 40px;
	text-align: left;
	padding-left: 5px;
	padding-right: 15px;
}

#submitBtn {
	height: 30px;
	margin-left: 10px;
}

.page {
	margin-top: 20px;
	text-align: center;
}

.paging {
	width: 40px;
	display: inline-block;
	text-align: center;
	border: 1px solid black;
}
</style>

<%	
	List<BoardBean> list=(List<BoardBean>)request.getAttribute("list");
	int count=(int)request.getAttribute("count");
	int currentPage=(int)request.getAttribute("currentPage");
	int pageBlock=(int)request.getAttribute("pageBlock");
	int boardSize=(int)request.getAttribute("boardSize");
	String msg=(String)request.getAttribute("msg");
%>

<script>
	<%if(msg!=null){%>
		
	<%}%>
</script>

</head>
<body>
	<div id="box">
		<h2>◎ 게시판 목록</h2>
		<div class="searchBox">
			<form name="searchForm" action="/study_jsp/board/boardList">
				<div class="select">
					<select id="search" name="search">
						<option value="title">제목</option>
						<option value="seq">글번호</option>
						<option value="contents">내용</option>
						<option value="all">제목+내용</option>
					</select>
				</div>

				<div class="searchInput">
					<input type="text" id="searchInput" name="searchInput"/>
				</div>

				<input type="submit" id="submitBtn" value="검색" />
				<input type="button" id="writeBtn" value="글쓰기" onclick="location.href='/study_jsp/jsp/board/boardWrite.jsp'"/>
			</form>
		</div>

		<div class="list">
			<table>
				<colgroup>
					<col width="80px" />
					<col width="*" />
					<col width="100px" />
					<col width="100px" />
				</colgroup>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
		<%
		for(int i=0; i<list.size(); i++){
			BoardBean boardlist=list.get(i);
			int seq=boardlist.getSeq();
			String title = boardlist.getTitle();
			String reg_id = boardlist.getRegId();
			Date reg_date = boardlist.getRegDate();	
		%>
				<tr>
					<td><%=seq %></td>
					<td><a href='/study_jsp/board/boardRead?seq=<%=seq%>'><%=title %></a></td>
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
			<a href="/study_jsp/board/boardList?pageNumber=1" class="paging"> ◀ </a> <a
				href="/study_jsp/board/boardList?pageNumber=<%=startPage-pageBlock %>"
				class="paging">◁ </a>
			<%for(int i=startPage; i<=endPage; i++){ %>
			<a href="/study_jsp/board/boardList?pageNumber=<%=i %>"><%=i %></a>
			<%} %>
			<a href="/study_jsp/board/boardList?pageNumber=<%=startPage+pageBlock %>"
				class="paging"> ▷ </a> <a
				href="/study_jsp/board/boardList?pageNumber=<%=lastPage%>" class="paging"> ▶
			</a>

		</div>
	</div>
</body>
</html>