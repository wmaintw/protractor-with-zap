<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="com.puzzlemall.constants.SystemConstants" %>
    
<%@ include file="../includes/disablecache.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pen Tester Help</title>
</head>
<body>

<center>
<font size='6'>Pen Tester Help Page</font><br><br>
This page provides information on default accounts, vulnerabilities and attack sequences...<br>
So if you like challenges, STOP READING NOW. <br><br><br><br>
</center>

<font size='5'>Default User Accounts</font><br><br>
<table border="1">
<tr>
<td><b><u>Username</u></b></td><td><b><u>Password</u></b></td>
<td><b><u>Role</u></b></td><td><b><u>Recovery Answer</u></b></td>
</tr>

<tr>
<td>admin</td><td>superlongpass12321</td>
<td><%=SystemConstants.ADMIN_ROLE%></td><td>42</td>
</tr>

<tr>
<td>user1</td><td>guessme12321</td>
<td><%=SystemConstants.CUSTOMER_ROLE%></td><td>NOW</td>
</tr>

<tr>
<td>user2</td><td>guessme32123</td>
<td><%=SystemConstants.CUSTOMER_ROLE%></td><td>Jupiter</td>
</tr>

<tr>
<td>user3</td><td>guessme11111</td>
<td><%=SystemConstants.SUPPLIER_ROLE%></td><td>Banana</td>
</tr>

</table>

<br><br>

<font size='5'>Sample Session Puzzling Attack Vectors</font><br><br>

<b><u>Authentication Bypass Session Puzzling Sequences</u></b><br><br>

<b><i>Login Page Premature Session Population</i></b><br>

<a href="http://www.youtube.com/watch?v=1Pg047-ju7Y"><b>Demo</b></a></a><br>

