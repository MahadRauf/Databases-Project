<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Airports - Representative</title>
</head>
<body>
	
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String threeLetID = request.getParameter("threeLetID");
		
		String queryExists = "SELECT * from airport a WHERE a.threeLetID = ?";
		PreparedStatement pd = con.prepareStatement(queryExists);
		pd.setString(1, threeLetID);
		ResultSet rs = pd.executeQuery();
		

		if ( !rs.isBeforeFirst() ) {
			
			String queryAdd = "INSERT INTO airport VALUES (?)";
			PreparedStatement pd1 = con.prepareStatement(queryAdd);
			
			pd1.setString(1, threeLetID);
			pd1.executeUpdate();
			%>
			<br>
			<%
			out.print("Airport Successfully Added");%>
			<br>
			<%out.print("Airport: " + threeLetID + "\n");%>
			<br>
	<br>
		     <%
		}else{ 
			out.print("Airport already exists \n");
		}
	%>
	<br>
	<br>
		<form method="get" action="changeAP.jsp">
			<input type="submit" value="Change More Airports">
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
	}%>
	

</body>
</html>