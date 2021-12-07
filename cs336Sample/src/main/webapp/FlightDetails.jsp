<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flight Details</title>
</head>
<body>
<h3>Flight Reservations</h3>
<form method="get" action="FlightDetails.jsp">
	Cancel a ticket:
	<input type="text" name="ticketNumToCancel">
	<input type="submit" value="Cancel">
</form>
<br>
	<%

	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String u = (String)session.getAttribute("user");


		//Handling request to CANCEL ticket
		String ticketNumToCancel = request.getParameter("ticketNumToCancel");		
		if (ticketNumToCancel != null && !ticketNumToCancel.trim().isEmpty()) //Post this data before displaying
		{
			//Delete from buy
			String delete = "delete from buy where username = ? AND ticketNum = ?";
			PreparedStatement ps2 = con.prepareStatement(delete);
			ps2.setString(1, u);
			ps2.setInt(2, Integer.parseInt(ticketNumToCancel));
			request.setAttribute("ticketNumToCancel", null);
			ps2.executeUpdate();
			
			//Delete from flightticketfor
			String delete2 = "delete from flightticketfor where ticketNum = ?;";
			PreparedStatement ps3 = con.prepareStatement(delete2);
			ps3.setInt(1, Integer.parseInt(ticketNumToCancel));
			request.setAttribute("ticketNumToCancel", null);
			ps3.executeUpdate();
		}
		
		//Handling request to BUY ticket
		String ticketNumToBuy = request.getParameter("ticketNumToBuy");		
		if (ticketNumToBuy != null && !ticketNumToBuy.trim().isEmpty()) //Post this data before displaying
		{
		//FlightNum	
		
			//Get flightNum from ticketNum
			String fn = "select flightNum from flightticketfor where ticketNum = ?;";
			PreparedStatement ps3 = con.prepareStatement(fn);
			ps3.setInt(1, Integer.parseInt(ticketNumToBuy));
			ResultSet rs3 = ps3.executeQuery();
			int flightNumber = 0;
			if (rs3.next())
				flightNumber = rs3.getInt("flightNum");
			//out.print(flightNumber);
			
			//Finding the number of taken seats for a flightnum
			String ts = "select count(flightNum) from flightticketfor t join buy b on b.ticketNum = t.ticketNum where flightNum = ?;";
			PreparedStatement ps4 = con.prepareStatement(ts);
			ps4.setInt(1, flightNumber);
			ResultSet rs4 = ps4.executeQuery();
			int takenSeats = 0;
			if (rs4.next())
				takenSeats = rs4.getInt("count(flightNum)");
			String ts2 = "select count(flightNum2) from flightticketfor t join buy b on b.ticketNum = t.ticketNum where flightNum2 = ?;";
			PreparedStatement ps42 = con.prepareStatement(ts2);
			ps42.setInt(1, flightNumber);
			ResultSet rs42 = ps42.executeQuery();
			if (rs42.next())
				takenSeats += rs42.getInt("count(flightNum2)");
			//out.print(takenSeats);
			
			//Finding out how many seats are on the aircraft
			String ns = "select seats from aircraft a where a.AircraftID = (select AircraftID from flightby f where f.flightNum= ?) " +
					"AND a.twoLetID = (select twoLetID from flightby f where f.flightNum= ?);";
			PreparedStatement ps5 = con.prepareStatement(ns);
			ps5.setInt(1, flightNumber);
			ps5.setInt(2, flightNumber);
			ResultSet rs5 = ps5.executeQuery();
			int numSeats = 0;
			if (rs5.next())
				numSeats = rs5.getInt("seats");
			//out.print(numSeats);
		
		//FlightNum2

			//Get flightNum2 from ticketNum
			String fn2 = "select flightNum2 from flightticketfor where ticketNum = ?;";
			PreparedStatement ps32 = con.prepareStatement(fn2);
			ps32.setInt(1, Integer.parseInt(ticketNumToBuy));
			ResultSet rs32 = ps32.executeQuery();
			int flightNumber2 = 0;
			if (rs32.next())
				flightNumber2 = rs32.getInt("flightNum2");
			//out.print(flightNumber2);
			
			int takenSeats2 = 0;
			int numSeats2 = 0;
			if (flightNumber2 != 0)
			{
				//Finding the number of taken seats for a flightnum
				ts = "select count(flightNum) from flightticketfor t join buy b on b.ticketNum = t.ticketNum where flightNum = ?;";
				PreparedStatement pst4 = con.prepareStatement(ts);
				pst4.setInt(1, flightNumber2);
				ResultSet rst4 = pst4.executeQuery();
				if (rst4.next())
					takenSeats2 = rst4.getInt("count(flightNum)");
				ts2 = "select count(flightNum2) from flightticketfor t join buy b on b.ticketNum = t.ticketNum where flightNum2 = ?;";
				PreparedStatement pst42 = con.prepareStatement(ts2);
				pst42.setInt(1, flightNumber2);
				ResultSet rst42 = pst42.executeQuery();
				if (rst42.next())
					takenSeats2 += rst42.getInt("count(flightNum2)");
				//out.print(takenSeats2);
				
				//Finding out how many seats are on the aircraft
				ns = "select seats from aircraft a where a.AircraftID = (select AircraftID from flightby f where f.flightNum= ?) " +
						"AND a.twoLetID = (select twoLetID from flightby f where f.flightNum= ?);";
				PreparedStatement pst5 = con.prepareStatement(ns);
				pst5.setInt(1, flightNumber2);
				pst5.setInt(2, flightNumber2);
				ResultSet rst5 = pst5.executeQuery();
				if (rst5.next())
					numSeats2 = rst5.getInt("seats");
				//out.print(numSeats2);
			}
			
			if (takenSeats < numSeats && (flightNumber2 == 0 || takenSeats2 < numSeats2))
			{
				//Buy Ticket
				String insert = "INSERT INTO `buy` VALUES (?, ?, curdate(), curtime())";
				PreparedStatement ps1 = con.prepareStatement(insert);
				ps1.setString(1, u);
				ps1.setInt(2, Integer.parseInt(ticketNumToBuy));
				request.setAttribute("ticketNumToBuy", null);
				ps1.executeUpdate();
				
				//Remove from waiting list
				//if (flightNumber2 == 0)
				//{
				//	String delete = "delete from waits where username = ? AND ticketNum in (select t.ticketNum from flightticketfor t where t.flightNum = ?);";
				//	PreparedStatement ps2 = con.prepareStatement(delete);
				//	ps2.setString(1, u);
				//	ps2.setInt(2, flightNumber);
				//	request.setAttribute("ticketNumToBuy", null);
				//	ps2.executeUpdate();
				//}
				//else if (flightNumber2 > 0)
				//{
					String delete = "delete from waits where username = ? AND ticketNum in (select t.ticketNum from flightticketfor t where t.flightNum = ? AND t.flightNum2 = ?);";
					PreparedStatement ps2 = con.prepareStatement(delete);
					ps2.setString(1, u);
					ps2.setInt(2, flightNumber);
					ps2.setInt(3, flightNumber2);
					request.setAttribute("ticketNumToBuy", null);
					ps2.executeUpdate();
				//}
				
				//Enter new ticket number to plus 100
				String selectTicket = "select * from flightticketfor where ticketNum = ?";
				PreparedStatement ps8 = con.prepareStatement(selectTicket);
				ps8.setInt(1, Integer.parseInt(ticketNumToBuy));
				ResultSet rs8 = ps8.executeQuery();
				
				String insert2 = "insert into flightticketfor values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
				PreparedStatement ps7 = con.prepareStatement(insert2);
				if (rs8.next())
				{
					ps7.setInt(1, Integer.parseInt(ticketNumToBuy)+100);
					ps7.setInt(2, rs8.getInt("seatNum")+3);
					ps7.setFloat(3, rs8.getFloat("totalFare"));
					ps7.setFloat(4, rs8.getFloat("bookingFee"));
					ps7.setInt(5, rs8.getInt("class"));
					ps7.setInt(6, rs8.getInt("type"));
					ps7.setString(7, rs8.getString("from"));
					ps7.setString(8, rs8.getString("to"));
					ps7.setString(9, rs8.getString("twoLetID"));
					ps7.setInt(10, rs8.getInt("AircraftID"));
					ps7.setInt(11, rs8.getInt("flightNum"));
					ps7.setInt(12, rs8.getInt("flightNum2"));
				}
				request.setAttribute("ticketNumToBuy", null);
				ps7.executeUpdate();
			}
			else //Enter on Waiting List
			{
				String inswait = "INSERT INTO `waits` VALUES (?, ?);";
				PreparedStatement ps6 = con.prepareStatement(inswait);
				ps6.setString(1, u);
				ps6.setInt(2, Integer.parseInt(ticketNumToBuy));
				try {
					ps6.executeUpdate();
					out.print("You've been entered on the waiting list for flight number(s)");
					if (takenSeats >= numSeats)
						out.print(" " + flightNumber);
					if (flightNumber2 != 0 && takenSeats2 >= numSeats2)
						out.print(" " + flightNumber2);
					out.print("<br><br>");
				}
				catch (Exception ex) {
					out.print("You are already in the waiting list for this flight.");
					out.print("<br><br>");
					//out.print(ex);
				}
				request.setAttribute("ticketNumToBuy", null);
			}
		}
		
		//Checking Wait List
		String wl = "select ticketNum from waits where username = ?;";
		PreparedStatement ps7 = con.prepareStatement(wl);
		ps7.setString(1, u);
		ResultSet rs7 = ps7.executeQuery();
		int wlticket = 0;
		List<Integer> list = new ArrayList<Integer>();
		while (rs7.next())
		{
			wlticket = rs7.getInt("ticketNum");
			//Get flightNum from ticketNum
			String fn = "select flightNum from flightticketfor where ticketNum = ?;";
			PreparedStatement ps3 = con.prepareStatement(fn);
			ps3.setInt(1, wlticket);
			ResultSet rs3 = ps3.executeQuery();
			int flightNumber = 0;
			if (rs3.next())
				flightNumber = rs3.getInt("flightNum");
			//out.print(flightNumber);
			
			//Finding the number of taken seats for a flightnum
			String ts = "select count(flightNum) from flightticketfor t join buy b on b.ticketNum = t.ticketNum where flightNum = ?;";
			PreparedStatement ps4 = con.prepareStatement(ts);
			ps4.setInt(1, flightNumber);
			ResultSet rs4 = ps4.executeQuery();
			int takenSeats = 0;
			if (rs4.next())
				takenSeats = rs4.getInt("count(flightNum)");
			String ts2 = "select count(flightNum2) from flightticketfor t join buy b on b.ticketNum = t.ticketNum where flightNum2 = ?;";
			PreparedStatement ps42 = con.prepareStatement(ts2);
			ps42.setInt(1, flightNumber);
			ResultSet rs42 = ps42.executeQuery();
			if (rs42.next())
				takenSeats += rs42.getInt("count(flightNum2)");
			//out.print(takenSeats);
			
			//Finding out how many seats are on the aircraft
			String ns = "select seats from aircraft a where a.AircraftID = (select AircraftID from flightby f where f.flightNum= ?) " +
					"AND a.twoLetID = (select twoLetID from flightby f where f.flightNum= ?);";
			PreparedStatement ps5 = con.prepareStatement(ns);
			ps5.setInt(1, flightNumber);
			ps5.setInt(2, flightNumber);
			ResultSet rs5 = ps5.executeQuery();
			int numSeats = 0;
			if (rs5.next())
				numSeats = rs5.getInt("seats");
			//out.print(numSeats);

			//Get flightNum2 from ticketNum
			String fn2 = "select flightNum2 from flightticketfor where ticketNum = ?;";
			PreparedStatement ps32 = con.prepareStatement(fn2);
			ps32.setInt(1, wlticket);
			ResultSet rs32 = ps32.executeQuery();
			int flightNumber2 = 0;
			if (rs32.next())
				flightNumber2 = rs32.getInt("flightNum2");
			//out.print(flightNumber2);		

			if (flightNumber2 != 0)
			{
				//Finding the number of taken seats for a flightnum
				ts = "select count(flightNum) from flightticketfor t join buy b on b.ticketNum = t.ticketNum where flightNum = ?;";
				PreparedStatement pst4 = con.prepareStatement(ts);
				pst4.setInt(1, flightNumber2);
				ResultSet rst4 = pst4.executeQuery();
				int takenSeats2 = 0;
				if (rst4.next())
					takenSeats2 = rst4.getInt("count(flightNum)");
				ts2 = "select count(flightNum2) from flightticketfor t join buy b on b.ticketNum = t.ticketNum where flightNum2 = ?;";
				PreparedStatement pst42 = con.prepareStatement(ts2);
				pst42.setInt(1, flightNumber2);
				ResultSet rst42 = pst42.executeQuery();
				if (rst42.next())
					takenSeats2 += rst42.getInt("count(flightNum2)");
				//out.print(takenSeats2);
				
				//Finding out how many seats are on the aircraft
				String ns2 = "select seats from aircraft a where a.AircraftID = (select AircraftID from flightby f where f.flightNum= ?) " +
						"AND a.twoLetID = (select twoLetID from flightby f where f.flightNum= ?);";
				PreparedStatement ps52 = con.prepareStatement(ns2);
				ps52.setInt(1, flightNumber2);
				ps52.setInt(2, flightNumber2);
				ResultSet rs52 = ps52.executeQuery();
				int numSeats2 = 0;
				if (rs52.next())
					numSeats2 = rs52.getInt("seats");
				//out.print(numSeats);
				
				if (takenSeats < numSeats && takenSeats2 < numSeats2)
				{
					if (!list.contains(flightNumber))
						list.add(flightNumber);
					if (!list.contains(flightNumber2))
						list.add(flightNumber2);
				}
			}
			else
			{
				if (takenSeats < numSeats)
				{
					if (!list.contains(flightNumber))
						list.add(flightNumber);
				}
			}
			
		}
		if (!list.isEmpty())
			out.print("There is an open seat for flight(s) ");
		for (int i = 0; i < list.size(); i++)
		{
			out.print(list.get(i) + " ");
		}
		if (!list.isEmpty())
			out.print("<br><br>");
			
		
		//String select = "select t.*, f.* from flightticketfor t inner join buy b where t.ticketNum = b.ticketNum AND b.username = 'user1'";
		String select = "select t.*, f.*, b.purchaseDate, b.purchaseTime from flightBy f join flightticketfor t on f.flightNum = t.flightNum join buy b on "
				+ "b.ticketNum = t.ticketNum where b.username = ? AND CURDATE() <= arrivalDate order by departureDate, takeoff";
		
		PreparedStatement ps = con.prepareStatement(select);
		
		ps.setString(1, u);		
		
		ResultSet rs = ps.executeQuery();
		out.print("<table>");
		out.print("<tr>");
		out.print("Upcoming Flights");
		out.print("</tr>");
		out.print("</table>");
		
		//Make an HTML table to show the results in:
		out.print("<table>");
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("Ticket No.");
		out.print("</td>");
		out.print("<td>");
		//print out column header
		out.print("Seat No.");
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
		out.print("<td>");
		out.print("purchaseDate");
		out.print("</td>");
		
		out.print("<td>");
		out.print("purchaseTime");
		out.print("</td>");
		
		out.print("</tr>");
		

		//parse out the results
		while (rs.next()) {
			
			//Write query to see where 
			
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
				
				out.print(rs.getString("seatNum"));
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
				out.print(rs.getDate("purchaseDate"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(rs.getTime("purchaseTime"));
				out.print("</td>");

				out.print("</tr>");
			}
		}
		
		out.print("</table>");
		
		out.print("<br>");
		
		//String select = "select t.*, f.* from flightticketfor t inner join buy b where t.ticketNum = b.ticketNum AND b.username = 'user1'";
		select = "select t.*, f.*, b.purchaseDate, b.purchaseTime from flightBy f join flightticketfor t on f.flightNum = t.flightNum join buy b on "
				+ "b.ticketNum = t.ticketNum where b.username = ? AND CURDATE() > arrivalDate order by departureDate, takeoff";
		
		ps = con.prepareStatement(select);
		ps.setString(1, u);		
		rs = ps.executeQuery();
		
		out.print("<table>");
		out.print("<tr>");
		out.print("Previous Flights");
		out.print("</tr>");
		out.print("</table>");
		//Make an HTML table to show the results in:
				out.print("<table>");
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("Ticket No.");
				out.print("</td>");
				out.print("<td>");
				//print out column header
				out.print("Seat No.");
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
				out.print("<td>");
				out.print("purchaseDate");
				out.print("</td>");
				
				out.print("<td>");
				out.print("purchaseTime");
				out.print("</td>");
				
				out.print("</tr>");
				

				//parse out the results
				while (rs.next()) {
					
					//Write query to see where 
					
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
						
						out.print(rs.getString("seatNum"));
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
						out.print(rs.getDate("purchaseDate"));
						out.print("</td>");
						
						out.print("<td>");
						out.print(rs.getTime("purchaseTime"));
						out.print("</td>");

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