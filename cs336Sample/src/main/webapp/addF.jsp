<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add FLight - Representative</title>
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
		
		String queryExists = "SELECT * FROM flightBy f WHERE f.twoLetID = ? and f.AircraftID = ? and f.flightNum = ?";
		PreparedStatement pd = con.prepareStatement(queryExists);
		pd.setString(1, twoLetID);
		pd.setInt(2, ACID);
		pd.setInt(3, fNum);
		ResultSet rs = pd.executeQuery();
		
		out.print("here");

		if ( !rs.isBeforeFirst() ) {
			
			String queryAdd = "INSERT INTO flightBy VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pd1 = con.prepareStatement(queryAdd);
			
			pd1.setInt(1, fNum);
			pd1.setString(2, twoLetID);
			pd1.setInt(3, ACID);
			pd1.setString(4, fPort);
			pd1.setString(5, tPort);
			pd1.setString(6, dDate);
			pd1.setString(7, aDate);
			pd1.setInt(8, type);
			pd1.setString(9, tTime);
			pd1.setString(10, lTime);
			pd1.setInt(11, stops);
			
			pd1.executeUpdate();
			out.print("Flight Successfully Added");%>
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
		     <%
		}else{ 
			out.print("Flight already exists: either edit or add a flight with an unused flight number \n");
		}
	%>
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
	}%>
	

</body>
</html>