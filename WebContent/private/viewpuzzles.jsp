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
<title>Puzzle-Mall Puzzle Collection </title>
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
	
Connection conn = null;
	
	
try {
	conn = ConnectionManager.getConnection();
	String SqlString = 
        "SELECT puzzleid,puzzlename,imagename,price " +
        "FROM puzzles " +
        "WHERE stock > 0";
		
	PreparedStatement pstmt = conn.prepareStatement(SqlString);			
	ResultSet rs = pstmt.executeQuery();
	 
	out.println("<font size='6'>Currently Available Puzzles:</font><br><br>");
	out.println("<table border='1'>");
	out.println("<tr><td><b><u>Puzzle Name</b></u></td><td><b><u>Price</b></u></td>"
			             +"<td><b><u>Picture</b></u></td><td><b><u>Action</b></u></td></tr>");
	 while(rs.next()) {
		 out.println("<tr>");
		 out.println("<td>" + rs.getString(2)+ "</td>"); //puzzle name
		 out.println("<td>" + rs.getInt(4)+ "</td>"); //price
		 out.println("<td><img src='/puzzlemall/images/" 
				 + rs.getString(3) + "'></td>"); //picture
		 out.println("<td><a href='/puzzlemall/private/buypuzzle.jsp?id="
				 + rs.getInt(1) + "'>Buy</a></td>"); //buy button
		 out.println("</tr>");
		 
	 }
	 out.println("</table>");
	 			
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
</center>

</body>
</html>