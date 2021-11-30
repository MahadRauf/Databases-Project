<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sales</title>
	</head>
	
	<body>

		Choose a <!-- the usual HTML way -->
		<% out.println("Month!"); %> <!-- output the same thing, but using 
	                                      jsp programming -->
							  
		<br>
	
		 
	
	
	<br>
		<form method="post" action="salesForMonth.jsp">
		<table>
		
		<select name="month" size=12>
				<option value="1">January</option>
				<option value="2">February</option>
				<option value="3">March</option>
				<option value="4">April</option>
				<option value="5">May</option>
				<option value="6">June</option>
				<option value="7">July</option>
				<option value="8">August</option>
				<option value="9">September</option>
				<option value="10">October</option>
				<option value="11">November</option>
				<option value="12">December</option>
			</select>
		
		</table>
		<input type="submit" value="Select a Month!">
		</form>
	<br>
	

</body>
</html>
