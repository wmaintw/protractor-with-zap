<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%@page import="com.puzzlemall.constants.SystemConstants" %>
<%@page import="com.puzzlemall.security.HtmlEncoder" %>
<%@page import="java.sql.*" %>
<%@page import="com.puzzlemall.database.ConnectionManager" %>

<%@ include file="../includes/disablecache.jsp" %>
<%@ include file="../includes/verifyidentity.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Puzzle Mall - My Profile</title>
</head>
<body>

<%@ include file="../includes/sitebanner.jsp" %>
<%@ include file="../includes/mainmenulink.jsp" %>


<%
String username = HtmlEncoder.htmlEncode((String)
	session.getAttribute(SessionConstants.USERNAME_VARIABLE));
String role = (String) 
	session.getAttribute(SessionConstants.ROLE_VARIABLE);
	
String email = null;
String recoveryquestion = null;
String recoveryanswer = null;
String cellphone = null;
String address = null;
	
Connection conn = null;
	
try {
	conn = ConnectionManager.getConnection();
	
	String SqlString = 
        "SELECT recoveryQuestion,recoveryAnswer,email,cellphone,address " +
        "FROM users " +
        "WHERE username = ?";
		
	PreparedStatement pstmt = conn.prepareStatement(SqlString);	
	pstmt.setString(1, username);
	ResultSet rs = pstmt.executeQuery();
	
	 if(rs.next()) {
		 recoveryquestion = HtmlEncoder.htmlEncode(rs.getString(1));
		 recoveryanswer = HtmlEncoder.htmlEncode(rs.getString(2));
		 email = HtmlEncoder.htmlEncode(rs.getString(3));
		 cellphone = HtmlEncoder.htmlEncode(rs.getString(4));
		 address = HtmlEncoder.htmlEncode(rs.getString(5));
	 }
		
	if(conn != null) {
	   	ConnectionManager.closeConnection(conn);
	}
} catch (Exception e) {
	if(conn != null) {
   		ConnectionManager.closeConnection(conn);
	}
		
	throw e;
} //end of try-catch block
	
%>

<center>

<font size="6">My Profile</font><br>
<br>

<table>
<tr>
<td><b>Username:</b></td><td> <%=username%> </td>
</tr>
<tr>
<td><b>Email:</b></td><td> <%=email%> </td>
</tr>
<tr>
<td><b>Password Recovery Question:</b></td><td> <%=recoveryquestion%> </td>
</tr>
<tr>
<td><b>Password Recovery Answer:</b></td><td> <%=recoveryanswer%> </td>
</tr>
<tr>
<td><b>Cellphone:</b></td><td> <%=cellphone%> </td>
</tr>
<tr>
<td><b>Address:</b></td><td> <%=address%> </td>
</tr>
</table>

<br><br>

</center>

</body>
</html>