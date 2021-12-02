<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Accounts</title>
</head>
<body>
	<% try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
				
		//String query = "SELECT a.username AS username, a.password AS password, a.firstname AS firstname, a.lastname AS lastname FROM account a WHERE a.type=0";
		
		//flightticketfor		
		out.print("\n");
		String select = "SELECT t1.flightNum AS flightNum, t1.ticketsSold AS ticketsSold, t1.airlineID AS airlineID FROM (SELECT f.flightNum AS flightNum, COUNT(f.ticketNum) AS ticketsSold, f.twoLetID AS airlineID FROM buy b, flightticketfor f WHERE b.ticketNum = f.ticketNum GROUP BY flightNum)t1 ORDER BY ticketsSold DESC";
		PreparedStatement ps = con.prepareStatement(select);
		//		String select = "SELECT t1.flightNum AS flightNum, t1.ticketsSold AS ticketsSold, t1.airlineID AS airlineID FROM (SELECT f.flightNum AS flightNum, COUNT(f.ticketNum) AS ticketsSold, f.twoLetID AS airlineID FROM buy b, flightticketfor f WHERE b.ticketNum = f.ticketNum GROUP BY flightNum)t1 ORDER BY ticketsSold DESC";


		ResultSet rs = ps.executeQuery();
		out.println("Hottest Flights");
		%>
	<table>
	<tr>    
			<td>Flight Number</td>
			<td>Tickets Sold</td>
			<td>Airline ID</td>
		</tr>
			<%
			long flightnum = 0;
			long ticketsSold = 0;
			while (rs.next()) {
				
				flightnum = rs.getInt("flightNum");
				ticketsSold = rs.getInt("ticketsSold");
					%>
	
	<tr>    		
					<td><%= flightnum %></td>
					<td><%= ticketsSold %></td>
					<td><%= rs.getString("airlineID") %>
			<% } %>				
					
				</tr>
	
	</table>
	
	<br>
		<form method="get" action="AdminHomePage.jsp">
			<input type="submit" value="Return to Home Page">
		</form>
	<br>
	<%
	//close the connection.
		con.close();
		%>
	<%} catch (Exception ex) {
		out.print(ex);
		out.print("One or more field is missing :()");
	}%>
	

</body>
</html>
