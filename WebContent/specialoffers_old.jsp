<%@page import="com.puzzlemall.constants.SystemConstants"%>
<%@page import="java.lang.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%@page import="com.puzzlemall.security.HtmlEncoder" %>
<%@page import="java.sql.*" %>
<%@page import="com.puzzlemall.database.ConnectionManager" %>

<%@ include file="../includes/disablecache.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Puzzle Mall - Special Offers - 1999</title>
</head>
<body>

<%@ include file="../includes/sitebanner.jsp" %>

<center>

<font size="6">Sale! 20% discount on the following puzzles!!!</font><br><br>
<font size="5">Only available to premium customers!</font><br><br>

<%

Connection conn = null;
	
try {
	conn = ConnectionManager.getConnection();
		
	String SqlString = 
        "SELECT p.puzzleid, p.puzzlename, p.imagename, " + 
          "(p.price * 0.9) specialprice, count(*) popularity " + 
		"FROM puzzles p,  orders o " +
		"WHERE p.puzzleid = o.puzzleid " +
		"GROUP BY p.puzzleid, p.puzzlename, p.imagename, (p.price * 0.8) " +
		" HAVING count(*) <= 1 ";
			
	PreparedStatement pstmt = conn.prepareStatement(SqlString);			
	ResultSet rs = pstmt.executeQuery();
	
	Thread.sleep(4000); //delay the response to simulate a complex query
	 
	out.println("<table border='1'>");
	out.println("<tr><td><b><u>Puzzle Name</b></u></td><td><b><u>Price</b></u></td>"
			             +"<td><b><u>Picture</b></u></td></tr>");
	 while(rs.next()) {
		 out.println("<tr>");
		 out.println("<td>" + rs.getString(2)+ "</td>"); //puzzle name
		 out.println("<td>" + rs.getInt(4)+ "</td>"); //price
		 out.println("<td><img src='/puzzlemall/images/" 
				 + rs.getString(3) + "'></td>"); //picture
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