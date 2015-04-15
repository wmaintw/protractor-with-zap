<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%
	if(session.getAttribute(SessionConstants.USERNAME_VARIABLE) != null &&
	   session.getAttribute(SessionConstants.ROLE_VARIABLE) != null) {
		out.println("<a href='/puzzlemall/private/mainmenu.jsp'><b>Main Menu</b></a>&nbsp&nbsp");
		out.println("<a href='/puzzlemall/sitemap.jsp'><b>Site Map</b></a><br>");
	}
%>