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
<title>Puzzle Mall Password Recovery - Final Phase</title>
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
	response.sendRedirect("/puzzlemall/recovery-phase1.jsp");
	
	return;	
} else if( ((String)session.getAttribute(SessionConstants.FLOW_PHASE3_VARIABLE))
		.equalsIgnoreCase(SystemConstants.FALSE_VALUE)) {
	session.setAttribute(SessionConstants.REGISTRATION_MSG_VARIABLE,
		"Please perform all the phases of the process.");
	response.sendRedirect("/puzzlemall/recovery-phase1.jsp");
	
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

String password = null;

Connection conn = null;

try {
	
	conn = ConnectionManager.getConnection();
	String SqlString = 
        "SELECT password "
      + "FROM users "
      + "WHERE username = ?";
	
		PreparedStatement pstmt = conn.prepareStatement(SqlString);
		pstmt.setString(1, username);
		
		
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			out.println("<center>");
			out.println("Your password is: <br>");
			out.println("<font size='6'>" + HtmlEncoder.htmlEncode(rs.getString(1))
					  + "</font><br><br>");
			out.println("</center>");
		}
 	 	
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

<br>
Try and remember it... for your own safety...<br>
<br>

</center>


</body>
</html>