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
		String queryNotBought = "SELECT * from buy b WHERE b.ticketNum = ?";
		PreparedStatement pd = con.prepareStatement(queryNotBought);
		pd.setInt(1, tikNum);
		ResultSet rs = pd.executeQuery();
		if ( !rs.isBeforeFirst() ) {
			String queryExists = "SELECT * FROM flightticketfor f WHERE f.ticketNum = ?";
			PreparedStatement pd1 = con.prepareStatement(queryExists);
			pd1.setInt(1, tikNum);
			ResultSet rs1 = pd1.executeQuery();
			
			// maybe also check that the customer exists
			
			String queryCustExists = "SELECT * FROM account a WHERE a.username = ?";
			PreparedStatement pd3 = con.prepareStatement(queryCustExists);
			pd3.setString(1, user);
			ResultSet rs2 = pd3.executeQuery();
			
			if( rs1.isBeforeFirst() ){
				if( rs2.isBeforeFirst() ){
					
				String queryBuy = "INSERT INTO buy VALUES (?, ?, ?, ?)";
				PreparedStatement pd2 = con.prepareStatement(queryBuy);
				java.util.Date date = new java.util.Date();
				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
				String fTime = sdf.format(date);
				
				
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
				String fDate = sdf1.format(date);
				
				pd2.setString(1, user);
				pd2.setInt(2, tikNum);
				pd2.setString(3, fDate);
				pd2.setString(4, fTime);
				
				pd2.executeUpdate();
				out.print("ticket number " + tikNum + " bought at " + fDate + " " + fTime + " for " + user + "\n");
						
				}else{
					out.print("no such user \n");
				}
			}else{
				out.print("no such ticket \n");
			}
			
			
		     
		}else{ 
			out.print("selected ticket has already been purchased by some user \n");
		}
	%>
	<br>
	<br>
		<form method="get" action="buyForCust.jsp">
			<input type="submit" value="Reserve More Flights">
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