<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Get parameters from the HTML form at the SearchFlight.jsp
		Integer isOneWay = request.getParameter("isOneWay");
		Integer isDomestic = request.getParameter("isDomestic");
		String tripStart = request.getParameter("tripStart");
		String tripEnd = request.getParameter("tripEnd");
		
		String select = "SELECT username, password, type FROM account WHERE username = ? AND password = ?";
		//Run the query against the database.
		
		PreparedStatement ps = con.prepareStatement(select);
		ps.setString(1, username);
		ps.setString(2, password);
		ResultSet rs = ps.executeQuery();
		
		if(rs.next()){
			
			out.print("Login succeeded!");
			out.print(rs.getString("username"));
			if(rs.getInt("type")==0){
				%>		
				<br>
					<form method="get" action="UserHomePage.jsp">
						<input type="submit" value="Home Page!">
					</form>
				<br>
				<%
			}
		
			%>		
				<br>
					<form method="get" action="HelloWorld.jsp">
						<input type="submit" value="Log out!">
					</form>
				<br>
				<%
			con.close();
		}
		else{
			//out.print("incorrect username/password");
			response.sendRedirect("HelloWorld.jsp");
		}
		
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login failed :()");
	}
%>
</body>
</html>