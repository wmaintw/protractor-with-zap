<%@page import="org.apache.derby.jdbc.Driver40"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%@page import="com.puzzlemall.security.HtmlEncoder" %>

<%@ include file="../includes/disablecache.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Puzzle Mall Password Recovery - Phase 1</title>
</head>
<body>

<%@ include file="../includes/sitebanner.jsp" %>

<%

if(session.getAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE) != null) {

	
	
%>

<center>
<font size="5" color="red"><%=session.getAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE) %></font>
<br><br>
</center>

<%
}
session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE, null);
session.setAttribute(SessionConstants.FLOW_PHASE2_VARIABLE, null);
session.setAttribute(SessionConstants.FLOW_PHASE3_VARIABLE, null);

%>

<center>

<font size="6">Password Recovery - Phase 1</font><br>
Please provide your username:<br>
<br>

<form action="/puzzlemall/recovery-phase2.jsp" method="post">
<table>
<tr>
<td>Username:</td><td> <input type="text" name="username" id="username" size="40"></td>
</tr>
</table>
<br>
<input type="submit" value="Next->>>"><br><br>
</form>

</center>

</body>
</html>