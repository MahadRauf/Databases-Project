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
		String AP = request.getParameter("airport");
		String queryAPExists = "SELECT * from airport A WHERE A.threeLetID = ?";
		PreparedStatement pd = con.prepareStatement(queryAPExists);
		pd.setString(1, AP);
		ResultSet rs = pd.executeQuery();
		if ( rs.isBeforeFirst() ) {
			String queryArriving = "SELECT f.twoLetID AS airline, f.flightNum AS flightNum FROM flightBy f WHERE f.toAirport = ? ORDER BY airline, flightNum DESC";
			PreparedStatement pd1 = con.prepareStatement(queryArriving);
			pd1.setString(1, AP);
			ResultSet rs1 = pd1.executeQuery();
			
			String queryDeparting = "SELECT f.twoLetID AS airline, f.flightNum AS flightNum FROM flightBy f WHERE f.fromAirport = ? ORDER BY airline, flightNum DESC";
			PreparedStatement pd2 = con.prepareStatement(queryDeparting);
			pd2.setString(1, AP);
			ResultSet rs2 = pd2.executeQuery();
			if( rs1.isBeforeFirst() || rs2.isBeforeFirst() ){
				%>
				<br>
				<% out.print("information for " + AP); %>
				<br>
				<table>
					<tr>    
						<td>Arriving</td>
					</tr>
						<%
						//parse out the results
					if(rs1.isBeforeFirst()){
						while (rs1.next()) {
							String s1 = rs1.getString("airline");
							String s2 = rs1.getString("flightNum");%>
							
							<tr>    
								<td><% out.print(s1 + s2); %></td>
							</tr>
							

						<% }
						}else{%>
						<tr>    
							<td><% out.print("N/A"); %></td>
						</tr>
						<%}%>
				
				</table>
				
				<br>
				<table>
					<tr>    
						<td>Departing</td>
					</tr>
						<%
						//parse out the results
					if(rs2.isBeforeFirst()){
						while (rs2.next()) {
							String s1 = rs2.getString("airline");
							String s2 = rs2.getString("flightNum");%>
							
							<tr>    
								<td><% out.print(s1 + s2); %></td>
							</tr>
							

						<% }
						}else{%>
						<tr>    
							<td><% out.print("N/A"); %></td>
						</tr>
						<%}%>
				
				</table>
			<%	
			}else{
				out.print("no flights departing from or arriving to selected airport \n");
			}
			
			
		     
		}else{ 
			out.print("airport not in database \n");
		}
	%>
	<br>
	<br>
		<form method="get" action="APFlights.jsp">
			<input type="submit" value="View Arrivng/Departing of Other Airports">
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