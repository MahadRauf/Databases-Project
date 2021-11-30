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
		float month = Float.valueOf(request.getParameter("month"));		
		String monthName;
		switch ((int)month) {
        case 1:  monthName = "January";
                 break;
        case 2:  monthName = "February";
                 break;
        case 3:  monthName = "March";
                 break;
        case 4:  monthName = "April";
                 break;
        case 5:  monthName = "May";
                 break;
        case 6:  monthName = "June";
                 break;
        case 7:  monthName = "July";
                 break;
        case 8:  monthName = "August";
                 break;
        case 9:  monthName = "September";
                 break;
        case 10: monthName = "October";
                 break;
        case 11: monthName = "November";
                 break;
        case 12: monthName = "December";
                 break;
        default: monthName = "Invalid month";
                 break;
    }
		out.print("Sales Report for " + monthName + ".");		
		//String query = "SELECT a.username AS username, a.password AS password, a.firstname AS firstname, a.lastname AS lastname FROM account a WHERE a.type=0";
		
		//flightticketfor		
		out.print("\n");
		String select = "SELECT SUM(f.totalFare) AS total_fare, SUM(f.bookingFee) AS totalFee, COUNT(f.totalFare) AS totalSold FROM flightticketfor f, buy b  WHERE f.ticketNum = b.ticketNum AND MONTH(b.purchaseDate) = ?";
		PreparedStatement ps = con.prepareStatement(select);
		ps.setFloat(1, month);
		ResultSet rs = ps.executeQuery();
		%>
	<table>
	<tr>    
			<td>Total Sales </td>
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