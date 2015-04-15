<%@page import="com.puzzlemall.constants.SystemConstants"%>
<%@page import="org.apache.derby.jdbc.Driver40"%>
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
<title>Puzzle Mall - Site Map</title>
</head>
<body>

<%@ include file="../includes/sitebanner.jsp" %>

<%

String username = (String)session.getAttribute(SessionConstants.USERNAME_VARIABLE);
String role = (String)session.getAttribute(SessionConstants.ROLE_VARIABLE);

Connection conn = null;
int totalQuantity = 0;

if(username != null) {
	
	try {
		conn = ConnectionManager.getConnection();
		
		//#########################################
		String SqlString = 
	        "SELECT username,Sum(quantity) " +
	        "FROM orders " +
	        "WHERE username = '" + username + "'" +
	        "GROUP BY username";
		//#########################################
			
		PreparedStatement pstmt = conn.prepareStatement(SqlString);	
		ResultSet rs = pstmt.executeQuery();
		
		 if(rs.next()) {
			 totalQuantity = rs.getInt(2);
		 }
			
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
<font size="5" color="red"> By Now, You Bought <%=totalQuantity%> Puzzles!</font><br>
Don't stop now... Just one more puzzle...
<br><br>
</center>

<%
}


%>

<center>

<font size="6">Site Map</font><br>
<br>


<table>

<%if(username != null){ %>
<tr>
<td><a href="/puzzlemall/private/mainmenu.jsp">Main Menu</a></td>
</tr>
<tr>
<td><a href="/puzzlemall/private/viewpuzzles.jsp">View Puzzles</a></td>
</tr>
<tr>
<td><a href="/puzzlemall/private/vieworders.jsp">View Orders</a></td>
</tr>
<tr>
<td><a href="/puzzlemall/logout.jsp">Logout</a></td>
</tr>
<%} %>
<tr>
<td><a href="/puzzlemall/login.jsp">Login Page</a></td>
</tr>
<tr>
<td><a href="/puzzlemall/register-phase1.jsp">Registration Page</a></td>
</tr>
<tr>
<td><a href="/puzzlemall/recovery-phase1.jsp">Password Recovery Page</a></td>
</tr>
<tr>
<td><a href="/puzzlemall/help/mainhelp.jsp">Main Help</a></td>
</tr>

<%if(role!=null){
	if(role.equalsIgnoreCase(SystemConstants.SUPPLIER_ROLE) ||
	   role.equalsIgnoreCase(SystemConstants.ADMIN_ROLE)){
%>
<tr>
<td><a href="/puzzlemall/private/viewstock.jsp">View Stock</a></td>
</tr>
<%
	}
} %>

<%if(role!=null){
	if(role.equalsIgnoreCase(SystemConstants.ADMIN_ROLE)){
%>
<tr>
<td><a href="/puzzlemall/private/viewfullorders.jsp">View All Orders</a></td>
</tr>
<%
	}
} %>

</table>
<br>

</center>

</body>
</html>