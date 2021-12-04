<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Flight - Representative</title>
</head>
<body>
	
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String twoLetID = request.getParameter("twoLetID");
		Integer ACID = Integer.valueOf(request.getParameter("ACID"));
		Integer fNum = Integer.valueOf(request.getParameter("fNum"));
		
		String queryExists = "SELECT * FROM flightBy f WHERE f.twoLetID = ? and f.AircraftID = ? and f.flightNum = ?";
		PreparedStatement pd = con.prepareStatement(queryExists);
		pd.setString(1, twoLetID);
		pd.setInt(2, ACID);
		pd.setInt(3, fNum);
		ResultSet rs = pd.executeQuery();
		if ( rs.isBeforeFirst() ) {
			String queryDelete = "DELETE FROM flightBy f WHERE f.twoLetID = ? and f.AircraftID = ? and f.flightNum = ?";
			PreparedStatement pd1 = con.prepareStatement(queryDelete);
			pd1.setString(1, twoLetID);
			pd1.setInt(2, ACID);
			pd1.setInt(3, fNum);
			pd1.executeUpdate();

			
			
			rs.next();
			Integer type = Integer.valueOf(rs.getInt("type"));
			out.print("Flight Successfully Deleted");%>
			<br>
			<%out.print("Airline: " + twoLetID + "\n");%>
				<br>
				<%out.print("Aircraft Number: " + ACID + "\n");%>
				<br>
				<%out.print("Flight Number: " + fNum + "\n");%>
				<br>
				<%out.print("From: " + rs.getString("fromAirport") + "\n");%>
				<br>
				<%out.print("To: " + rs.getString("toAirport") + "\n");%>
				<br>
				<%out.print("Departure Date: " + rs.getString("departureDate") + "\n");%>
				<br>
				<%out.print("Arrival Date: " + rs.getString("arrivaldate") + "\n");%>
				<br>
				<%out.print("Takeoff Time: " + rs.getString("takeoff") + "\n");%>
				<br>
				<%out.print("Landing Time: " + rs.getString("landing") + "\n");%>
				<br>
				<%out.print("Number of Stops: " + rs.getInt("numStop") + "\n");%>
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
			out.print("no such flight \n");
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
		out.print("One or more field is missing :()");
	}%>
	

</body>
</html>