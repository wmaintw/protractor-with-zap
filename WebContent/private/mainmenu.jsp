<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%@page import="com.puzzlemall.constants.SystemConstants" %>
<%@page import="com.puzzlemall.security.HtmlEncoder" %>

<%@ include file="../includes/disablecache.jsp" %>
<%@ include file="../includes/verifyidentity.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Puzzle Mall Main Menu</title>
</head>
<body>

<%@ include file="../includes/sitebanner.jsp" %>
<%@ include file="../includes/mainmenulink.jsp" %>

<center>
<%
	String username = (String)
		session.getAttribute(SessionConstants.USERNAME_VARIABLE);
	String role = (String) 
		session.getAttribute(SessionConstants.ROLE_VARIABLE);
	
	out.println("<br><br><b>Hello " + username
			  + "</b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"
			  + "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"
			  + "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");
	
	out.println("<a href='/puzzlemall/logout.jsp'>Logout</a><br><br><br>");
	out.println("What would you like to do today?<br><br>");
	
	out.println("<a href='/puzzlemall/private/viewprofile.jsp'>View my profile</a><br>");
	
	//Present GUI according to role
	if(role == null) {
		out.println("Null user role <br>");
	} else if(role.equalsIgnoreCase(SystemConstants.CUSTOMER_ROLE)) {
		out.println("<a href='/puzzlemall/private/viewpuzzles.jsp'>Buy puzzles!</a><br>");
		out.println("<a href='/puzzlemall/private/vieworders.jsp'>View previous orders</a><br>");
	} else if(role.equalsIgnoreCase(SystemConstants.SUPPLIER_ROLE)){
		out.println("<a href='/puzzlemall/private/viewstock.jsp'>View stock</a><br>");
	} else if(role.equalsIgnoreCase(SystemConstants.ADMIN_ROLE)){
		out.println("<a href='/puzzlemall/private/viewstock.jsp'>View stock</a><br>");
		out.println("<a href='/puzzlemall/private/viewfullorders.jsp'>View global orders</a><br>");
	} else {
		out.println("Invalid user role: " + role + "<br>");
	}
%>
</center>

</body>
</html>