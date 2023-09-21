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
	text-align: center;
	margin: 0;
}
nav {
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
#loginBox {
	display: block;
	width: 400px;
	height: 300px;
	border: 1px solid black;
	margin-left: auto;
	margin-right: auto;
	margin-top: 50px;
	border-radius: 10px;
	box-shadow: 0px 0px 5px #444
}

div div {
	display: block;
	margin-left: auto;
	margin-right: auto;
	text-align: center;
}

div table {
	margin-left: auto;
	margin-right: auto;
	padding: 10px;
}

div #text {
	padding: 20px 20px 10px 20px;
	font-size: 40px;
}

td {
	text-align: center;
	padding: 5px;
}

#button {
	-webkit-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-moz-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-ms-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-o-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	display: block;
	margin: 20px auto;
	max-width: 80px;
	text-decoration: none;
	border-radius: 4px;
	padding: 20px 30px;
}

input[type=text] {
	height: 30px;
	border: 2px solid gray;
	border-radius: 5px;
}

input[type=password] {
	height: 30px;
	border: 2px solid gray;
	border-radius: 5px;
}

input::placeholder {
	color: darkgray;
}

div #button {
	color: rgba(30, 22, 54, 0.6);
	box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
}

div #button:hover {
	color: rgba(255, 255, 255, 0.85);
	box-shadow: rgba(30, 22, 54, 0.7) 0 0px 0px 40px inset;
}
</style>
</head>
<body>
<script>

function check(){
//alert("체크함수들어옴");
	
	//let memberId = document.frm.memberId.value;
	//alert("입력된 아이디는?"+memberId);
	var fm = document.frm; //문서객체안의 폼객체이름
	
	//alert(document.frm.memberHobby[0].value);
	//alert(document.frm.memberHobby[1].checked);
	
	
	if(fm.memberId.value ==""){
		alert("아이디를 입력하세요");
		fm.memberId.focus();
		return;
	} else if(fm.memberPwd.value ==""){
		alert("비밀번호를 입력하세요");
		fm.memberPwd.focus();
		return;
	}
	
	fm.action ="<%=request.getContextPath()%>/member/memberLoginAction.do";  //처리하기위해 이동하는 주소
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	fm.submit();
	return;
}
</script>

	<nav id="menubar">
		<ul>
			<li><a href="memberList.do">회원목록</a></li>
			<li><a href="../board/boardList.do">게시글 목록</a></li>
			<li><a href="../board/boardWrite.html">게시글 쓰기</a></li>
			<li><a href="memberLogin.do">로그인</a></li>
			<li><a href="memberJoin.do">회원가입</a></li>
		</ul>
	</nav>
	<form name="frm" action="" method="" value="">
	<div id="loginBox">
		<div id="text">Login</div>
		<table>
			<tr>
				<th id="loginId">아이디</th>
				<td><input type="text" name="memberId" id="memberId" value=""
					placeholder="아이디 입력"></td>
			</tr>
			<tr>
				<th id="LoginPassword">비밀번호</th>
				<td><input type="password" name="memberPwd" id="memberPwd" value=""
					placeholder="비밀번호 입력" onkeypress="if(event.keyCode == 13){ check(); return;}"></td>
			</tr>
		</table>
		<div>
			<a href="#" id="button" onclick="check();">로그인</a>
		</div>
	</div>
	</form>
</body>
</html>