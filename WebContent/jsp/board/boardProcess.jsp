<%@page import="org.eclipse.jdt.internal.compiler.ast.ThrowStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="co.kr.ucs.service.BoardService"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script>

<%
	request.setCharacterEncoding("UTF-8");
	String title=request.getParameter("title");
	String userId=(String)session.getAttribute("user_id");
	String content=request.getParameter("content");
	
	BoardService board=new BoardService();
	
	int check=board.insertText(title, userId, content);
	
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