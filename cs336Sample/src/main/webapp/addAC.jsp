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
		Integer seats = Integer.valueOf(request.getParameter("seats"));
		String opDays = request.getParameter("opDays");
		
		String queryExists = "SELECT * from aircraft a WHERE a.twoLetID = ? and a.AircraftID = ?";
		PreparedStatement pd = con.prepareStatement(queryExists);
		pd.setString(1, twoLetID);
		pd.setInt(2, ACID);
		ResultSet rs = pd.executeQuery();
		
		
		String queryALExists = "SELECT * from airlineCompany a WHERE a.twoLetID = ?";
		PreparedStatement pd2 = con.prepareStatement(queryALExists);
		pd2.setString(1, twoLetID);
		ResultSet rs2 = pd2.executeQuery();

		if ( !rs.isBeforeFirst() ) {
			
			if( !rs2.isBeforeFirst() ){
				
				String queryAddAL = "INSERT INTO airlineCompany VALUES (?)";
				PreparedStatement pd3 = con.prepareStatement(queryAddAL);
				
				pd3.setString(1, twoLetID);
				pd3.executeUpdate();
				out.print("Airline " + twoLetID + " was not in the database and has been added");%>
				<br>
				<%
				
			}
			
			String queryAdd = "INSERT INTO aircraft VALUES (?, ?, ?, ?)";
			PreparedStatement pd1 = con.prepareStatement(queryAdd);
			
			pd1.setString(1, twoLetID);
			pd1.setInt(2, ACID);
			pd1.setInt(3, seats);
			pd1.setString(4, opDays);
			pd1.executeUpdate();
			%>
			<br>
			<%
			out.print("Aircraft Successfully Added");%>
			<br>
			<%out.print("Airline: " + twoLetID + "\n");%>
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
		     <%
		}else{ 
			out.print("Aircraft already exists \n");
		}
	%>
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
	}%>
	

</body>
</html>