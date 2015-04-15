<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%@page import="com.puzzlemall.constants.SystemConstants"%>

<%@ include file="../includes/disablecache.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Support</title>
</head>
<body>

<%@ include file="../includes/sitebanner.jsp" %>

<%
	//#####################################################
	session.setAttribute(SessionConstants.ROLE_VARIABLE,
						 SystemConstants.CUSTOMER_ROLE);
	//#####################################################
%>

<center>

<font size="6">For Customer Support, Please Dial 111222333444555</font><br>
Our representatives will answer as soon as there is world peace.
<br>

</center>

</body>
</html>