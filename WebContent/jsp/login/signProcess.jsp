<%@page import="org.eclipse.jdt.internal.compiler.ast.ThrowStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="co.kr.ucs.service.SignService"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("UTF-8");
	String process=request.getParameter("process");
	String userId=request.getParameter("userId");
	String userPw=request.getParameter("userPw");
	
	String msg="";
	String url="";
	
	SignService sign=new SignService();
	
	if(process.equals("signup")){		// 회원가입
		if(sign.idCheck(userId)==0){	// 중복된 아이디가 없는 경우 회원가입 함수 실행
			String userNm=request.getParameter("userNm");
			String email=request.getParameter("email");
			sign.signUp(userId, userPw, userNm, email);
			
			/* 문제 : DB연결이 되지 않음에도 불구하고, '환영합니다'라는 msg가 보여짐.*/
			msg="환영합니다!";
			url="signIn.jsp";
		}else{ // 중복된 아이디가 있어 회원가입 불가
			msg="가입할 수 없는 아이디입니다.";
			url="signUp.jsp";
		}
	}else{   // 로그인
		int loginCheck=sign.signIn(userId, userPw);
		if(loginCheck==0){
			msg="아이디와 비밀번호를 확인해주세요.";
			url="signIn.jsp";
		}else{
			request.setAttribute("user_id", userId);
			session.setAttribute("user_id", userId);
			msg="로그인 성공!";				
			url="../board/boardList.jsp";
		}
		
	}
%>

<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>