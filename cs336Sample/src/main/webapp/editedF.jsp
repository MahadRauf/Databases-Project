<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edited Flight - Representative</title>
</head>
<body>
	
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String twoLetID = request.getParameter("twoLetID");
		Integer ACID = Integer.valueOf(request.getParameter("ACID"));
		Integer fNum = Integer.valueOf(request.getParameter("fNum"));
		String fPort = request.getParameter("fPort");
		String tPort = request.getParameter("tPort");
		String dDate = request.getParameter("dDate");
		String aDate = request.getParameter("aDate");
		String tTime = request.getParameter("tTime");
		String lTime = request.getParameter("lTime");
		Integer stops = Integer.valueOf(request.getParameter("stops"));
		Integer type = Integer.valueOf(request.getParameter("type"));

		String queryUpdate = "UPDATE flightBy SET fromAirport = ?, toAirport = ?, departureDate = ?, arrivalDate = ?, takeoff = ?, landing = ?, numStop = ?, type = ? " + 
		"WHERE twoLetID = ? and AircraftID = ? and flightNum = ?";
		PreparedStatement pd = con.prepareStatement(queryUpdate);
		pd.setString(1, fPort);
		pd.setString(2, tPort);
		pd.setString(3, dDate);
		pd.setString(4, aDate);
		pd.setString(5, tTime);
		pd.setString(6, lTime);
		pd.setInt(7, stops);
		pd.setInt(8, type);
		pd.setString(9, twoLetID);
		pd.setInt(10, ACID);
		pd.setInt(11, fNum);
		
		pd.executeUpdate();
		
		String queryUpdate1 = "UPDATE flightticketfor f SET f.from = ?, f.to = ? WHERE f.twoLetID = ? and f.AircraftID = ? and f.flightNum = ?";
		PreparedStatement pd1 = con.prepareStatement(queryUpdate1);
		pd1.setString(1, fPort);
		pd1.setString(2,tPort);
		pd1.setString(3, twoLetID);
		pd1.setInt(4, ACID);
		pd1.setInt(5, fNum);
		
		pd1.executeUpdate();
		out.print("Flight Successfully Updated");%>
		<br>
		<br>
		<%out.print("Airline: " + twoLetID + "\n");%>
			<br>
			<%out.print("Aircraft Number: " + ACID + "\n");%>
			<br>
			<%out.print("Flight Number: " + fNum + "\n");%>
			<br>
			<%out.print("From: " + fPort + "\n");%>
			<br>
			<%out.print("To: " + tPort + "\n");%>
			<br>
			<%out.print("Departure Date: " + dDate + "\n");%>
			<br>
			<%out.print("Arrival Date: " + aDate + "\n");%>
			<br>
			<%out.print("Takeoff Time: " + tTime + "\n");%>
			<br>
			<%out.print("Landing Time: " + lTime + "\n");%>
			<br>
			<%out.print("Number of Stops: " + stops + "\n");%>
			<br>
			<%if(type == 0){
				out.print("Type: Domestic"  + "\n");
			}else{
				out.print("Type: International"  + "\n");
			}%>
			<br>
		<br>
	<br>
	<br>
		<form method="get" action="changeF.jsp">
			<input type="submit" value="Change More Flights">
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