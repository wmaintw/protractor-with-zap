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
<title>Puzzle Mall Registration - Creating New Account . . .</title>
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

if(session.getAttribute(SessionConstants.FLOW_PHASE3_VARIABLE) == null) {
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"Please perform all the phases of the process.");
	response.sendRedirect("/puzzlemall/register-phase1.jsp");
	
	return;	
} else if( ((String)session.getAttribute(SessionConstants.FLOW_PHASE3_VARIABLE))
		.equalsIgnoreCase(SystemConstants.FALSE_VALUE)) {
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"Please perform all the phases of the process.");
	response.sendRedirect("/puzzlemall/register-phase1.jsp");
	
	return;
} //end of flow verification if-else block

//disable flags to prevent reuse after validation

session.setAttribute(
			SessionConstants.FLOW_PHASE2_VARIABLE, 
			SystemConstants.FALSE_VALUE);
	
session.setAttribute(
			SessionConstants.FLOW_PHASE3_VARIABLE, 
			SystemConstants.FALSE_VALUE);


String username = (String)session.getAttribute(SessionConstants.USERNAME_VARIABLE);
String password = (String)session.getAttribute(SessionConstants.PASSWORD_VARIABLE);
String recoveryquestion = (String)session.getAttribute(SessionConstants.QUESTION_VARIABLE);
String recoveryanswer = (String)session.getAttribute(SessionConstants.ANSWER_VARIABLE);
String email = (String)session.getAttribute(SessionConstants.EMAIL_VARIABLE);
String role =  (String)session.getAttribute(SessionConstants.ROLE_VARIABLE);
String cellphone = (String)session.getAttribute(SessionConstants.PHONE_VARIABLE);
String address = (String)session.getAttribute(SessionConstants.ADDRESS_VARIABLE);
String creditcard = (String)session.getAttribute(SessionConstants.CREDIT_VARIABLE);

//HTML ENCODE SOME VALUES BEFORE STORING THEM IN THE DB OR AUTHENTICATED SESSION
//(encode all except the password and the role)
username = HtmlEncoder.htmlEncode(username);
recoveryquestion = HtmlEncoder.htmlEncode(recoveryquestion);
recoveryanswer = HtmlEncoder.htmlEncode(recoveryanswer);
email = HtmlEncoder.htmlEncode(email);
cellphone = HtmlEncoder.htmlEncode(cellphone);
address = HtmlEncoder.htmlEncode(address);
creditcard = HtmlEncoder.htmlEncode(creditcard);

//encode values in session prior to logging in
session.setAttribute(SessionConstants.USERNAME_VARIABLE, username);
session.setAttribute(SessionConstants.QUESTION_VARIABLE, recoveryquestion);
session.setAttribute(SessionConstants.ANSWER_VARIABLE, recoveryanswer);
session.setAttribute(SessionConstants.EMAIL_VARIABLE, email);
session.setAttribute(SessionConstants.PHONE_VARIABLE, cellphone);
session.setAttribute(SessionConstants.ADDRESS_VARIABLE, address);
session.setAttribute(SessionConstants.CREDIT_VARIABLE, creditcard);

//Actual user account creation

Connection conn = null;

try {
	
	conn = ConnectionManager.getConnection();
	String SqlString = 
        "INSERT INTO users "
        + "(username,password,recoveryQuestion,recoveryAnswer,role," 
         + "email,cellphone,address,creditcard) "
        + "VALUES(?,?,?,?,?,?,?,?,?)";
	
		PreparedStatement pstmt = conn.prepareStatement(SqlString);
		pstmt.setString(1, username);
		pstmt.setString(2, password);
		pstmt.setString(3, recoveryquestion);
		pstmt.setString(4, recoveryanswer);
		pstmt.setString(5, role);
		pstmt.setString(6, email);
		pstmt.setString(7, cellphone);
		pstmt.setString(8, address);
		pstmt.setString(9, creditcard);
		
		int result = pstmt.executeUpdate();
 	 	
	  	out.flush();
	
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

<font size="6">Registration Completed Successfully </font><br>
Press the button to start using the application:<br>
<br>

<form action="/puzzlemall/private/mainmenu.jsp" method="post">
<input type="submit" value="Let Me In!!!"><br><br>
</form>

</center>


</body>
</html>