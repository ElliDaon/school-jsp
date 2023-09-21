<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="app.dao.MemberDao" %>
<%
MemberDao md = new MemberDao();
String memberId = request.getParameter("memberId");
int value = md.memberIdCheck(memberId);;
String str = "{ \"cnt\" : \""+value+"\" }";
out.println(str);
%>