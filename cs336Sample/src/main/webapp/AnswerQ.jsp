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
		Integer qNum = Integer.valueOf(request.getParameter("qNum"));
		String ans = request.getParameter("Answer");

		
		out.print("\n");
		String query = "UPDATE Questions SET Answer = ? WHERE questionNum = ?";
		PreparedStatement pd = con.prepareStatement(query);
		pd.setString(1, ans);
		pd.setInt(2, qNum);
		pd.executeUpdate();
		%>
		Question Answered!
	<br>
		<form method="get" action="QToAnswer.jsp">
			<input type="submit" value="Answer More Questions">
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