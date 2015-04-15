<%@page import="com.puzzlemall.constants.SessionConstants" %>
<%
	if(session.getAttribute(SessionConstants.USERNAME_VARIABLE) == null)
	{
		RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
		dispatcher.forward(request,response);
		return;
	}
%>