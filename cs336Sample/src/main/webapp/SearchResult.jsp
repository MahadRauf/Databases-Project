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
		
		date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("arrivalDate")); 
		java.sql.Date arrivalDate = new java.sql.Date(date.getTime()); 
		
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
		
		Integer sortBy = Integer.valueOf(request.getParameter("sort"));
		
		String select = "SELECT f.departureDate, f.fromAirport, f.toAirport, t.totalFare "
				+"FROM flightBy f, flightticketfor t "
				+"WHERE f.departureDate = ? "
				+"AND f.fromAirport = ? "
				+"AND f.toAirport = ? "
				+"AND f.isOneWay = ? "
				+"AND f.isDomestic = ? "
				+"AND f.flightNum = t.flightNum ";
		
		final int hasPriceFilter = 1;
		final int hasNumStopFilter = 2;
		final int hasAirline = 3;
		final int hasTakeOff = 4;
		final int hasLanding = 5;
		
		HashMap<Integer, String> optional = new HashMap<Integer, String>();

		
		Integer priceFilter = Integer.valueOf(request.getParameter("priceFilter"));
		String sprice = request.getParameter("price");
		if(!sprice.isEmpty()){
			Integer price = Integer.valueOf(sprice);
			select += "AND t.totalFare ";
			switch(priceFilter){
			case 0:
				select += "=";
				break;
			case 1:
				select += "<";
				break;
			case 2:
				select += ">";
				break;
			default:
				throw new Exception();
				break;
			}		
			select += " ? ";
			optional.put(hasPriceFilter,sprice);
		}

		Integer numStopFilter = Integer.valueOf(request.getParameter("numStopFilter"));
		String snumStop = request.getParameter("numStop");
		if(!sprice.isEmpty()){
			Integer numStop = Integer.valueOf(snumStop);
			select += "AND t.totalFare ";
			switch(numStopFilter){
			case 0:
				select += "=";
				break;
			case 1:
				select += "<";
				break;
			case 2:
				select += ">";
				break;
			default:
				throw new Exception();
				break;
			}		
			select += " ? ";
			optional.put(hasNumStopFilter,snumStop);
		}
		
		String airline = request.getParameter("airline");
		if(!airline.isEmpty()){
			select += "AND f.twoLetID = ? ";	
			optional.put(hasAirline, airline);
		}

		String takeoff = request.getParameter("takeoff");
		if(!takeoff.isEmpty()){
			select += "AND f.takeoff = ? ";
			optional.put(hasTakeOff, airline);
		}
		String landing = request.getParameter("landing");
		if(!landing.isEmpty()){
			select += "AND f.landing = ? ";	
			optional.put(hasLanding, landing);
		}
		
		
		//Run the query against the database.
		switch(sortBy){
			case 0:
				break;
			case 1:
				select += "ORDER BY t.totalFare ";
				break;
			case 2:
				select += "ORDER BY f.takeoff ";
				break;
			case 3:
				select += "ORDER BY f.landing ";
				break;
			case 4:
				select += "ORDER BY  f.landing - f.takeoff ";
				break;
			default:
				break;
		}
		

		
		out.print("before prepare");
		
		PreparedStatement ps = con.prepareStatement(select);
		ps.setDate(1, departureDate);
		ps.setString(2, fromAirport);
		ps.setString(3, toAirport);
		ps.setInt(4, isOneWay);
		ps.setInt(5, isDomestic);
		
		int index = 6;
		for(int key: optional.keySet()){
			switch(key){
			  case hasPriceFilter:
			  case hasNumStopFilter:
				  ps.setInt(index, Integer.valueOf(optional.get(key)));
				  break;
			  case hasAirline:
			  case hasTakeOff:
			  case hasLanding:
				  ps.setString(index, optional.get(key));
				  break;
			  default:
				  break;
			}
			index++;
		}
		
		out.print("before result");
		
		ResultSet rs = ps.executeQuery();
		
		//Make an HTML table to show the results in:
		out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("departureDate");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("fromAirport");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("toAirport");
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