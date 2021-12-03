<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Aircrafts - Representative</title>
</head>
<body>
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	%>
	<br>
	No airport edit function as it only has a primary key.
	<br>
	
	<br>
	Delete an Existing Airport
		<form method="get" action="delExistingAP.jsp">
			<table>
				<tr>    
					<td>Three Letter Airport ID(Capital)</td><td><input type="text" name="threeLetID" required></td>
				</tr>		
			</table>
			<input type="submit" value="Delete">
		</form>
	<br>
	
	<br>
	Add an Airport
		<form method="get" action="addAP.jsp">
			<table>
				<tr>    
					<td>Three Letter Airport ID(Capital)</td><td><input type="text" name="threeLetID" required></td>
				</tr>	
			</table>
			<input type="submit" value="Add">
		</form>
	<br>
	
	<br>
		<form method="get" action="RepHomePage.jsp">
			<input type="submit" value="Return to Home Page">
		</form>
	<br>
		<% con.close(); %>
	<%} catch (Exception ex) {
		out.print(ex);
		out.print("One or more field is missing :()");
	}%>
	

</body>
</html>