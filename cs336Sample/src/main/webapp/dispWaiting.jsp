<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Q&A - Representative</title>
</head>
<body>
	<% try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get parameters from the HTML form at the SearchFlight.jsp

		String fPort = request.getParameter("fPort");
		String tPort = request.getParameter("tPort");
		Integer type = Integer.valueOf(request.getParameter("type"));
		String s;
		if(type == 0){
			s = "One-Way";
		}else{
			s = "Round-Trip";
		}
		
		out.print("\n");
		String query = "SELECT DISTINCT w.username AS user FROM waits w, flightticketfor f WHERE w.ticketNum = f.ticketNum AND f.from = ? AND f.to = ? AND f.type = ?";
		PreparedStatement pd = con.prepareStatement(query);
		pd.setString(1, fPort);
		pd.setString(2, tPort);
		pd.setInt(3, type);
		ResultSet result = pd.executeQuery();
		%>
	<table>
	<tr>    
			<td>Users Waiting for <% out.print(s + "flight from " + fPort + " to " + tPort); %></td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("user") %></td>
				</tr>
				

			<% }%>
	
	</table>
	<br>
		<form method="get" action="onWaitList.jsp">
			<input type="submit" value="View other waiting lists">
		</form>
	<br>
	
	<br>
		<form method="get" action="RepHomePage.jsp">
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