<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change Flights - Representative</title>
</head>
<body>
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	%>
	<br>
	Edit an Existing Flight
		<form method="get" action="edExistingF.jsp">
			<table>
				<tr>    
					<td>Two Letter Airline ID(Capital)</td><td><input type="text" name="twoLetID" required></td>
				</tr>
				<tr>
					<td>Aircraft ID</td><td><input type="text" name="ACID" required></td>
				</tr>
				<tr>    
					<td>Flight Number</td><td><input type="text" name="fNum" required></td>
				</tr>		
			</table>
			<input type="submit" value="Edit">
		</form>
	<br>
	
	<br>
	Delete an Existing Flight
		<form method="get" action="delExistingF.jsp">
			<table>
				<tr>    
					<td>Two Letter Airline ID(Capital)</td><td><input type="text" name="twoLetID" required></td>
				</tr>
				<tr>
					<td>Aircraft ID</td><td><input type="text" name="ACID" required></td>
				</tr>
				<tr>    
					<td>Flight Number</td><td><input type="text" name="fNum" required></td>
				</tr>		
			</table>
			<input type="submit" value="Delete">
		</form>
	<br>
	
	<br>
	Add a Flight
		<form method="get" action="addF.jsp">
			<table>
				<tr>    
					<td>Two Letter Airline ID (Capital)</td><td><input type="text" name="twoLetID" required></td>
				</tr>
				<tr>
					<td>Aircraft ID</td><td><input type="text" name="ACID" required></td>
				</tr>
				<tr>    
					<td>Flight Number</td><td><input type="text" name="fNum" required></td>
				</tr>
				<tr>
					<td>From Airport (3 letter ID)</td><td><input type="text" name="fPort" required></td>
				</tr>
				<tr>
					<td>To Airport (3 letter ID)</td><td><input type="text" name="tPort" required></td>
				</tr>
				<tr>
					<td>Departure Date (YYYY-MM-DD)</td><td><input type="text" name="dDate" required></td>
				</tr>
				<tr>
					<td>Arrival Date (YYYY-MM-DD)</td><td><input type="text" name="aDate" required></td>
				</tr>
				<tr>
					<td>Takeoff Time (HH:mm 24 hour time)</td><td><input type="text" name="tTime" required></td>
				</tr>
				<tr>
					<td>Landing Time (HH:mm 24 hour time)</td><td><input type="text" name="lTime" required></td>
				</tr>
				<tr>
					<td>Number of Stops</td><td><input type="text" name="stops" required></td>
				</tr>	
			</table>
			<label for="type">Type:</label>
			<select id="type" name="type">
				<option value="0">Domestic</option>
				<option value="1">International</option>
			</select>
			<br>
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
	}%>
	

</body>
</html>