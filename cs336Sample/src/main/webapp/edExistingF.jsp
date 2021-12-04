<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Flights - Representative</title>
</head>
<body>
	
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String twoLetID = request.getParameter("twoLetID");
		Integer ACID = Integer.valueOf(request.getParameter("ACID"));
		Integer fNum = Integer.valueOf(request.getParameter("fNum"));
		String queryExists = "SELECT * from flightBy f WHERE f.twoLetID = ? and f.AircraftID = ? and f.flightNum = ?";
		PreparedStatement pd = con.prepareStatement(queryExists);
		pd.setString(1, twoLetID);
		pd.setInt(2, ACID);
		pd.setInt(3, fNum);
		ResultSet rs = pd.executeQuery();
		if ( rs.isBeforeFirst() ) {
			rs.next();
			Integer type = rs.getInt("type");
			out.print("Airline: " + twoLetID + "\n");%>
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
			<%out.print("Arrival Date: " + rs.getString("arrivalDate") + "\n");%>
			<br>
			<%out.print("Takeoff Time: " + rs.getString("takeoff") + "\n");%>
			<br>
			<%out.print("Landing Time: " + rs.getString("landing") + "\n");%>
			<br>
			<%out.print("Number of Stops: " + rs.getString("numStop") + "\n");%>
			<br>
			<%if(type == 0){
				out.print("Type: Domestic"  + "\n");
			}else{
				out.print("Type: International"  + "\n");
			}%>
			<br>
			<br>
	Information to change (if no change to some attribute(s) re-enter existing information)
		<form method="get" action="editedF.jsp">
			<table>
				<tr>
					<td>From Airport (3 letter ID)</td><td><input type="text" name="fPort" required></td>
				</tr>
				<tr>
					<td>To Airport (3 letter ID)</td><td><input type="text" name="tPort" required></td>
				</tr>
				<tr>
					<td>Departure Date (YYYY-MM-DD)</td><td><input type="text" name="dDate" required></td>
				</tr>
				<tr>
					<td>Arrival Date (YYYY-MM-DD)</td><td><input type="text" name="aDate" required></td>
				</tr>
				<tr>
					<td>Takeoff Time (HH:mm 24 hour time)</td><td><input type="text" name="tTime" required></td>
				</tr>
				<tr>
					<td>Landing Time (HH:mm 24 hour time)</td><td><input type="text" name="lTime" required></td>
				</tr>
				<tr>
					<td>Number of Stops</td><td><input type="text" name="stops" required></td>
				</tr>				
			</table>
			<label for="type">Type:</label>
			<select id="type" name="type">
				<option value="0">Domestic</option>
				<option value="1">International</option>
			</select>
			<br>
			<input type="hidden" name = "twoLetID" value='<%=twoLetID%>'>
			<input type="hidden" name = "ACID" value='<%=ACID%>'>
			<input type="hidden" name = "fNum" value='<%=fNum%>'>
			<input type="submit" value="Commit Edits">
		</form>
	<br>
		     <%
		}else{ 
			out.print("no such flight \n");
		}
	%>
	<br>
	<br>
		<form method="get" action="changeF.jsp">
			<input type="submit" value="Cancel">
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