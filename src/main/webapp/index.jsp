<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
기본 페이지입니다.
<%
String memberId = "";
//세션값이 있다는 얘기는 로그인을 했다는 말
if(session.getAttribute("memberId")!=null){
	memberId = (String)session.getAttribute("memberId");
	out.println("<a href='"+request.getContextPath()+"/member/memberLogout.do'>로그아웃</a>");
}

%>
<br>
<a href="<%=request.getContextPath()%>/member/memberList.do">회원정보보기</a><br>
<a href="<%=request.getContextPath()%>/member/memberJoin.do">회원가입 페이지</a><br>
<a href="<%=request.getContextPath()%>/member/memberLogin.do">회원 로그인 페이지</a><br>
<a href="<%=request.getContextPath()%>/board/boardList.do">보드</a><br>


</body>
</html>