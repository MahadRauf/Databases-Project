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
		String select = "SELECT t1.user AS user, t1.revenue AS revenue, t1.fees AS fees FROM (SELECT b.username AS user, SUM(totalFare) AS revenue, SUM(bookingFee) AS fees FROM buy b, flightticketfor f WHERE b.ticketNum = f.ticketNum)t1 HAVING revenue = MAX(t1.revenue)";
		PreparedStatement ps = con.prepareStatement(select);
		//select t1.user AS user, t1.revenue AS revenue, t1.fees AS fees FROM (SELECT b.username AS user, SUM(totalFare) AS revenue, SUM(bookingFee) AS fees FROM buy b, flightticketfor f WHERE b.ticketNum = f.ticketNum)t1 HAVING revenue = MAX(t1.revenue);

		ResultSet rs = ps.executeQuery();
		out.println("Costumer who generated most revenue");
		%>
	<table>
	<tr>    
			<td>User</td>
			<td>Total Fare</td>
			<td>Total Fees</td>
		</tr>
			<%
			long totalFare = 0;
			long totalFees = 0;
			if (rs.next()) {
				
				totalFare = rs.getInt("revenue");
				totalFees = rs.getInt("fees");
			}		%>
	
	<tr>    
					<td><%= rs.getString("user") %>
					<td><%= totalFare %></td>
					<td><%= totalFees %></td>
					
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
