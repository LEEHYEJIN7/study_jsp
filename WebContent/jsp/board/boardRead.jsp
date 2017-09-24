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
	
	.btns{
		text-align:center; margin-top: 15px;
	}
	
</style>
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
				
				<tr>
					<th>작성자</th>
					<td>홍길동</td>
					<th>작성일</th>
					<td>2017. 09. 13</td>
				</tr>
				
				<tr>
					<th>제목</th>
					<td colspan="3" style="text-align: left;">게시판 목록을 작성하자</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td colspan="3" style="text-align: left; height: 300px; vertical-align: top;">게시판 상세를 입력</td>
				</tr>
			</table>
			
			<div class="btns">
				<input type="button" value="뒤로"/>
			</div>
		</form>
	</div>
</body>
</html>