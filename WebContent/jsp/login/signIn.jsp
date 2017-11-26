<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
 	body{
		font-size:12px;
		margin:0px;
	}
	
	#box{
		width:300px;
		margin:300px auto;
		border:0px red solid;
	}
	
   #submitBtn, #joinBtn{
    background-color: white;
    border: 1px solid black;
    margin:20px 5px;
    display: block;      
    float:left;
   }
   	
	.labelB {
		width:28%; float:left;
		height:30px;
		line-height:30px;
		padding-left:5px;
		border-top:1px #cccccc solid;
		border-left:1px #cccccc solid;
		display:inline;
	}
	
	.inputB {
		width:65%; height:30px;
		line-height:30px;
		border:1px #cccccc solid;
		border-bottom:0px #cccccc solid;
		padding-left:5px;
		display:inline-block;
	}
	
	.btnB{
		border:0px black solid;
		overflow:hidden;
		width:145px;
		margin: 0px auto;
	}
</style>
<script type="text/javascript">
	function join(){
		location.href="signUp.jsp";
	}
	
	function loginCheck(){
		if(loginForm.userId.value==""){
			alert("아이디를 입력해주세요.");
			loginForm.userId.focus();
			return false;
		}
		
		if(loginForm.userPw.value==""){
			alert("비밀번호를 입력해주세요.");
			loginForm.userPw.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<div id="box">
		<h2>로그인</h2>
		<form name="loginForm" action="/study_jsp/sign/signIn" onsubmit="return loginCheck()" method="post">			
			<div id="loginBox">
					<input type="hidden" name="process" value="signin"/>
					<div class="labelB"><label for="id">아이디*</label></div>
					<div class="inputB"><input type="text" name="userId"/></div>		
					<div class="labelB" style="border-bottom:1px #cccccc solid;"><label for="pwd">비밀번호</label></div>
					<div class="inputB" style="border-bottom:1px #cccccc solid;"><input type="password" name="userPw"/></div>		
					<div class="btnB">
						<input type="submit" id="submitBtn" value="로그인"/>	
						<input type="button" id="joinBtn" value="회원가입" onclick="join()"/>
					</div>
			</div>
		</form>
	</div>

</body>
</html>