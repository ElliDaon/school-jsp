<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="app.domain.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
//포워드는 공유속성때문에 념겨받을 수 있다.
//ArrayList<BoardVo> list = (ArrayList<BoardVo>)request.getAttribute("list");
//PageMaker pm = (PageMaker)request.getAttribute("pm");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판 목록</title>
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
	margin-left: auto;
	margin-right: auto;
	border-collapse: separate;
	border-spacing: 0;
	text-align: center;
	border-radius: 1em;
	overflow: hidden;
}
tbody a{
	text-decoration: none;
	color: black;
}
tbody a:hover{
	text-decoration: none;
	color: white;
}
thead {
	background: #5b5b5b;
	color: white;
}

thead th {
	padding: 10px;
}

tbody tr {
	background: white;
	border: 2px solid #f6f4f3;
}

tbody td {
	padding: 10px;
}

tbody tr:nth-child(even) {
	background: #e7f2e2;
}

tbody tr:hover {
	background: #cac8c8;
	color: white;
}
#page_line a:hover{
	color:blue; 
}
strong{
	color:red;
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
	<h3>게시판 목록</h3>
	<hr>
	
	<form name="frm" action="${pageContext.request.contextPath} /board/boardList.do" method="post">
	<table border = 0 style="width:250px">
	<tr onmouseover="this.style.background='white'; this.style.color='black'">
	
	<td>
	<select name = "searchType">
	<option value="subject">제목</option>
	<option value="writer">작성자</option>
	</select></td>
	<td><input type="text" name="keyword" size=10></td>
	<td><input type="submit" name="sbt" value="검색"></td>
	</tr>
	</table>
	</form>
	
	<table name = "list_table">
		<thead>
			<tr>
				<br>
				<br>
				<th width=80>번호</th>
				<th width=300>제목</th>
				<th width=100>작성자</th>
				<th width=50>조회수</th>
				<th width=100>작성날짜</th>
			</tr>
		</thead>
		<tbody>
			<% //for(BoardVo bv : list ) {%>
			<c:forEach var="bv" items="${list}">
			<tr>
			<td><%//=bv.getBidx() %>${bv.bidx}</td>
			<td style="text-align:left">
			<%// for(int i=1; i<=bv.getLevel_(); i++){
				//out.print("&nbsp;&nbsp;&nbsp;");
				//if(i == bv.getLevel_()){
				//	out.print("└");
				//}
			//}
			%>
			<c:forEach var="i" begin="1" end="${bv.level_}" step="1">
				&nbsp;&nbsp;&nbsp;
				<c:if test="${i==bv.level_}">
					└
				</c:if>
			</c:forEach>
			<a href="${pageContext.request.contextPath}/board/boardContents.do?bidx=<%//=bv.getBidx() %>${bv.bidx}">
			<%//=bv.getSubject() %>${bv.subject}</a></td>
			<td><%//=bv.getWriter() %>${bv.writer}</td>
			<td><%//=bv.getViewcnt() %>${bv.viewcnt}</td>
			<td><%//=bv.getWriteday() %>${bv.writeday}</td>
			</tr>
			</c:forEach>
			<% //} %>	
		</tbody>
	</table>
	<%
	//String parameter = "";
	//if(!pm.getScri().getKeyword().equals("")){
	//	parameter = "&searchType="+pm.getScri().getSearchType()+"&keyword="+pm.getScri().getKeyword();
	//}
	%>
	<c:set var="keyword" value="${pm.scri.keyword}" />
	<c:set var="parm" value="&searchType=${pm.scri.searchType}&keyword=${pm.scri.keyword}"/>
	<table>
	<tr name="page_line" style="background-color:#f6f4f3" onmouseover="this.style.background='#f6f4f3'; this.style.color='black'">
	<td style="text-align:right" width="200px">
	<%// if(pm.isPrev()==true){ %>
	<c:if test="${pm.prev == true}">
	<a href="<%//=request.getContextPath()%>${pageContext.request.contextPath}/board/boardList.do?page=<%//=pm.getStartPage()-1%>${pm.startPage-1}">
	◀
	</a>
	<% //}%>
	</c:if>
	</td>
	<td>
	<%// for(int i=pm.getStartPage(); i<=pm.getEndPage(); i++){
	%>
	<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1" >
	<c:choose>
	<c:when test="${i == pm.scri.page}">
	<a href="${pageContext.request.contextPath}/board/boardList.do?page=<%//=i%>${i}<%//=parameter%>${parm}">
	<strong><%//=i %>${i}</strong></a>
	</c:when> 
	<c:otherwise>
		<a href="${pageContext.request.contextPath}/board/boardList.do?page=${i}${parm}">
		<%//=i %>
		${i}</a>
	</c:otherwise>
	</c:choose>		
	</c:forEach>
	</td>
	<td style="text-align:left" width="200px">
	<% //if(pm.isNext()==true && pm.getEndPage()>0){ %>
	<c:if test="${pm.next == true && pm.endPage > 0}">
	<a href="${pageContext.request.contextPath}/board/boardList.do?page=<%//=pm.getEndPage()+1%>${pm.endPage +1}">
	▶
	</a>
	<% //}%>
	</c:if>
	</td>
	</tr>
	</table>
	<table>
	<a href="${pageContext.request.contextPath}/board/boardWrite.do" >글쓰기</a>
	</table>
</body>
</html>