<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change Reservation - Representative</title>
</head>
<body>
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	%>
	<br>
	Get Flights Departing and Arriving from an Airport
		<form method="get" action="APFlightsShow.jsp">
			<table>
				<tr>    
					<td>3 Letter ID of Airport(All Capital)</td><td><input type="text" name="airport"></td>
				</tr>		
			</table>
			<input type="submit" value="Go!">
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