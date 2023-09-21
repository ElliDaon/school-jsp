<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
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
</style>
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
		alert("닉네임을 입력하세요");
		fm.pwd.focus();
		return;
	}
	
	fm.action = "<%=request.getContextPath()%>/board/boardWriteAction.do";  //처리하기위해 이동하는 주소
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	fm.submit();
	
}
</script>
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
	<h3>답글 작성</h3>
	<hr>
	<form name="frm" action="" method="" value="">
	<div id="content_page">
		<div id="in_title">
			<textarea name="subject" id="utitle" rows="1" cols="50"
				placeholder="제목" maxlength="100" value="" required></textarea>
		</div>

		<div id="in_content">
			<textarea name="contents" id="content" placeholder="내용" rows="20"
				cols="50" value="" required></textarea>
		</div>
		<div>
			닉네임: <input type="text" name = "writer" placeholder="닉네임" value="" >
		</div>
		<div class="filebox">
			<label for="file">파일찾기</label> <input type="file" id="file">
			<input class="upload-name" name = "file" value="첨부파일" placeholder="첨부파일" value="">
		</div>
		<div>
			비밀번호: <input type="password" name = "pwd" placeholder="비밀번호" value="" >
		</div>
		<div>
			<input type="button" name="btn" value="등록하기" onclick="check();">
		</div>
	</div>
	</form>
</body>
</html>