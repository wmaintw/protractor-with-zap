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
<title>Puzzle Mall - Supplier View - Current Stock </title>
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

if(role == null) {
	out.println("<font size='6' color='red'>Permission Denied!</font><br><br>");
	out.flush();
	return;
} else if(!role.equalsIgnoreCase(SystemConstants.ADMIN_ROLE) && 
		  !role.equalsIgnoreCase(SystemConstants.SUPPLIER_ROLE) ) {
	out.println("<font size='6' color='red'>Permission Denied!</font><br><br>");
	out.flush();
	return;
}
	
Connection conn = null;
	
try {
	conn = ConnectionManager.getConnection();
	
	String SqlString =  
        "SELECT puzzleid,puzzlename, stock " 
      + "FROM puzzles ";
		
	PreparedStatement pstmt = conn.prepareStatement(SqlString);
	ResultSet rs = pstmt.executeQuery();
	
	out.println("<font size='6'>Initial Stock Per Product:</font><br><br>");
	out.println("<table border='1'>");
	out.println("<tr><td><b><u>Puzzle ID</b></u></td><td><b><u>Puzzle Name</b></u></td>"
						 + "<td><b><u>Stock</b></u></td></tr>");
	
	while(rs.next()) {
		 out.println("<tr>");
		 out.println("<td>" + rs.getInt(1)+ "</td>"); //Puzzle ID
		 out.println("<td>" + rs.getString(2) + "</td>"); //Puzzle Name
		 out.println("<td>" + rs.getInt(3) + "</td>"); //Stock
		 out.println("</tr>");
		 
	 }
	 out.println("</table><br>");
	 
	
	SqlString = 
	    "SELECT orders.puzzleid,puzzles.puzzlename,SUM(orders.quantity) " +
	    "FROM orders LEFT JOIN puzzles ON orders.puzzleid=puzzles.puzzleid " +
	    "GROUP BY orders.puzzleid, puzzles.puzzlename"; 
	
	pstmt = conn.prepareStatement(SqlString);
	rs = pstmt.executeQuery();
	 
	out.println("<font size='6'>Recent Sales Per Product:</font><br><br>");
	out.println("<table border='1'>");
	out.println("<tr><td><b><u>Puzzle ID</b></u></td><td><b><u>Puzzle Name</b></u></td>"
						 + "<td><b><u>Total Units Sold</b></u></td></tr>");
	 
	 while(rs.next()) {
		 out.println("<tr>");
		 out.println("<td>" + rs.getInt(1)+ "</td>"); //Puzzle ID
		 out.println("<td>" + rs.getString(2) + "</td>"); //Puzzle Name
		 out.println("<td>" + rs.getInt(3) + "</td>"); //Total Sales
		 out.println("</tr>");
		 
	 }
	 out.println("</table><br>");
	 			
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