<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 삭제</title>
<style type="text/css">
body {
	background: #f6f4f3;
	text-align: center;
	margin: 0;
}

nav {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: #5b5b5b;
	padding: 8px 12px;
}

#menubar ul {
	margin: 0;
	padding: 0;
	width: 100%;
}

#menubar ul li {
	display: inline-block;
	list-style-type: none;
	padding: 0px 15px;
}

#menubar ul li a {
	color: white;
	text-decoration: none;
}

#menubar ul li a:hover {
	color: yellow;
	text-decoration: none;
}
table {
	margin: auto;
	border-spacing: 10px;
}

th {
	border: 0px;
}

td {
	text-align: left;
	border: 0px;
}

input {
	border-radius: 8px;
	outline: none;
	padding-left: 10px;
	background-color: rgb(233, 233, 233);
}
</style>
</head>
<body>
	<nav id="menubar">
		<ul>
			<li><a href="../member/memberList.do">회원목록</a></li>
			<li><a href="boardList.do">게시글 목록</a></li>
			<li><a href="boardWrite.do">게시글 쓰기</a></li>
			<li><a href="../member/memberLogin.do">로그인</a></li>
			<li><a href="../member/memberJoin.do">회원가입</a></li>
		</ul>
	</nav>
	<h3>게시글 삭제</h3>
	<hr>
	
	<div id="contents">
		<table>
			<tr>
				<th>제목: 안녕하세요</th>
			</tr>
			<tr>
				<th><div id="name_title">비밀번호 입력</div></th>
			</tr>
			<tr>
				<th><input type="password" name="boardPwd" value=""></th>
			</tr>
		</table>
		
		<th></th>
		<td style="text-align:right;">
		<button type="button" >삭제하기</button>
		</td>
	</div>
</body>
</html>