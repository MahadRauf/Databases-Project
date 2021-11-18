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
	<%
	try {
		out.print("At search Result\n");
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get parameters from the HTML form at the SearchFlight.jsp
		
		Integer isOneWay = Integer.valueOf(request.getParameter("isOneWay"));
		Integer isDomestic = Integer.valueOf(request.getParameter("isDomestic"));
		
		out.print("After integer\n");
		
		java.util.Date date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("departureDate")); 
		java.sql.Date departureDate = new java.sql.Date(date.getTime()); 
		
		out.print("After date\n");
		
		String fromAirport = request.getParameter("fromAirport");
		if(fromAirport.isEmpty()){
			throw new Exception();
		}
		String toAirport = request.getParameter("toAirport");
		out.print("After string\n");
		if(toAirport.isEmpty()){
			throw new Exception();
		}
		
		String select = "SELECT departureDate, fromAirport, toAirport "
				+"FROM flightBy "
				+"WHERE departureDate = ? "
				+"AND fromAirport = ? "
				+"AND toAirport = ? "
				+"AND isOneWay = ? "
				+"AND isDomestic = ?";
		//Run the query against the database.
		
		out.print("before prepare");
		
		PreparedStatement ps = con.prepareStatement(select);
		ps.setDate(1, departureDate);
		ps.setString(2, fromAirport);
		ps.setString(3, toAirport);
		ps.setInt(4, isOneWay);
		ps.setInt(5, isDomestic);
		
		out.print("before result");
		
		ResultSet rs = ps.executeQuery();
		
		//Make an HTML table to show the results in:
		out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("bar");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("beer");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("price");
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (rs.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//Print out current bar name:
			out.print(rs.getString("departureDate"));
			out.print("</td>");
			out.print("<td>");
			//Print out current beer name:
			out.print(rs.getString("fromAirport"));
			out.print("</td>");
			out.print("<td>");
			//Print out current price
			out.print(rs.getString("toAirport"));
			out.print("</td>");
			out.print("</tr>");

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