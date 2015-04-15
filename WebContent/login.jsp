<%@page import="org.apache.derby.jdbc.Driver40"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="com.puzzlemall.database.ConnectionManager" %>
<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%@page import="com.puzzlemall.security.HtmlEncoder" %>
<%@page import="com.puzzlemall.logic.DataAccessMethods" %>

<%@ include file="../includes/disablecache.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to the Puzzle Mall</title>
</head>
<body>

<%@ include file="../includes/sitebanner.jsp" %>

<b><%= request.getParameter("name") %></b>

<%

if(session.getAttribute(SessionConstants.LOGIN_MSG_VARIABLE) != null) {


%>

<center>
<font size="5" color="red"><%=session.getAttribute(SessionConstants.LOGIN_MSG_VARIABLE) %></font>
<br><br>
</center>

<%
}

session.invalidate(); //invalidate session, in case one exists

session = request.getSession(true);

String username = request.getParameter("username");
String password = request.getParameter("password");

if ( username == null && password == null) {
%>

<center>

<font size="6">Puzzle Mall</font><br>
The biggest collection of puzzles in the most desolate section of the world<br>
<br>

<b>Login to view our vast collection of puzzles!</b><br><br>
<form action="/puzzlemall/login.jsp" method="post">
Username: <input type="text" name="username" id="username"><br>
Password: <input type="password" name="password" id="password" autocomplete="off"><br>
<br>
<input type="submit" value="sign in"><br><br>
</form>

<a href="/puzzlemall/login-premium.jsp"><b>Premium Customers Entry</b></a> <br><br>
<a href="/puzzlemall/recovery-phase1.jsp">Forgot your password?</a> <br><br>
<a href="/puzzlemall/register-phase1.jsp">Not a user? don't be puzzled... Register!</a> <br><br><br>
<a href="/puzzlemall/sitemap.jsp">Site Map</a> &nbsp&nbsp&nbsp<a href="/puzzlemall/help/mainhelp.jsp">Help</a><br><br>

</center>

<%
} else {
	Connection conn = null;
	
	//######################################
	session.setAttribute(
	 	SessionConstants.USERNAME_VARIABLE,
	 	username);
	//######################################
	
	try {
		conn = ConnectionManager.getConnection();
		String SqlString = 
	        "SELECT username " +
	        "FROM users " +
	        "WHERE username = ? AND password = ?";
		
			PreparedStatement pstmt = conn.prepareStatement(SqlString);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			
			ResultSet rs = pstmt.executeQuery();
	 		
	 		if(rs.next()) {
	 			session.setAttribute(
	 					SessionConstants.USERNAME_VARIABLE,
	 					(String)rs.getString(1));
	 			
	 			session.setAttribute(
	 					SessionConstants.ROLE_VARIABLE,
	 					DataAccessMethods.getUserRole(username));
	 			
	 			RequestDispatcher dispatcher = request.getRequestDispatcher("/private/mainmenu.jsp");
	 			dispatcher.forward(request,response);
	 			
	 	    } else {
	 	    	session.setAttribute(SessionConstants.LOGIN_MSG_VARIABLE,
	 	    						 "Login failed: invalid username or password");
	 	    	response.sendRedirect("/puzzlemall/login.jsp");
	 	 		
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
	
} //end of main if-else block
%>


</body>
</html>