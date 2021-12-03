<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reserve - Representative</title>
</head>
<body>
	
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String twoLetID = request.getParameter("twoLetID");
		Integer ACID = Integer.valueOf(request.getParameter("ACID"));
		Integer seats = Integer.valueOf(request.getParameter("seats"));
		String opDays = request.getParameter("opDays");
		String queryUpdate = "UPDATE aircraft SET seats = ?, operatingDays = ? WHERE twoLetID = ? and AircraftID = ?";
		PreparedStatement pd = con.prepareStatement(queryUpdate);
		pd.setInt(1, seats);
		pd.setString(2, opDays);
		pd.setString(3, twoLetID);
		pd.setInt(4, ACID);
		pd.executeUpdate();
		
		out.print("Aircraft Successfully Updated");%>
		<br>
		<br>
		<%
		out.print("Airline: " + twoLetID + "\n");%>
		<br>
		<%
		out.print("Aircraft Number: " + ACID + "\n");%>
		<br>
		<%
		out.print("Seats: " + seats + "\n");%>
		<br>
		<%
		out.print("Operating Days: " + opDays + "\n");%>
		<br>
		<br>
	<br>
	<br>
		<form method="get" action="changeAC.jsp">
			<input type="submit" value="Change More Aircrafts">
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