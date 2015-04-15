<%
	response.addHeader("Pragma","no-cache");
	response.addHeader("Pragma","no-store");
	response.addHeader("Pragma","private");
	response.addHeader("Cache-control","no-cache");
	response.addHeader("Cache-control","no-store");
	response.addHeader("Cache-control","private");
	response.addDateHeader ("Expires", 0);
%>