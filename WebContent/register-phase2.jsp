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
<title>Puzzle Mall Registration - Delivery and Billing Information</title>
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
String password = request.getParameter("password");
String verifypassword = request.getParameter("verifypassword");
String email = request.getParameter("email");
String recoveryquestion = request.getParameter("recoveryquestion");
String recoveryanswer = request.getParameter("recoveryanswer");

if(session.getAttribute(SessionConstants.FLOW_PHASE2_VARIABLE) != null) {
	
    if(((String)session.getAttribute(SessionConstants.FLOW_PHASE2_VARIABLE))
	 .equalsIgnoreCase(SystemConstants.TRUE_VALUE)) {
	
		username = (String)session.getAttribute(SessionConstants.USERNAME_VARIABLE);
		password = (String)session.getAttribute(SessionConstants.PASSWORD_VARIABLE);
		recoveryquestion = (String)session.getAttribute(SessionConstants.QUESTION_VARIABLE);
		recoveryanswer = (String)session.getAttribute(SessionConstants.ANSWER_VARIABLE);
		email = (String)session.getAttribute(SessionConstants.EMAIL_VARIABLE);
		
		verifypassword = password;
	
		session.setAttribute(SessionConstants.FLOW_PHASE2_VARIABLE,
							 SystemConstants.FALSE_VALUE);
	} //end of inner if
	
} //end of outer if

session.setAttribute(SessionConstants.USERNAME_VARIABLE, username);
session.setAttribute(SessionConstants.PASSWORD_VARIABLE, password);
session.setAttribute(SessionConstants.QUESTION_VARIABLE, recoveryquestion);
session.setAttribute(SessionConstants.ANSWER_VARIABLE, recoveryanswer);
session.setAttribute(SessionConstants.EMAIL_VARIABLE, email);

//set user role to "customer"
session.setAttribute(SessionConstants.ROLE_VARIABLE,
			 		 SystemConstants.CUSTOMER_ROLE);


if ( username == null || password == null || verifypassword == null ||
	 email == null || recoveryquestion == null || recoveryanswer == null) {
	//missing mandatory information
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
	 	"Missing Mandatory Information!");
	response.sendRedirect("/puzzlemall/register-phase1.jsp");
	
} else if ( username.length() == 0 || password.length() == 0 || 
		    verifypassword.length() == 0 || email.length() == 0 || 
		    recoveryquestion.length() == 0 || recoveryanswer.length() == 0) {
	//missing mandatory information
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
	 	"Missing Mandatory Information!");
	response.sendRedirect("/puzzlemall/register-phase1.jsp");

} else if (!password.equalsIgnoreCase(verifypassword)){
	//the password and password verification fields are not identical
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
 		"The password verification field is not identical to the password!");
	response.sendRedirect("/puzzlemall/register-phase1.jsp");

} else if (DataAccessMethods.isUsernameAvailable(username) == false){
	//the username is not available
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"The username selected is not available!");
	response.sendRedirect("/puzzlemall/register-phase1.jsp");

} else if (password.length() < 6){
	//the password is too short
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"The password should be at least 6 characters long!");
	response.sendRedirect("/puzzlemall/register-phase1.jsp");

} else if (username.length() > 40 || password.length() > 40 ||
		   recoveryquestion.length() > 150 || recoveryanswer.length() > 50 ||
		   email.length() > 50){
	//input exceed length limitations
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"The input exceeds length limitations!<br>"
	  + "usernames & passwords can have up to 40 characters, "
	  + "emails & recovery answers can have up to 50 "
	  + "and recovery questions can have up to 150 characters");
	response.sendRedirect("/puzzlemall/register-phase1.jsp");

} else {
	
	session.setAttribute(
				SessionConstants.FLOW_PHASE2_VARIABLE, 
				SystemConstants.TRUE_VALUE);
}
%>

<center>

<font size="6">Registration - Phase 2</font><br>
Please fill in all the delivery, payment and contact details below:<br>
<br>

<form action="/puzzlemall/register-phase3.jsp" method="post">
<table>
<tr>
<td>Cellphone:</td><td> <input type="text" name="cellphone" id="cellphone" size="25"></td>
</tr>
<tr>
<td>Address:</td><td> <textarea name="address" id="address" size="150"></textarea></td>
</tr>
<tr>
<td>Creditcard:</td><td> <input type="text" name="creditcard" id="creditcard" size="16"> (16 digits)</td>
</tr>
</table>
<br>
<input type="submit" value="Next->>>"><br><br>
</form>

</center>

</body>
</html>