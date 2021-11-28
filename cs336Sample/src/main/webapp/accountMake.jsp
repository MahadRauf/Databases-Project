<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Registration</title>
	</head>
	
	<body>

		Add an <!-- the usual HTML way -->
		<% out.println("Account!"); %> <!-- output the same thing, but using 
	                                      jsp programming -->
							  
		<br>
	
		 <!-- Show html form to i) display something, ii) choose an action via a 
		  | radio button -->
		<!-- forms are used to collect user input 
			The default method when submitting form data is GET.
			However, when GET is used, the submitted form data will be visible in the page address field-->
		<!--  <form method="post" action="show.jsp"> -->
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->
		 <!-- <input type="radio" name="command" value="beers"/>To be replaced with sign out page.
		  <br>
		  <input type="radio" name="command" value="bars"/>To be deleted -->
		    <!-- when the radio for bars is chosen, then 'command' will have value 
		     | 'bars', in the show.jsp file, when you access request.parameters -->
		  <!-- <br>
		  <input type="submit" value="submit" />
		</form>
		<br> -->
	
	
	Account type
	<br>
		<form method="post" action="adminAccountRegistration.jsp">
		<table>
		
		<tr>    
		<td>First Name</td><td><input type="text" name="first"></td>
		</tr>
		
		<tr>    
		<td>Last Name</td><td><input type="text" name="last"></td>
		</tr>
		
		<tr>    
		<td>Username</td><td><input type="text" name="username"></td>
		</tr>
		<tr>
		<td>Password</td><td><input type="text" name="password"></td>
		</tr>
		<select name="type" size=1>
				<option value="0">User</option>
				<option value="2">Customer Representative</option>
			</select>
		
		</table>
		<input type="submit" value="Register!">
		</form>
	<br>
	

</body>
</html>
