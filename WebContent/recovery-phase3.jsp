<%@page import="org.apache.derby.jdbc.Driver40"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%@page import="com.puzzlemall.constants.SystemConstants" %>
<%@page import="com.puzzlemall.security.HtmlEncoder" %>
<%@page import="com.puzzlemall.logic.DataAccessMethods" %>

<%@ include file="../includes/disablecache.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Puzzle Mall Password Recovery - Answer Confirmation</title>
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

if(session.getAttribute(SessionConstants.FLOW_PHASE2_VARIABLE) == null) {
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"Please perform all the phases of the process.");
	response.sendRedirect("/puzzlemall/recovery-phase1.jsp");
	
	return;
	
} else if( ((String)session.getAttribute(SessionConstants.FLOW_PHASE2_VARIABLE))
		.equalsIgnoreCase(SystemConstants.FALSE_VALUE)) {
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"Please perform all the phases of the process.");
	response.sendRedirect("/puzzlemall/recovery-phase1.jsp");
	
	return;
} //end of flow verification if-else block


String username = (String)session.getAttribute(SessionConstants.USERNAME_VARIABLE);
String recoveryAnswer = request.getParameter("recoveryanswer");

if(session.getAttribute(SessionConstants.FLOW_PHASE3_VARIABLE) != null) {
	
	if(((String)session.getAttribute(SessionConstants.FLOW_PHASE3_VARIABLE))
		 .equalsIgnoreCase(SystemConstants.TRUE_VALUE)) {
		
		recoveryAnswer = (String)session.getAttribute(SessionConstants.ANSWER_VARIABLE);
		
		session.setAttribute(SessionConstants.FLOW_PHASE3_VARIABLE,
							 SystemConstants.FALSE_VALUE);
	} //end of inner if

} //end of outer if

session.setAttribute(SessionConstants.ANSWER_VARIABLE, recoveryAnswer);


if (recoveryAnswer == null) {
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
	 	"Please provide a valid recovery answer!");
	response.sendRedirect("/puzzlemall/recovery-phase2.jsp");
	
} else if (recoveryAnswer.length() == 0) {
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
 		"Please provide a valid recovery answer!");
	response.sendRedirect("/puzzlemall/recovery-phase2.jsp");

} else if (DataAccessMethods.isAnswerValid(username,recoveryAnswer)==false){
	//the password recovery answer is incorrect
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"Invalid recovery answer!");
	response.sendRedirect("/puzzlemall/recovery-phase2.jsp");

} else {
	
	session.setAttribute(
			SessionConstants.FLOW_PHASE2_VARIABLE, 
			SystemConstants.FALSE_VALUE);
	
	session.setAttribute(
			SessionConstants.FLOW_PHASE3_VARIABLE, 
			SystemConstants.TRUE_VALUE);

}

%>

<center>

<font size="6">Password Recovery - Phase 3</font><br>
Please press the button to view your password:<br>
<br>

<form action="/puzzlemall/recovery-success.jsp" method="post">
<input type="submit" value="Show me my password"><br><br>
</form>

</center>

</body>
</html>