(1) Forward the browser transmissions to an interception proxy (burp, paros, webscarab, etc) <br>
(2) Access the login page (login.jsp)<br>
(3) Activate the interception feature of the proxy<br>
(4) Submit the login form with a username value (and any password)<br>
&nbsp&nbsp&nbsp(the login page populates the session with the username prior to the database query)<br>
(5) Forward the initial request from the proxy to the server<br>
(6) When the browser attempts to redirect the user to the login page, drop the request<br>
&nbsp&nbsp&nbsp(the login page invalidates the session in its initial phases, so it's important to avoid accessing it)<br>
(7) directly access the internal menu page (/private/mainmenu.jsp) <br>

<br>
<b><i>Partial Registration Session Population</i></b><br>

(1) Access the registration page (register-phase1.jsp)<br>
(2) Provide a valid username, and fill in the rest of the details in the first page <br>
(3) Submit the first registration form <br>
&nbsp&nbsp&nbsp(the registration page populates the session with the username & customer role prior to the end of the process)<br>
(4) directly access the internal menu page (/private/mainmenu.jsp) <br>
 
<br>
<b><i>Partial Password Recovery Session Population</i></b><br>

<a href="http://www.youtube.com/watch?v=WaO5T_fYpvs"><b>Demo</b></a></a><br>

(1) Access the password recovery page (recovery-phase1.jsp)<br>
(2) Provide a valid username, and submit the form <br>
&nbsp&nbsp&nbsp(the password recovery page populates the session with the username prior to the end of the process)<br>
(3) directly access the internal menu page (/private/mainmenu.jsp) <br>
 
 
<br><br>

<b><u>Impersonation Session Puzzling Sequences</u></b><br><br>

<b><i>User Impersonation via Session Puzzling</i></b><br>

<a href="http://www.youtube.com/watch?v=6NWItGci7is"><b>Demo</b></a></a><br>

(1) Login into the application with any user<br>
(2) Perform the first phase of the registration or password recovery (with another valid username)<br>
(3) Access the main menu (/private/mainmenu.jsp) or the profile page (/private/viewprofile.jsp)<br> 
 
<br><br>

<b><u>Privilege Escalation Session Puzzling Sequences</u></b><br><br>

<b><i>Help Page Unnecessary Session Population</i></b><br>

(1) Login into the application and access the main menu <br>
(2) Access the supplier help page (/help/supplierhelp.jsp) or the administrative help (/help/adminhelp.jsp)<br>
&nbsp&nbsp&nbsp(the various help pages populate the session with role specific data)<br>
(3) Re-access the main menu (/private/mainmenu.jsp) <br>


<br><br>

<b><u>Flow Bypassing via Session Puzzling Sequences</u></b><br><br>

<b><i>Password Recovery via Session Puzzling</i></b><br>

<a href="http://www.youtube.com/watch?v=EjDUcbRf0Y4"><b>Demo</b></a></a><br>

(1) Access the registration page first (register-phase1.jsp)<br>
(2) Open another tab and access the password recovery page (recovery-phase1.jsp)<br>
(3) Perform the registration up to it's third phase (with a new username).<br>
(4) Send an existing valid username in the password recovery first phase, and submit the form <br>
(5) Directly access the last phase of the password recovery process (recovery-success.jsp) <br>
&nbsp&nbsp&nbsp(since the registration and password recovery processes use common flow flags, performing phases in one process can help advance the other)<br>

<br><br>

<b><u>"Traditional" Attacks via Session Puzzling Sequences</u></b><br><br>

<b><i>SQL Injection via Session Puzzling</i></b><br>

(1) Access the registration page (register-phase1.jsp)<br>
(2) Send a quote in the username, while sending valid values in the rest of the first page parameters<br>
(3) Submit the first registration form <br>
(4) Access the sitemap page (sitemap.jsp)<br>
&nbsp&nbsp&nbsp(although the page does not embed user input into queries, it does embed session stored values that derived from input)<br>
(5) Analyze the exception, and submit the registration page again with different values to continue exploiting the injection<br>
<br>

<b><i>XSS via Session Puzzling (a.k.a as session persistent XSS)</i></b><br>

(1) Access the registration page (register-phase1.jsp)<br>
(2) Send an XSS payload in the username, while sending valid values in the rest of the first page parameters<br>
(3) Submit the first registration form <br>
(4) Access the internal main menu page (/private/mainmenu.jsp)<br>
&nbsp&nbsp&nbsp(although the database values are encoded, values originating directly from the session are not)<br>

<br><br>

<b><u>Temporal Session Race Conditions Sequences</u></b><br><br>

<b><i>Exploiting Temporal Session Race Conditions via RegEx DoS</i></b><br>

<a href="http://www.youtube.com/watch?v=3k_eJ1bcCro"><b>Demo</b></a></a><br>

(1) Access the premium login page (login-premium.jsp)<br>
(2) Submit the premium login form with a valid username value (admin/user1/etc),<br> 
&nbsp&nbsp&nbsp&nbsp&nbsp and the following password: aaaaaaaaaaaaaaaaaaaaaaaaaa!<br>
(the login page populates the session with the username prior to the database query and clears the session in login or validation failures,<br>
but it is possible to increase the lifespan of the value using a RegEx DoS payload)<br>
(3) directly access the internal menu page (/private/mainmenu.jsp) while the server is processing the login request<br>

<br>

<b><i>Exploiting Temporal Session Race Conditions via Connection Pool Consumption</i></b><br>

<a href="http://www.youtube.com/watch?v=woWECWwrsSk"><b>Demo</b></a></a><br>

(1) Access the premium login page (login-premium.jsp)<br>
(2) Use an automated tool with 30-40 threads to repeatedly access the "specialoffers.jsp"" page<br>
(3) Submit the premium login form with a valid username value (admin/user1/etc) and ANY password<br> 
(the login page populates the session with the username prior to the database query and clears the session in login or validation failures,<br>
but it is possible to increase the lifespan of the value by occupying connections)<br>
(4) directly access the internal menu page (/private/mainmenu.jsp) while the server is processing the login request<br>


</body>
</html>