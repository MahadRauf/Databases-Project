<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Waiting List - Representative</title>
</head>
<body>
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	%>
	
	<br>
	Find users on waiting list
		<form method="get" action="dispWaiting.jsp">
			<table>
				<tr>
					<td>From Airport (3 letter ID)</td><td><input type="text" name="fPort" required></td>
				</tr>
				<tr>
					<td>To Airport (3 letter ID)</td><td><input type="text" name="tPort" required></td>
				</tr>	
			</table>
			<label for="type">Type:</label>
			<select id="type" name="type">
				<option value="0">One-Way</option>
				<option value="1">Round-Trip</option>
			</select>
			<br>
			<input type="submit" value="Get List">
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