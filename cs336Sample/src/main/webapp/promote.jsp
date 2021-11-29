<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Promote</title>
</head>
<body>


	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		//String name = request.getParameter("username");
		String username = request.getParameter("username");
		//made constant to maintain usability

	
		String select = "SELECT username, type FROM account WHERE username = ? AND type = 0";
		PreparedStatement pd = con.prepareStatement(select);
		pd.setString(1, username);
		ResultSet rs = pd.executeQuery();
		if(!rs.next()){
			response.sendRedirect("userPromote.jsp");
		}
		
		//Make an insert statement for the accounts table:
		//String update = "INSERT INTO account(username, password, type, lastname, firstname)"
			//	+ "VALUES (?, ?, ?, ?, ?)";
		
		String update1 = "UPDATE account SET type = 2 WHERE username = ?";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(update1);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, username);
		//Run the query against the DB
		ps.executeUpdate();
		//Run the query against the DB
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Account succesfully promoted.");
		
%>		
Return to Admin Home Page
	<br>
		<form method="get" action="AdminHomePage.jsp">
			<input type="submit" value="Return!">
		</form>
	<br>
	<%
	} 
	
	
	catch (Exception ex) {
		out.print(ex);
		out.print("update failed");
		
	}
%>

</body>
</html>
