<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Accounts</title>
</head>
<body>
	<% try {
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String user = request.getParameter("user");		
		
		out.print("\n");
		String query = "SELECT b.username AS username, f.flightNum AS flightNum, f.from AS fromy, f.to AS tom, f.class AS class, f.seatNum AS seatNum, f.ticketNum AS ticketNum FROM flightticketfor f, buy b  WHERE f.ticketNum = b.ticketNum AND b.username = ?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setString(1, user);
		ResultSet result = ps.executeQuery();
		//String query = "SELECT a.username AS username, a.password AS password, a.firstname AS firstname, a.lastname AS lastname FROM account a WHERE a.type=2";

		%>
	<table>
	<tr>    
			<td>User</td>
			<td>Flight Number</td>
			<td>From</td>
			<td>To</td>
			<td>Class</td>
			<td>Seat Number</td>
			<td>Ticket Number</td>
		</tr>
			<%
			//parse out the results
			//we are using fromy and tom cause from and to will not work as they are keywords in sql smh >:(
			while (result.next()) { 
				Integer fClass = Integer.valueOf(result.getString("class"));
				String classType;
				switch (fClass) {
		        case 0:  classType = "Economy";
		                 break;
		        case 1:  classType = "Business";
		                 break;
		        case 2:  classType = "First";
		                 break;
		        default: classType = "Invalid";
		                 break;
		    }
				
			%>
				<tr>    
					<td><%= result.getString("username")%></td>
					<td><%= result.getString("flightNum") %></td>
					<td><%= result.getString("fromy") %></td>
					<td><%= result.getString("tom")%></td>
					<td><%= classType%></td>
					<td><%= result.getString("seatNum") %></td>
					<td><%= result.getString("ticketNum")%></td>
				</tr>
				

			<% }%>
	
	</table>
	
	<br>
		<form method="get" action="AdminHomePage.jsp">
			<input type="submit" value="Return to Home Page">
		</form>
	<br>
	<%
	//close the connection.
		con.close();
		%>
	<%} catch (Exception ex) {
		out.print(ex);
		out.print("One or more field is missing :()");
	}%>
	

</body>
</html>