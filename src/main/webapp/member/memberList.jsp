<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="app.domain.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
//포워드는 공유속성때문에 념겨받을 수 있다.
//ArrayList<MemberVo> list = (ArrayList<MemberVo>)request.getAttribute("list");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원목록</title>
<style>
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

#menubar ul{
	margin: 0;
	padding: 0;
	width: 100%;
}
#menubar ul li{
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
	border-collapse: collapse;
	border: 1px solid #5b5b5b;
	width: 80%;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
}
thead {
	background: #5b5b5b;
	color: white;
}
tbody tr {
	background: white;
}
tbody tr:nth-child(even){
	background:#f8e2e2;
}
</style>
</head>
<body>
<nav id="menubar">
<ul>
<li><a href="memberList.do">회원목록</a></li>
<li><a href="../board/boardList.do">게시글 목록</a></li>
<li><a href="../board/boardWrite.html">게시글 쓰기</a></li>
<li><a href="memberLogin.do">로그인</a></li>
<li><a href="memberJoin.do">회원가입</a></li>
</ul>
</nav>
	<h3>회원목록</h3>
	<hr>
	<table>
		<thead>
			<tr>
				<th>회원번호</th>
				<th>이름</th>
				<th>아이디</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
		
		<c:forEach var="mv" items="${list}">
		<tr>
		<td><%//=mv.getMidx() %>${mv.midx}</td>
		<td><%//=mv.getMemberId() %>${mv.memberId}</td>
		<td><%//=mv.getMemberName() %>${mv.memberName}</td>		
		<td><%//=mv.getWriteday() %>${mv.writeday}</td>
		</tr>	
		</c:forEach>
		
		</tbody>
	</table>
</body>
</html>