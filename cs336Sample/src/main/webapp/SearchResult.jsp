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
		Integer isFlexible = Integer.valueOf(request.getParameter("isFlexible"));
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
		
		java.sql.Date returnDate = null;
		if(isOneWay != 0){
			date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("returnDate")); 
			returnDate = new java.sql.Date(date.getTime()); 
		}
		
		String beginselect = "SELECT *, STR_TO_DATE(CONCAT(departureDate, ' ', takeoff), '%Y-%m-%d %H:%i:%s') AS datetime_departureDate, "
			+"STR_TO_DATE(CONCAT(arrivalDate, ' ', landing), '%Y-%m-%d %H:%i:%s') AS datetime_arrivalDate ";
		
		String select = "FROM flightBy f, flightticketfor t "
		    +"WHERE t.type = ? ";
		
		if(isFlexible == 0){
			out.print("in flexible ");
			select += "AND DATE_SUB(f.departureDate, INTERVAL 3 DAY) <= ? "
					+ "AND DATE_ADD(f.departureDate, INTERVAL 3 DAY) >= ? ";
		}else{
			select += "AND f.departureDate = ? ";
		}
		
		
		select += "AND f.fromAirport = ? "
				+"AND f.toAirport = ? "
				+"AND f.flightnum = t.flightnum ";
		
		final int hasPriceFilter = 1;
		final int hasNumStopFilter = 2;
		final int hasAirline = 3;
		final int hasTakeOff = 4;
		final int hasLanding = 5;
		
		HashMap<Integer, String> optional = new HashMap<Integer, String>();

		out.print("before price \n");
		Integer priceFilter = Integer.valueOf(request.getParameter("priceFilter"));
		String sprice = request.getParameter("price");
		if(!sprice.isEmpty()){
			Float price = Float.valueOf(sprice);
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
		if(!snumStop.isEmpty()){
			Integer numStop = Integer.valueOf(snumStop);
			select += "AND f.numStop ";
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

		String takeoffhour = request.getParameter("takeoffhour");
		String takeoffmin = request.getParameter("takeoffmin");
		if(!takeoffhour.isEmpty() && !takeoffmin.isEmpty()){
			select += "AND f.takeoff = ? ";
			optional.put(hasTakeOff, takeoffhour+":"+takeoffmin);
		}
		String landinghour = request.getParameter("landinghour");
		String landingmin = request.getParameter("landingmin");
		if(!landinghour.isEmpty() && !landingmin.isEmpty()){
			select += "AND f.landing = ? ";	
			optional.put(hasLanding, landinghour+":"+landingmin);
		}
		
		
		
		
		
		if(isOneWay == 1){
			String select2 = select;
			select2 = "SELECT f.flightnum " + select2;
			select2 = select2.replaceAll("AND f.flightnum = t.flightnum","AND f.flightnum = t.flightnum2" );
			select+=  "AND t.flightnum2 IN ("+select2+") ";
			
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
		
		select = beginselect + select;
		
		out.print(select);
		
		
		int index = 1;
		PreparedStatement ps = con.prepareStatement(select);
		for(int i = 0; i <= isOneWay; i++){
			ps.setInt(index++, isOneWay);
			if(i == 1){
				departureDate = returnDate;
				String temp = fromAirport;
				fromAirport = toAirport;
				toAirport = temp;
			}
			if(isFlexible == 0){
				ps.setDate(index++, departureDate);
				ps.setDate(index++, departureDate);
			}else{
				ps.setDate(index++, departureDate);
			}
			ps.setString(index++, fromAirport);
			ps.setString(index++, toAirport);
	
			
			for(int key: optional.keySet()){
				switch(key){
				  case hasPriceFilter:
					  ps.setFloat(index, Float.valueOf(optional.get(key)));
					  break;
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

				//parse out the results
				while (rs.next()) {

					//make a column
					int ticketnum = rs.getInt("ticketNum");
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