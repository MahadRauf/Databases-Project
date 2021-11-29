<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reserve - Representative</title>
</head>
<body>
	
	<% try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String user = request.getParameter("user");
		Integer tikNum = Integer.valueOf(request.getParameter("tikNum"));
		String queryIsBought = "SELECT * from buy b WHERE b.ticketNum = ? AND b.username = ?";
		PreparedStatement pd = con.prepareStatement(queryIsBought);
		pd.setInt(1, tikNum);
		pd.setString(2, user);
		ResultSet rs = pd.executeQuery();
		if ( rs.isBeforeFirst() ) {
			String queryExists = "SELECT f.class AS class FROM flightticketfor f WHERE f.ticketNum = ?";
			PreparedStatement pd1 = con.prepareStatement(queryExists);
			pd1.setInt(1, tikNum);
			ResultSet rs1 = pd1.executeQuery();
			if( rs1.isBeforeFirst() ){
				rs1.next();
				Integer fClass = Integer.valueOf(rs1.getString("class"));
				
				String queryDelete = "DELETE FROM buy AS b WHERE b.ticketNum = ? AND b.username = ?";
				PreparedStatement pd2 = con.prepareStatement(queryDelete);
				
				
				pd2.setInt(1, tikNum);
				pd2.setString(2, user);
				
				pd2.executeUpdate();
				out.print("reservation for ticket number " + tikNum + " cancelled " + "for " + user + "\n");%>
				<br>
				<%
				if(fClass == 0){
					out.println("user must pay a cancellation fee \n");
				}
				
			}else{
				out.print("no such ticket \n");
			}
			
			
		     
		}else{ 
			out.print("no such reservation exists \n");
		}
	%>
	<br>
	<br>
		<form method="get" action="deleteForCust.jsp">
			<input type="submit" value="Cancel More Flights">
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