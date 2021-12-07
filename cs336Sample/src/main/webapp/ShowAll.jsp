<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Result</title>
</head>
<body>
<h3>Show All Flight Tickets</h3>
<form method="get" action="FlightDetails.jsp">
	Buy a ticket:
	<input type="text" name="ticketNumToBuy">
	<input type="submit" value="Buy">
</form>
<br>
	<%

	try {
		//out.print("At search All");
		//out.print("<br>");
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get parameters from the HTML form at the SearchFlight.jsp
			
		String select = "SELECT * "
				+"FROM flightBy f, flightticketfor t " 
				+"WHERE f.flightNum = t.flightNum";


		PreparedStatement ps = con.prepareStatement(select);


		ResultSet rs = ps.executeQuery();
		
		//Make an HTML table to show the results in:
		out.print("<table>");
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("Ticket Number");
		out.print("</td>");
		out.print("<td>");
		//print out column header
		out.print("Trip Type");
		out.print("</td>");
		out.print("<td>");
		//print out column header
		out.print("departureDate");
		out.print("</td>");
		//print out column header
		out.print("<td>");
		out.print("takeoff");
		out.print("</td>");
		//print out column header
		out.print("<td>");
		out.print("arrivalDate");
		out.print("</td>");
		//print out column header
		out.print("<td>");
		out.print("landing");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("fromAirport");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("toAirport");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("numStop");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Airline");
		out.print("</td>");
		//make a price
		out.print("<td>");
		out.print("class");
		out.print("</td>");
		//make a price
		out.print("<td>");
		out.print("price");
		out.print("</td>");
		//make a price
		out.print("<td>");
		out.print("flightNum");
		out.print("</td>");
		//make a price

		
		out.print("</tr>");
		
		//Create set of all bought tickets
		Set<Integer> set = new HashSet<Integer>();
		String s = "select ticketNum from buy;";
		PreparedStatement ps2 = con.prepareStatement(s);
		ResultSet rs3 = ps2.executeQuery();
		while (rs3.next())
			set.add(rs3.getInt("ticketNum"));

		//parse out the results
		while (rs.next()) {

			//make a column
			int ticketnum = rs.getInt("ticketNum");
			if (set.contains(ticketnum))
				continue;
			
			int type = rs.getInt("t.type");
			int flightnum = rs.getInt("flightNum");
			int flightnum2 = rs.getInt("flightNum2");
			for(int i = 0;i<=type; i++){
				//make a row
				out.print("<tr>");
				out.print("<td>");
				//Print out current bar name:
				out.print(ticketnum);
				out.print("</td>");
				out.print("<td>");
				
				//Print out current bar name:
				switch(rs.getInt("t.type")){
					case 0: out.print("One-Way"); break;
					case 1: out.print("Round-Trip");break;
					default: out.print("");	break;
				}
				out.print("</td>");	
				out.print("<td>");
				if(i==0){	
					//Print out current bar name:
					out.print(rs.getDate("departureDate"));
					out.print("</td>");
					out.print("<td>");
					//Print out current bar name:
					out.print(rs.getString("takeoff"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(rs.getDate("arrivalDate"));
					out.print("</td>");
					out.print("<td>");
					//Print out current bar name:
					out.print(rs.getString("landing"));
					out.print("</td>");
					out.print("<td>");
					//make a column
					out.print(rs.getString("fromAirport"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(rs.getString("toAirport"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(rs.getString("numStop"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(rs.getString("twoLetID"));
					out.print("</td>");
							
				}else{
					
					 stmt = con.createStatement();
					 select = "SELECT * "
							+"FROM flightBy f " 
							+"WHERE f.flightNum = ? ";

					 ps = con.prepareStatement(select);
					 ps.setInt(1, flightnum2);

					ResultSet rs2 = ps.executeQuery();
					rs2.next();
					//Print out current bar name:
					out.print(rs2.getDate("departureDate"));
					out.print("</td>");
					out.print("<td>");
					//Print out current bar name:
					out.print(rs2.getString("takeoff"));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(rs2.getDate("arrivalDate"));
					out.print("</td>");
					out.print("<td>");
					//Print out current bar name:
					out.print(rs2.getString("landing"));
					out.print("</td>");
					out.print("<td>");
					//make a column
					out.print(rs2.getString("fromAirport"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(rs2.getString("toAirport"));
					out.print("</td>");
					out.print("<td>");
					//Print out current price
					out.print(rs2.getString("numStop"));
					out.print("</td>");
					out.print("<td>");	
					//Print out current price
					out.print(rs2.getString("twoLetID"));
					out.print("</td>");
					
				}
				out.print("<td>");	
				//Print out current price
				switch(rs.getInt("class")){
					case 0: out.print("Economy"); break;
					case 1: out.print("Business");break;
					case 2: out.print("First");break;
					default: out.print("");	break;
				}
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(rs.getFloat("totalFare"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				if(i == 0)
					out.print(flightnum);
				else
					out.print(flightnum2);
				out.print("</td>");
				out.print("<td>");

				out.print("</tr>");
			}
		}
		out.print("</table>");
		//close the connection.
		con.close();
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("One or more field is missing :()");
	}
%>
</body>
</html>