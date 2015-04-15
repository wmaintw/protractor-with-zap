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
<title>Puzzle Mall Registration - Final Confirmation</title>
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
	response.sendRedirect("/puzzlemall/register-phase1.jsp");
	
	return;
	
} else if( ((String)session.getAttribute(SessionConstants.FLOW_PHASE2_VARIABLE))
		.equalsIgnoreCase(SystemConstants.FALSE_VALUE)) {
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"Please perform all the phases of the process.");
	response.sendRedirect("/puzzlemall/register-phase1.jsp");
	
	return;
} //end of flow verification if-else block


String cellphone = request.getParameter("cellphone");
String address = request.getParameter("address");
String creditcard = request.getParameter("creditcard");

if(session.getAttribute(SessionConstants.FLOW_PHASE3_VARIABLE) != null) {
	
	if(((String)session.getAttribute(SessionConstants.FLOW_PHASE3_VARIABLE))
		 .equalsIgnoreCase(SystemConstants.TRUE_VALUE)) {
		
		cellphone = (String)session.getAttribute(SessionConstants.PHONE_VARIABLE);
		address = (String)session.getAttribute(SessionConstants.ADDRESS_VARIABLE);
		creditcard = (String)session.getAttribute(SessionConstants.CREDIT_VARIABLE);
		
		session.setAttribute(SessionConstants.FLOW_PHASE3_VARIABLE,
							 SystemConstants.FALSE_VALUE);
	} //end of inner if

} //end of outer if

session.setAttribute(SessionConstants.PHONE_VARIABLE, cellphone);
session.setAttribute(SessionConstants.ADDRESS_VARIABLE, address);
session.setAttribute(SessionConstants.CREDIT_VARIABLE, creditcard);


if (cellphone == null || address == null || creditcard == null) {
	//missing mandatory information
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
	 	"Missing Mandatory Information!");
	response.sendRedirect("/puzzlemall/register-phase2.jsp");
	
} else if (cellphone.length() == 0 || address.length() == 0 || 
		creditcard.length() == 0 ) {
	//missing mandatory information
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
	 	"Missing Mandatory Information!");
	response.sendRedirect("/puzzlemall/register-phase2.jsp");

} else if (cellphone.length() > 25 || address.length() > 150 ||
		creditcard.length() > 16){
	//input exceed length limitations
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"The input exceeds length limitations!<br>"
	  + "the cellphone can have up to 25 characters, "
	  + "the address can have up to 150 characters, "
	  + "and the credit card must have exactly 16 digits.");
	response.sendRedirect("/puzzlemall/register-phase2.jsp");

} else if (creditcard.length() != 16){
	//the credit card is invalid (no digit check in this version)
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"The credit card format is invalid; "
	  + "it must have exactly 16 digits.");
	response.sendRedirect("/puzzlemall/register-phase2.jsp");

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

<font size="6">Registration - Phase 3</font><br>
Please press the button to complete the registration process:<br>
<br>

<form action="/puzzlemall/register-success.jsp" method="post">
<input type="submit" value="Confirm Registration"><br><br>
</form>

</center>

</body>
</html>