<%@page import="org.apache.derby.jdbc.Driver40"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="com.puzzlemall.database.ConnectionManager" %>
<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%@page import="com.puzzlemall.constants.SystemConstants" %>
<%@page import="com.puzzlemall.security.HtmlEncoder" %>
<%@page import="com.puzzlemall.logic.DataAccessMethods" %>

<%@ include file="../includes/disablecache.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Puzzle Mall Password Recovery - Question Challenge</title>
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


String username = request.getParameter("username");

if(session.getAttribute(SessionConstants.FLOW_PHASE2_VARIABLE) != null) {
	
    if(((String)session.getAttribute(SessionConstants.FLOW_PHASE2_VARIABLE))
	 .equalsIgnoreCase(SystemConstants.TRUE_VALUE)) {
	
		username = (String)session.getAttribute(SessionConstants.USERNAME_VARIABLE);
	
		session.setAttribute(SessionConstants.FLOW_PHASE2_VARIABLE,
							 SystemConstants.FALSE_VALUE);
	} //end of inner if
	
} //end of outer if

session.setAttribute(SessionConstants.USERNAME_VARIABLE, username);

if (username == null) {
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
	 	"Please provide a valid username!");
	response.sendRedirect("/puzzlemall/recovery-phase1.jsp");
	
} else if ( username.length() == 0) {
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
 		"Please provide a valid username!");
	response.sendRedirect("/puzzlemall/recovery-phase1.jsp");

} else if (DataAccessMethods.isUsernameAvailable(username) == true){
	//the username does not exist
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
 		"Please provide a valid username!");
	response.sendRedirect("/puzzlemall/recovery-phase1.jsp");

} else {
	
	session.setAttribute(
				SessionConstants.FLOW_PHASE2_VARIABLE, 
				SystemConstants.TRUE_VALUE);
}
%>

<center>

<font size="6">Password Recovery - Phase 2</font><br>
Please answer the password recovery question below:<br>
<br>

<form action="/puzzlemall/recovery-phase3.jsp" method="post">
<table>
<tr>
<td><b>Password Recovery Question:</b></td><td> <%=DataAccessMethods.getRecoveryQuestion(username)%></td>
</tr>
<tr>
<td><b>Password Recovery Answer:</b></td><td> <input type="text" name="recoveryanswer" id="recoveryanswer" size="50"></td>
</tr>
</table>
<br>
<input type="submit" value="Next->>>"><br><br>
</form>

</center>

</body>
</html>