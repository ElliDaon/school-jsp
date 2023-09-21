<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원가입</title>
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

select {
	width: 60px;
	padding: .8em .5em;
	border: 1px solid #999;
	border-radius: 15px;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	background: url("./images/arrow.png") no-repeat 90% 50%;
}

select::-ms-expand {
	display: none;
}

input[type=radio] {
	accent-color: black;
}
input[type=button]{
	background: lightblue;
}
</style>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#btn").on("click",function(){
		let memberId = $("#memberId").val();
		
		$.ajax({
			type: "post",
			url: "./memberIdCheck.jsp",
			data: {"memberId" : memberId},
			dataType: "json",
			success: function(data){
				var fm = document.frm;
				if(fm.memberId.value==""){
					alert("아이디를 입력해주세요!!");
				}else if(data.cnt == 0){
					alert("사용할 수 있는 아이디입니다.");
				}else{
					alert("사용할 수 없는 아이디입니다ㅠㅠ.");
					fm.memberId.value = "";
				}
			},
			error: function(){
				alert("실패");
			}
		});
	});
});

</script>
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
	} else if(fm.memberPwd2.value ==""){
		alert("비밀번호 확인을 입력하세요");
		fm.memberPwd2.focus();
		return;
	} else if(fm.memberPwd.value != fm.memberPwd2.value){
		alert("비밀번호가 일치하지 않습니다.");
		fm.memberPwd.value="";
		fm.memberPwd2.value="";
		fm.memberPwd1.focus();
		return;
	} else if(fm.memberName.value ==""){
		alert("이름을 입력하세요");
		fm.memberName.focus();
		return;
	} else if(fm.memberPhone.value ==""){
		alert("휴대폰번호를 입력하세요");
		fm.memberPhone.focus();
		return;
	} else if(fm.memberEmail.value ==""){
		alert("이메일을 형식에 맞게 입력하세요");
		fm.memberEmail.focus();
		return;
	} else if (!CheckEmail(fm.memberEmail.value)){
		alert("이메일 형식이 유효하지 않습니다.");
		fm.memberEmail.value="";
		fm.memberEmail.focus();
		return;	
	}else{
		var tf = checkYn(fm.memberHobby);
		if(tf==false){
			return;
		}
	}
	
	fm.action = "<%=request.getContextPath()%>/member/memberJoinAction.do";  //처리하기위해 이동하는 주소
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	fm.submit(); //전송시킴
	return;	
}
	function CheckEmail(str){ 
		//정규표현식 - 일정한 패턴에따라 해당되는 위치에 해당하는 값의 범위를 지정
	     var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	     if(!reg_email.test(str)) { 
	          return false;  
	     }  
	     else {
	          return true; 
	     } 
	} 

	//취미체크함수
	function checkYn(str){
		
		var isChk =false;
		for(var i =0;i<str.length;i++){
			if (str[i].checked == true){
				isChk = true;
				break;
			}	
		}
		
		if (!isChk){
			alert("취미는 하나이상 선택하세요");
			return false;
		}	
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
	<h3>회원가입페이지</h3>
	<br>
	<form name="frm" action="" method="" value="">
		<table border="1" style="width: 600px">
			<tr>
				<th style="width: 200px" maxlength="30">아이디</th>
				<td><input type="text" name="memberId" id="memberId" value=""
					placeholder="ID를 입력하세요">
					<input type="button" name="byn" id="btn" value="아이디 중복체크">
					<!-- 
<input type="button" name="memberIdCheck" value="아이디 중복체크">
<button type="button" name="membeButtonTest">이런버튼도있어요</button>
<input type="image" name="memberButtonTest2" src="./images/ma.jpg" style="width:20px">
--></td>
			</tr>
			<tr>
				<th style="color: red"font-weight:bold">비밀번호</th>
				<td><input type="password" name="memberPwd" value=""></td>
			</tr>
			<tr>
				<th style="color: red"font-weight:bold">비밀번호 확인</th>
				<td><input type="password" name="memberPwd2"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="memberName" value=""
					placeholder="홍길동" style="width: 100px"></td>
			</tr>
			<tr>
				<th>지역</th>
				<td>
				<select name="memberAddr">
					<option value="전주" selected>전주</option>
					<option value="서울">서울</option>
					<option value="대전">대전</option>
					<option value="부산">부산</option>
				
				</select>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><select name="memberYear" style="width: 80px;">
						<option value="1994">1994</option>
						<option value="2000">2000</option>
						<option value="2001">2001</option>
						<option value="2002">2002</option>
						<option value="2003">2003</option>
						<option value="2004">2004</option>
				</select> <select name="memberMonth">
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
				</select> <select name="memberDay">
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
						<option value="24">24</option>
						<option value="25">25</option>
						<option value="26">26</option>
						<option value="27">27</option>
						<option value="28">28</option>
						<option value="29">29</option>
						<option value="30">30</option>
						<option value="31">31</option>
				</select></td>
			</tr>
			<tr>
				<th>성별</th>
				<td><input type="radio" name="memberGender" value="남성" checked>남성
					<input type="radio" name="memberGender" value="여성">여성</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td><input type="tel" name="memberPhone"
					placeholder="010-1234-5678"
					pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input class="box" name="memberEmail" type="email">
					</td>
			</tr>
			<tr>
				<th>취미</th>
				<td class="hobbycheck"><input type="checkbox"
					name="memberHobby" value="축구">축구 <input type="checkbox"
					name="memberHobby" value="골프">골프 <input type="checkbox"
					name="memberHobby" value="야구">야구 <input type="checkbox"
					name="memberHobby" value="없음">없음</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<!-- <input
					type="submit" name="smt" value="가입하기"> --> 
					<input type="button" name="btn" value="가입하기" onclick="check();">
				</td>
			</tr>
		</table>
	</form>
	<br>