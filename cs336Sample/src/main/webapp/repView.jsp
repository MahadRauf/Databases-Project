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
		out.print("List of Customer Representative Accounts\n");
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get parameters from the HTML form at the SearchFlight.jsp

		
		
		out.print("\n");
		String query = "SELECT a.username AS username, a.password AS password, a.firstname AS firstname, a.lastname AS lastname FROM account a WHERE a.type=2";
		ResultSet result = stmt.executeQuery(query);
		%>
	<table>
	<tr>    
			<td>Username</td>
			<td>Password</td>
			<td>First Name</td>
			<td>Last Name</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("username") %></td>
					<td><%= result.getString("password")%></td>
					<td><%= result.getString("firstname") %></td>
					<td><%= result.getString("lastname")%></td>
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