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
		String air = request.getParameter("air");
		out.print("Revenue Summary for Airline " + air);		
		//String query = "SELECT a.username AS username, a.password AS password, a.firstname AS firstname, a.lastname AS lastname FROM account a WHERE a.type=0";
		
		//flightticketfor		
		out.print("\n");
		String select = "SELECT SUM(f.totalFare) AS total_fare, SUM(f.bookingFee) AS totalFee, COUNT(f.totalFare) AS totalSold FROM flightticketfor f, buy b  WHERE f.ticketNum = b.ticketNum AND f.twoLetId = ?";
		PreparedStatement ps = con.prepareStatement(select);
		ps.setString(1, air);
		ResultSet rs = ps.executeQuery();
		%>
	<table>
	<tr>    
			<td>Total Sales</td>
			<td>Total Booking Fees </td>
			<td>Total Tickets Sold </td>
		</tr>
			<%
			long totalFare = 0;
			long totalFee = 0;
			int totalSold = 0;
			if (rs.next()) {
				totalFare = rs.getInt("total_fare");
				totalFee = rs.getInt("totalFee");
				totalSold = rs.getInt("totalSold");
			}		%>
	
	<tr>    
					<td><%= totalFare %></td>
					<td><%= totalFee%></td>
					<td><%= totalSold%></td>
					
				</tr>
	
	</table>
	<%
	String query = "SELECT f.ticketNum AS tn, f.totalFare AS tf, f.bookingFee AS bf, f.class AS class FROM flightticketfor f, buy b  WHERE f.ticketNum = b.ticketNum AND f.twoLetId = ?";
	PreparedStatement ps1 = con.prepareStatement(query);
	ps1.setString(1, air);
	
	ResultSet result = ps1.executeQuery();
	%>
	<table>
	<tr>    
			<td>Ticket Number</td>
			<td>Fare</td>
			<td>Booking Fee</td>
			<td>Class</td>
		</tr>
			<%
			//parse out the results
			//we are using fromy and tom cause from and to will not work as they are keywords in sql smh >:(
			while (result.next()) { 
				Integer fClass = Integer.valueOf(result.getString("class"));
				String classType;
				switch (fClass) {
		        case 0:  classType = "Economy";
		                 break;
		        case 1:  classType = "Business";
		                 break;
		        case 2:  classType = "First";
		                 break;
		        default: classType = "Invalid";
		                 break;
		    }
				
			%>
				<tr>    
					<td><%= result.getString("tn")%></td>
					<td><%= result.getString("tf") %></td>
					<td><%= result.getString("bf") %></td>
					<td><%= classType%></td>
				</tr>
				

			<% }%>
	
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
