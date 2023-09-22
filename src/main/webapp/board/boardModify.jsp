<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="app.domain.BoardVo" %>
<%
BoardVo bv = (BoardVo)request.getAttribute("bv");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글 수정</title>
<script>
function check(){
	
	var fm = document.frm;
	
	if(fm.subject.value ==""){
		alert("제목을 입력하세요");
		fm.subject.focus();
		return;
	} else if(fm.contents.value ==""){
		alert("내용을 입력하세요");
		fm.contents.focus();
		return;
	} else if(fm.writer.value ==""){
		alert("닉네임을 입력하세요");
		fm.writer.focus();
		return;
	} else if(fm.pwd.value ==""){
		alert("비밀번호를 입력하세요");
		fm.pwd.focus();
		return;
	}
	//처리하기위해 이동하는 주소
	fm.action = "<%=request.getContextPath()%>/board/boardModifyAction.do";
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	//fm.enctype= "multipart/form-data";
	fm.submit();
	return;
}
</script>
<style>
body {
	background: #f6f4f3;
	margin:0;
	text-align: center;
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

#content_page {
	display: block;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
}

.filebox .upload-name {
	display: inline-block;
	height: 20px;
	padding: 0 10px;
	vertical-align: middle;
	border: 1px solid #dddddd;
	width: 200px;
	color: #999999;
}

.filebox label {
	display: inline-block;
	padding: 5px 5px;
	color: #fff;
	vertical-align: middle;
	background-color: #999999;
	cursor: pointer;
	height: 20px;
	margin-left: 10px;
	font-size: 13px;
	margin: 5px;
}

.filebox input[type="file"] {
	position: absolute;
	width: 0;
	height: 0;
	padding: 0;
	overflow: hidden;
	border: 0;
}
#boardPwd {
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
	<h3>게시글 수정</h3>
	<hr>
	<form name="frm" action="" method="" value="">
	<input type="hidden" name = "bidx" value = "<%=bv.getBidx() %>">
	<div id="content_page">
		<div id="in_title">
			제목: <textarea name="subject" id="subject" rows="1" cols="50"
				placeholder="제목" maxlength="100" required><%=bv.getSubject() %></textarea>
		</div>

		<div id="in_content" >
			내용: <textarea name="contents" id="contents" placeholder="내용" rows="20"
				cols="50" required><%=bv.getContents() %></textarea>
		</div>
		<div>
			작성자: <input type="text" name="writer" value="<%=bv.getWriter() %>" placeholder="이름">
		</div>
		
		<div class="pwd">
			<th>비밀번호: <input type="password" id="boardPwd" name="pwd" value=""></th>
		</div>
		<div>
			<input type="button" name="btn" value="수정하기" onclick="check();">
		</div>
	</div>
		</form>
</body>
</html>