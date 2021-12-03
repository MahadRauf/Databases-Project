<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Aircrafts - Representative</title>
</head>
<body>
	
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String twoLetID = request.getParameter("twoLetID");
		Integer ACID = Integer.valueOf(request.getParameter("ACID"));
		String queryExists = "SELECT * from aircraft a WHERE a.twoLetID = ? and a.AircraftID = ?";
		PreparedStatement pd = con.prepareStatement(queryExists);
		pd.setString(1, twoLetID);
		pd.setInt(2, ACID);
		ResultSet rs = pd.executeQuery();
		if ( rs.isBeforeFirst() ) {
			rs.next();
			out.print("Airline: " + twoLetID + "\n");%>
			<br>
			<%
			out.print("Aircraft Number: " + ACID + "\n");%>
			<br>
			<%
			out.print("Seats: " + rs.getString("seats") + "\n");%>
			<br>
			<%
			out.print("Operating Days: " + rs.getString("operatingDays") + "\n");%>
			<br>
			<br>
	Information to change (if no change to some attribute(s) re-enter existing information)
		<form method="get" action="editedAC.jsp">
			<table>
				<tr>
					<td>Seats</td><td><input type="text" name="seats" required></td>
				</tr>
				<tr>    
					<td>Operating Days(ex:SMTWTFS, underscore on non-operating days: SMT_TFS)</td><td><input type="text" name="opDays" required></td>
				</tr>
						
			</table>
			<input type="hidden" name = "twoLetID" value='<%=twoLetID%>'>
			<input type="hidden" name = "ACID" value='<%=ACID%>'>
			<input type="submit" value="Commit Edits">
		</form>
	<br>
		     <%
		}else{ 
			out.print("no such aircraft \n");
		}
	%>
	<br>
	<br>
		<form method="get" action="changeAC.jsp">
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
		out.print("One or more field is missing :()");
	}%>
	

</body>
</html>