<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	input[type="text"], textarea{
		width:100%;
	}
	
	.btns{
		text-align:center; margin-top: 15px;
	}
</style>

<script>
	function writeCheck(){
		if(boardForm.title.value==""){
			alert("제목을 입력해주세요.");
			boardForm.title.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<div id="box">
		<h2>◎ 게시판 입력</h2>
		<form name="boardForm" action="boardProcess.jsp" onsubmit="return writeCheck()" method="post">
			<table>
				<colgroup>
					<col width="150px"/>
					<col width="*"/>
				</colgroup>				
				<tr>
					<th>제목*</th>
					<td><input type="text" name="title"/></td>
				</tr>				
				<tr>
					<th>내용</th>
					<td><textarea name="content" style="height:300px"></textarea></td>
				</tr>
			</table>
			
			<div class="btns">
				<input type="submit" value="저장"/>
				<input type="reset" value="목록" onclick="location.href='boardList.jsp'"/>
			</div>
		</form>
	</div>
</body>
</html>