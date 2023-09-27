<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="app.domain.BoardVo"%>
<%@ page import="app.domain.CommentVo"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	//if(session.getAttribute("midx")==null){
	//	out.println("<script>alert('로그인하셔야합니다!');location.href='"+
	//request.getContextPath()+"/member/memberLogin.do'</script>");
	//}

	//BoardVo bv = (BoardVo) request.getAttribute("bv");
	//CommentVo cv = (CommentVo) request.getAttribute("cv");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>${bv.subject}</title>

<c:if test="${ sessionScope.midx == null }">
<script>
alert("로그인이 필요합니다");
<c:set var="login" value="${pageContext.request.contextPath}/member/memberLogin.do" />
location.href="${login}";
</script>
</c:if>

<link href="./css/board.css" type="text/css" rel="stylesheet">
<!-- 1.cdn주소걸고 (라이브러리) -->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
//자동실행영역
$(document).ready(function(){
	
	$.boardCommentList();
	
	$("#save").on("click",function(){
		//alert("클릭");
		let cwriter = $("#cwriter").val();
		let ccontents = $("#ccontents").val();
		let bidx = ${bv.bidx};
		let midx = ${sessionScope.midx};
		
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/comment/commentWrite.do",
			dataType : "json",
			data : {
					"bidx" : bidx,
					"midx" : midx,
					"cwriter" : cwriter,
					"ccontents" : ccontents
			},
			cache : false,
			success : function(data){
				alert("통신성공");
				//alert(data.value);
				//if(data.value==1){
				//	alert("등록성공");
				//}
				$.boardCommentList();
				$("#cwriter").val("");
				$("#ccontents").val("");
			},
			error : function(){
				alert("통신오류 실패");
			}		
		});
	});
	
	$("#btn2").on("click",function(){
		alert("클릭");
		
	}); 
});


$.boardCommentList= function(){
	
	$.ajax({
		type : "get",
		url : "${pageContext.request.contextPath}/comment/commentList.do",
		dataType : "json",
		cache : false,
		success : function(data){
			//alert("통신성공");
			commentList(data);
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
	
}


function commentList(data){
	
	var str = "";
	str = "<tr><th>번호</th><th>작성자</th><th>내용</th><th>등록일</th><th>삭제</th></tr>";
	
	var delbtn = "";
	
	var loginMidx = ${sessionScope.midx};
	
	$(data).each(function(){
		if(loginMidx==this.midx){
			delbtn = "<input type='button' name='btn2' onclick='cdel("+this.cidx+")' value='X'>";
		}else{
			delbtn="";
		}
		str = str + "<tr><td>"+this.cidx+"</td><td>"+this.cwriter+"</td><td>"
			  +this.ccontents+"</td><td>"+this.cwriteday+"</td><td>"+delbtn
			  +"</td></tr>";
		
	});
	$("#tbl").html("<table id='ccontents'>"+str+"</table>");
	return;
}

function cdel(cidx){
	//alert("삭제");
	var cidx = cidx;
	$.ajax({
		type : "get",
		url : "${pageContext.request.contextPath}/comment/commentDelete.do?cidx="+cidx,
		dataType : "json",
		cache : false,
		success : function(){
			alert("삭제 성공");
			$.boardCommentList();
		},
		error : function(request, status, error){

			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

		}	
	});
	return;
}

</script>

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

div {
	width: 80%;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid black;
}

table {
	margin-left: auto;
	margin-right: auto;
	border-collapse: collapse;
}

th {
	border: 5px solid #f6f4f3;
	height: 20px;
	text-align: center;
}

th #name_title {
	border-style: hidden;
	width: 60px;
	height: 40px;
	display: table-cell;
	vertical-align: middle;
}

th #name_contents {
	border-style: hidden;
	width: 60px;
	height: 300px;
	display: table-cell;
	vertical-align: middle;
}

td {
	padding: 10px 10px 10px 10px;
	text-align: left;
}

td #title {
	background: white;
	border-radius: 5px;
	border-style: hidden;
	width: 300px;
	height: 40px;
	display: table-cell;
	vertical-align: middle;
	padding-left: 5px;
}

td #contents {
	background: white;
	border-radius: 5px;
	border-style: hidden;
	width: 500px;
	height: 300px;
	padding-left: 5px;
	padding-top: 5px;
}

td #userName {
	background: white;
	border-radius: 5px;
	border-style: hidden;
	width: 100px;
	height: 40px;
	display: table-cell;
	vertical-align: middle;
	padding-left: 5px;
}

#ccontents th {
	background: #5b5b5b;
	color: white;
}

#ccontents table {
	border-collapse: separate;
	border-spacing: 0;
}
</style>
</head>
<body>
	<nav id="menubar">
		<ul>
			<li><a href="../member/memberList.do">회원목록</a></li>
			<li><a href="boardList.do">게시글 목록</a></li>
			<li><a href="board/boardWrite.do">게시글 쓰기</a></li>
			<li><a href="../member/memberLogin.do">로그인</a></li>
			<li><a href="../member/memberJoin.do">회원가입</a></li>
		</ul>
	</nav>

	<h3>게시글</h3>
	<hr>
	<div id="contents">
		<table>
			<tr>
				<th><div id="name_title">제목</div></th>
				<td><div id="title">${bv.subject}</div></td>
				<th>조회수</th>
				<td>${bv.viewcnt}</td>
			</tr>
			<tr>
				<th><div id="name_contents">내용</div></th>
				<td colspan=3 height="300px" style="vertical-align: top;"><div
						id="contents">${bv.contents}
					</div></td>
			</tr>
			<tr>
				<th><div id="name_title">작성자</div></th>
				<td><div id="userName">${bv.writer}</div></td>
			</tr>
		</table>
		<th></th>
		<td style="text-align: right;">
			<button type="button"
				onclick="location.href='${pageContext.request.contextPath}/board/boardModify.do?bidx=${bv.bidx}'">수정</button>
			<button type="button"
				onclick="location.href='${pageContext.request.contextPath}/board/boardDelete.do?bidx=${bv.bidx}'">삭제</button>
			<button type="button"
				onclick="location.href='${pageContext.request.contextPath}/board/boardReply.do?bidx=${bv.bidx}&originbidx=${bv.originbidx}&depth=${bv.depth}&level_=${bv.level_}'">답글</button>
			<button type="button"
				onclick="location.href='${pageContext.request.contextPath}/board/boardList.do'">목록</button>
		</td> <br>
		<br>
	</div>
	<div>
		<table style="width: 600px;">
			<tr>
				<td>작성자</td>
				<td><input type="text" id="cwriter" name="cwriter" size="20"></td>
				<td rowspan=2><input type="button" name="btn" value="저장"
					id="save"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea id="ccontents" name="ccontents" cols="50" rows="3"
						placeholder="내용을 입력하세요"></textarea></td>
			</tr>
		</table>
	</div>
		<div id="tbl">
		</div>
</body>
</html>
