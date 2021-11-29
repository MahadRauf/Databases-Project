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

		
		
		out.print("\n");
		String query = "SELECT Q.questionNum AS questionNum, Q.Question AS Question FROM Questions Q WHERE Q.Answer = 'N/A'";
		ResultSet result = stmt.executeQuery(query);
		%>
	<table>
	<tr>    
			<td>Question Number</td>
			<td>Question</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
					<td><%= result.getString("questionNum") %></td>
					<td><%= result.getString("Question")%></td>
				</tr>
				

			<% }%>
	
	</table>
	<br>
		<form method="get" action="AnswerQ.jsp">
			<table>
				<tr>    
					<td>Question Number</td><td><input type="text" name="qNum"></td>
				</tr>
				<tr>
					<td>Answer</td><td><input type="text" name="Answer"></td>
				</tr>
			</table>
			<input type="submit" value="Answer">
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