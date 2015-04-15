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
<title>Puzzle Mall - Recent Orders</title>
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
        "SELECT orders.orderid,puzzles.puzzlename, orders.quantity," 
             + "(puzzles.price * orders.quantity), orders.username " +
        "FROM orders LEFT JOIN puzzles ON orders.puzzleid=puzzles.puzzleid " +
        "WHERE orders.username = ?";
		
	PreparedStatement pstmt = conn.prepareStatement(SqlString);	
	pstmt.setString(1,
			(String)session.getAttribute(SessionConstants.USERNAME_VARIABLE));
	ResultSet rs = pstmt.executeQuery();
	 
	out.println("<font size='6'>Recent Orders:</font><br><br>");
	out.println("<table border='1'>");
	out.println("<tr><td><b><u>Order Number</b></u></td><td><b><u>Owner</b></u></td>"
						 + "<td><b><u>Puzzle Name</b></u></td>"
			             + "<td><b><u>Quantity</b></u></td><td><b><u>Total Cost</b></u></td></tr>");
	 while(rs.next()) {
		 out.println("<tr>");
		 out.println("<td>" + rs.getInt(1)+ "</td>"); //Order Number
		 out.println("<td>" + rs.getString(5) + "</td>"); //Purchasing User
		 out.println("<td>" + rs.getString(2) + "</td>"); //Puzzle Name
		 out.println("<td>" + rs.getInt(3) + "</td>"); //Quantity
		 out.println("<td>" + rs.getInt(4) + "</td>"); //Total Cost (Quantity*Price)
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