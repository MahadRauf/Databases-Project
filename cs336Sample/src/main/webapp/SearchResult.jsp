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
<%!
	public int toMins (String s){
    	String[] hourMin = s.split(":");
    	int hour = Integer.parseInt(hourMin[0]);
    	int mins = Integer.parseInt(hourMin[1]);
    	int hoursInMins = hour * 60;
    	return hoursInMins + mins;
	}
%>
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
		
		Integer sortBy = Integer.valueOf(request.getParameter("sort"));
		
		java.sql.Date arrivalDate = null;
		if(isOneWay != 0){
			date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("arrivalDate")); 
			arrivalDate = new java.sql.Date(date.getTime()); 
		}
		
		String select = "SELECT *, STR_TO_DATE(CONCAT(departureDate, ' ', takeoff), '%Y-%m-%d %H:%i:%s') AS datetime_departureDate, "
			+"STR_TO_DATE(CONCAT(arrivalDate, ' ', landing), '%Y-%m-%d %H:%i:%s') AS datetime_arrivalDate "
			+"FROM flightBy f "
			+"WHERE f.departureDate = ? "
			+"AND f.fromAirport = ? "
			+"AND f.toAirport = ? ";
			
		String select2 = "";

		if(isOneWay == 1){
			 select += "UNION SELECT *, STR_TO_DATE(CONCAT(departureDate, ' ', takeoff), '%Y-%m-%d %H:%i:%s') AS datetime_departureDate, "
				+"STR_TO_DATE(CONCAT(arrivalDate, ' ', landing), '%Y-%m-%d %H:%i:%s') AS datetime_arrivalDate "
				+"FROM flightBy f, flightticketfor t "
				+"WHERE f.arrivalDate = ? "
				+"AND f.fromAirport = ? "
				+"AND f.toAirport = ? "
				+"AND f.flightNum = t.flightNum ";
		}
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
			optional.put(hasTakeOff, takeoff);
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
				select += "ORDER BY datetime_departureDate ";
				break;
			case 3:
				select += "ORDER BY datetime_arrivalDate ";
				break;
			case 4:
				select += "ORDER BY DATEDIFF(datetime_arrivalDate, datetime_departureDate) ";
				break;
			default:
				break;
		}
		

		
		out.print("before prepare");
		
		PreparedStatement ps = con.prepareStatement(select);
		ps.setDate(1, departureDate);
		ps.setString(2, fromAirport);
		ps.setString(3, toAirport);
		
		int index = 4;
		if(isOneWay == 1){
			ps.setDate(index++, arrivalDate);
			ps.setString(index++, fromAirport);
			ps.setString(index++, toAirport);
		}
		
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
		
		for(int i = 0; i <= isOneWay; i++){
			//make a column
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
			out.print("Airline");
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
			out.print("<td>");
			out.print("datetime_departureDate");
			out.print("</td>");
			
			//make a price
			out.print("<td>");
			out.print("datetime_arrivalDate");
			out.print("</td>");
		}
		out.print("</tr>");

		//parse out the results
		while (rs.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
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
			out.print(rs.getString("twoLetID"));
			out.print("</td>");
			out.print("<td>");
			//Print out current price
			out.print("totalFare");
			out.print("</td>");
			out.print("<td>");
			//Print out current price
			out.print(rs.getString("flightNum"));
			out.print("</td>");
			out.print("<td>");
			//Print out current price
			out.print(rs.getString("datetime_departureDate"));
			out.print("</td>");
			out.print("<td>");
			//Print out current price
			out.print(rs.getString("datetime_arrivalDate"));
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