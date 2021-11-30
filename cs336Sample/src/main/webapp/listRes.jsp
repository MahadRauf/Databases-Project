<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>List of reservations</title>
</head>
<body>

<br> <!-- view all users with reservations  --> 
	<form method="get" action="listResUserView.jsp">
		<input type="submit" value="View all users with reservations">
	</form>
<br>

<br> <!-- view all flights with reservations  --> 
	<form method="get" action="listResFlightView.jsp">
		<input type="submit" value="View all flights with reservations">
	</form>
<br>



Search for reservations by user
<br> <!-- give list of res by user  --> 
	<form method="get" action="listResUser.jsp">
	<table>	
		<tr>    
		<td>User</td><td><input type="text" name="user"></td>
		</tr>
		</table>
		<input type="submit" value="Enter Username">
	</form>
<br>

Search for reservations by flight number
<br> <!-- give list of res by flight num  --> 
	<form method="get" action="listResFlight.jsp">
	<table>	
		<tr>    
		<td>Flight Number</td><td><input type="text" name="flightNum"></td>
		</tr>
		</table>
		<input type="submit" value="Enter Flight Number">
	</form>
<br>



<br> <!-- return to admin homepage(DONE)  --> 
	<form method="get" action="AdminHomePage.jsp">
		<input type="submit" value="Return">
	</form>
<br>

</body>
</html>