<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Aircrafts - Representative</title>
</head>
<body>
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	%>
	<br>
	Edit an Existing Aircraft
		<form method="get" action="edExistingAC.jsp">
			<table>
				<tr>    
					<td>Two Letter Airline ID(Capital)</td><td><input type="text" name="twoLetID" required></td>
				</tr>
				<tr>
					<td>Aircraft ID</td><td><input type="text" name="ACID" required></td>
				</tr>		
			</table>
			<input type="submit" value="Edit">
		</form>
	<br>
	
	<br>
	Delete an Existing Aircraft
		<form method="get" action="delExistingAC.jsp">
			<table>
				<tr>    
					<td>Two Letter Airline ID(Capital)</td><td><input type="text" name="twoLetID" required></td>
				</tr>
				<tr>
					<td>Aircraft ID</td><td><input type="text" name="ACID" required></td>
				</tr>		
			</table>
			<input type="submit" value="Delete">
		</form>
	<br>
	
	<br>
	Add an Aircraft
		<form method="get" action="addAC.jsp">
			<table>
				<tr>    
					<td>Two Letter Airline ID(Capital)</td><td><input type="text" name="twoLetID" required></td>
				</tr>
				<tr>
					<td>Aircraft ID</td><td><input type="text" name="ACID" required></td>
				</tr>
				<tr>
					<td>Seats</td><td><input type="text" name="seats" required></td>
				</tr>
				<tr>
					<td>Operating Days(ex:SMTWTFS, underscore on non-operating days: SMT_TFS)</td><td><input type="text" name="opDays" required></td>
				</tr>		
			</table>
			<input type="submit" value="Add">
		</form>
	<br>
	
	<br>
		<form method="get" action="RepHomePage.jsp">
			<input type="submit" value="Return to Home Page">
		</form>
	<br>
		<% con.close(); %>
	<%} catch (Exception ex) {
		out.print(ex);
		out.print("One or more field is missing :()");
	}%>
	

</body>
</html>