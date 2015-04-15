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
<title>Puzzle Mall - Purchase Notification</title>
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
int price = 0;
int puzzleid = 0;
boolean successFlag = false;
int result = 0;

try {
	puzzleid = Integer.parseInt(request.getParameter("id")); 
} catch (Exception e) {
	out.println("<font size='6'>Invalid Input</font><br><br>");
	out.flush();
	return;
} //end of try-catch block
	
try {
	conn = ConnectionManager.getConnection();
	String SqlString = 
        "SELECT puzzleid,puzzlename,imagename,price,stock " +
        "FROM puzzles " +
        "WHERE puzzleid = ? and stock > 0";
	
	PreparedStatement pstmt = conn.prepareStatement(SqlString);	
	pstmt.setInt(1,puzzleid);
	ResultSet rs = pstmt.executeQuery();
	
	if(rs.next()) {
		successFlag = true;
	}
	
	if(successFlag == true && request.getParameter("purchase") == null) {
		out.println("<font size='6'>Purchase Notification</font><br><br>");
		out.println("Your are about to buy ");
		out.println("the product <b>" + rs.getString(2)+ "</b>, "); //puzzle name
		out.println("for " + rs.getInt(4)+ "$.<br>"); //price
		out.println("(The product will be sent to the address defined in your profile, " 
				   + "and your credit card will be billed)<br><br>");
		out.println("<img src='/puzzlemall/images/" 
					 + rs.getString(3) + "'><br><br>"); //picture
	    out.println("<a href='/puzzlemall/private/buypuzzle.jsp?id="
					 + rs.getInt(1) + "&purchase=true'>Click Here to Approve the Transaction</a><br>"); //approve button
	} else if (successFlag == false) {
		out.println("<font size='6'>Product not found in stock!</font><br><br>"); 
	} else {
		//perform transaction
		
		SqlString = 
	        "INSERT INTO orders (puzzleid,username,quantity) " +
	        "VALUES (?,?,?) "; 
		
		pstmt = conn.prepareStatement(SqlString);	
		pstmt.setInt(1,puzzleid);
		pstmt.setString(2,
				(String)session.getAttribute(SessionConstants.USERNAME_VARIABLE));
		pstmt.setInt(3,1);
		result = pstmt.executeUpdate();
		
		out.println("<br><font size='6'>Congratulations on your wise choice! enjoy!</font><br><br>"); 
		out.println("The order can be viewed through your profile.<br><br>");
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
</center>

</body>
</html>