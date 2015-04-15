<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%@page import="com.puzzlemall.constants.SystemConstants"%>

<%@ include file="../includes/disablecache.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Administrative Information</title>
</head>
<body>

<%@ include file="../includes/sitebanner.jsp" %>

<%
	//#####################################################
	session.setAttribute(SessionConstants.ROLE_VARIABLE,
						 SystemConstants.ADMIN_ROLE);
	//#####################################################
%>

<center>

<font size="6">The web site will be unavailable due to maintenance on the 11/11/2011 </font><br>
Please make your preparations prior to that date!
<br>

</center>

</body>
</html>